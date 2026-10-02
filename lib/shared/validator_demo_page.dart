import 'package:flutter/material.dart';

import 'package:ec_validator/shared/app_strings.dart';
import 'package:ec_validator/shared/code_snippet.dart';
import 'package:ec_validator/shared/demo_result.dart';
import 'package:ec_validator/shared/example_tile.dart';
import 'package:ec_validator/shared/result_panel.dart';

/// Width from which the playground and the examples sit side by side.
const double _twoColumnBreakpoint = 960;

/// Interactive page shared by every validator: a live form, the full result,
/// the equivalent Dart code and a list of examples to try.
class ValidatorDemoPage extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final String inputLabel;
  final String inputHint;
  final TextInputType keyboardType;

  /// Optional controls shown above the input, such as the validation mode.
  final Widget? modeSelector;

  final DemoResult Function(String value) validate;

  /// Dart expression that validates [value], shown in the code snippet.
  final String Function(String value) codeFor;

  final List<String> examples;
  final bool showNormalized;

  const ValidatorDemoPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.inputLabel,
    required this.inputHint,
    required this.keyboardType,
    required this.validate,
    required this.codeFor,
    required this.examples,
    this.modeSelector,
    this.showNormalized = false,
  });

  @override
  State<ValidatorDemoPage> createState() => _ValidatorDemoPageState();
}

class _ValidatorDemoPageState extends State<ValidatorDemoPage> {
  final _controller = TextEditingController();
  final _inputKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tryExample(String value) {
    _controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
    final inputContext = _inputKey.currentContext;
    if (inputContext != null) {
      Scrollable.ensureVisible(
        inputContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
      );
    }
  }

  String _code(String value) {
    final escaped = value.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
    final result = widget.validate(value);
    final buffer = StringBuffer()
      ..writeln("import 'package:ec_validations/ec_validations.dart';")
      ..writeln()
      ..writeln('final result = ${widget.codeFor("'$escaped'")};')
      ..write('result.isValid; // ${result.isValid}');
    if (widget.showNormalized) {
      buffer.write('\nresult.normalizedNumber; // ${result.normalizedNumber}');
    }
    if (!result.isValid) {
      buffer.write('\nresult.typeCodeError; // ${result.typeCodeError}');
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    // Rebuilds with the language too, so the messages follow it.
    AppStrings.of(context);
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) => LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final horizontalPadding = width < 600 ? 16.0 : 32.0;
          final twoColumns = width >= _twoColumnBreakpoint;

          final playground = _buildPlayground(context, compact: width < 600);
          final examples = _buildExamples(context);

          return SelectionArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                24,
                horizontalPadding,
                32,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 24),
                      if (twoColumns)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 6, child: playground),
                            const SizedBox(width: 24),
                            Expanded(flex: 5, child: examples),
                          ],
                        )
                      else ...[
                        playground,
                        const SizedBox(height: 32),
                        examples,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(widget.icon, color: scheme.onPrimaryContainer),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlayground(BuildContext context, {required bool compact}) {
    final theme = Theme.of(context);
    final value = _controller.text;
    final hasValue = value.isNotEmpty;
    final result = widget.validate(value);
    final strings = AppStrings.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(compact ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.tryIt, style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            if (widget.modeSelector != null) ...[
              widget.modeSelector!,
              const SizedBox(height: 20),
            ],
            TextField(
              key: _inputKey,
              controller: _controller,
              keyboardType: widget.keyboardType,
              autocorrect: false,
              enableSuggestions: false,
              textInputAction: TextInputAction.done,
              style: theme.textTheme.titleMedium?.copyWith(letterSpacing: 0.5),
              decoration: InputDecoration(
                labelText: widget.inputLabel,
                hintText: widget.inputHint,
                prefixIcon: Icon(widget.icon),
                helperText: strings.validatedAsYouType,
                suffixIcon: hasValue
                    ? IconButton(
                        tooltip: strings.clear,
                        icon: const Icon(Icons.close),
                        onPressed: _controller.clear,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: hasValue
                  ? ResultPanel(
                      key: const ValueKey('result'),
                      result: result,
                      showNormalized: widget.showNormalized,
                    )
                  : const _EmptyResult(key: ValueKey('empty')),
            ),
            const SizedBox(height: 20),
            CodeSnippet(code: _code(hasValue ? value : widget.inputHint)),
          ],
        ),
      ),
    );
  }

  Widget _buildExamples(BuildContext context) {
    final theme = Theme.of(context);
    final strings = AppStrings.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(strings.examples, style: theme.textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(
          strings.examplesHint,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        for (final example in widget.examples) ...[
          ExampleTile(
            value: example,
            result: widget.validate(example),
            selected: example == _controller.text,
            onTap: () => _tryExample(example),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _EmptyResult extends StatelessWidget {
  const _EmptyResult({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.touch_app_outlined, color: scheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              AppStrings.of(context).emptyResult,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
