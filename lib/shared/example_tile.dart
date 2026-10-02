import 'package:flutter/material.dart';

import 'package:ec_validator/shared/app_theme.dart';
import 'package:ec_validator/shared/demo_result.dart';

/// Sample value with its validation outcome; tapping it loads it in the form.
class ExampleTile extends StatelessWidget {
  final String value;
  final DemoResult result;
  final bool selected;
  final VoidCallback onTap;

  const ExampleTile({
    super.key,
    required this.value,
    required this.result,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final statusColor = result.isValid ? scheme.success : scheme.error;
    final detail = result.isValid
        ? (result.normalizedNumber != null
              ? 'Normalized: ${result.normalizedNumber}'
              : 'Valid')
        : result.errorMessage ?? 'Invalid';

    return Card(
      color: selected ? scheme.secondaryContainer : null,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                result.isValid ? Icons.check_circle : Icons.cancel,
                color: statusColor,
                semanticLabel: result.isValid ? 'Valid' : 'Invalid',
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontFeatures: const [FontFeature.tabularFigures()],
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      detail,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.north_west_rounded,
                size: 18,
                color: scheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
