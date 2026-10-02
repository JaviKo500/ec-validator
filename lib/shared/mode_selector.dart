import 'package:flutter/material.dart';

/// A validation mode offered by a page, with a short explanation.
class DemoMode<T> {
  final T value;
  final String label;
  final String description;

  const DemoMode({
    required this.value,
    required this.label,
    required this.description,
  });
}

/// Wrapping row of chips to pick the validation mode.
class ModeSelector<T> extends StatelessWidget {
  final String label;
  final List<DemoMode<T>> modes;
  final T selected;
  final ValueChanged<T> onChanged;

  const ModeSelector({
    super.key,
    required this.label,
    required this.modes,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final current = modes.firstWhere((mode) => mode.value == selected);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: modes
              .map(
                (mode) => ChoiceChip(
                  label: Text(mode.label),
                  selected: mode.value == selected,
                  onSelected: (_) => onChanged(mode.value),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        Text(
          current.description,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
