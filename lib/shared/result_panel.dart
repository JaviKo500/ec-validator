import 'package:flutter/material.dart';

import 'package:ec_validator/shared/app_strings.dart';
import 'package:ec_validator/shared/app_theme.dart';
import 'package:ec_validator/shared/demo_result.dart';
import 'package:ec_validator/shared/messages_locale.dart';

/// Shows every field of a validation result, named as in the package API.
class ResultPanel extends StatelessWidget {
  final DemoResult result;
  final bool showNormalized;

  const ResultPanel({
    super.key,
    required this.result,
    this.showNormalized = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final background = result.isValid
        ? scheme.successContainer
        : scheme.errorContainer;
    final foreground = result.isValid
        ? scheme.onSuccessContainer
        : scheme.onErrorContainer;
    final strings = AppStrings.of(context);
    final locale = messagesLocale.value.toUpperCase();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                result.isValid ? Icons.check_circle : Icons.cancel,
                color: foreground,
              ),
              const SizedBox(width: 8),
              Text(
                result.isValid ? strings.valid : strings.invalid,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _Field(
            name: 'isValid',
            value: '${result.isValid}',
            color: foreground,
          ),
          if (showNormalized)
            _Field(
              name: 'normalizedNumber',
              value: result.normalizedNumber,
              color: foreground,
            ),
          _Field(
            name: 'typeCodeError',
            value: result.typeCodeError,
            color: foreground,
          ),
          _Field(
            name: 'errorMessage ($locale)',
            value: result.errorMessage,
            color: foreground,
          ),
          _Field(
            name: 'messageIn(EcMessagesEn())',
            value: result.messageInEn,
            color: foreground,
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String name;
  final String? value;
  final Color color;

  const _Field({required this.name, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: textTheme.labelSmall?.copyWith(
              color: color.withValues(alpha: 0.75),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value ?? 'null',
            style: textTheme.bodyMedium?.copyWith(
              color: value == null ? color.withValues(alpha: 0.6) : color,
              fontStyle: value == null ? FontStyle.italic : null,
            ),
          ),
        ],
      ),
    );
  }
}
