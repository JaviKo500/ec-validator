import 'package:flutter/material.dart';

import 'package:ec_validator/shared/messages_locale.dart';

/// Picks the language of the validation messages.
///
/// Shows a segmented control when there is room, and a menu when [compact].
class LanguageSelector extends StatelessWidget {
  final bool compact;

  const LanguageSelector({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: messagesLocale,
      builder: (context, current, _) =>
          compact ? _buildMenu(context, current) : _buildSegments(current),
    );
  }

  Widget _buildSegments(String current) {
    return Tooltip(
      message: 'Language of the validation messages',
      child: SegmentedButton<String>(
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        segments: messageLanguages.keys
            .map(
              (code) => ButtonSegment(
                value: code,
                label: Text(code.toUpperCase()),
                tooltip: messageLanguages[code],
              ),
            )
            .toList(),
        selected: {current},
        onSelectionChanged: (selection) => useMessagesLocale(selection.first),
      ),
    );
  }

  Widget _buildMenu(BuildContext context, String current) {
    return PopupMenuButton<String>(
      tooltip: 'Language of the validation messages',
      initialValue: current,
      onSelected: useMessagesLocale,
      itemBuilder: (context) => messageLanguages.entries
          .map(
            (entry) => CheckedPopupMenuItem(
              value: entry.key,
              checked: entry.key == current,
              child: Text(entry.value),
            ),
          )
          .toList(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.translate, size: 20),
            const SizedBox(width: 6),
            Text(
              current.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
