import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Dart code block with a copy button.
class CodeSnippet extends StatelessWidget {
  final String code;

  const CodeSnippet({super.key, required this.code});

  void _copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Code copied to clipboard'),
          behavior: SnackBarBehavior.floating,
          width: 280,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    final background = isDark
        ? scheme.surfaceContainerHighest
        : scheme.inverseSurface;
    final foreground = isDark ? scheme.onSurface : scheme.onInverseSurface;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 4, 0),
            child: Row(
              children: [
                Text(
                  'Dart',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: foreground.withValues(alpha: 0.7),
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _copy(context),
                  style: TextButton.styleFrom(foregroundColor: foreground),
                  icon: const Icon(Icons.copy_rounded, size: 16),
                  label: const Text('Copy'),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: foreground.withValues(alpha: 0.15)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Text(
              code,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: foreground,
                height: 1.6,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
