import 'package:flutter/material.dart';

import 'package:ec_validator/pages/index.dart';
import 'package:ec_validator/shared/language_selector.dart';

/// Below this width the app uses a bottom navigation bar.
const double _compactBreakpoint = 640;

/// From this width the navigation rail shows its labels beside the icons.
const double _extendedBreakpoint = 1100;

class _Destination {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _Destination(this.icon, this.selectedIcon, this.label);
}

const _destinations = [
  _Destination(Icons.badge_outlined, Icons.badge, 'ID card'),
  _Destination(Icons.business_outlined, Icons.business, 'RUC'),
  _Destination(Icons.phone_outlined, Icons.phone, 'Phone'),
];

/// Responsive scaffold: bottom bar on phones, navigation rail on wider screens.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) =>
      setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < _compactBreakpoint;

    // IndexedStack keeps each page's input when switching tabs.
    final pages = IndexedStack(
      index: _selectedIndex,
      children: const [
        DniValidatorPage(),
        RucValidatorPage(),
        PhoneValidatorPage(),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        titleSpacing: compact ? 16 : 24,
        title: const _AppTitle(),
        actions: [
          LanguageSelector(compact: compact),
          SizedBox(width: compact ? 8 : 24),
        ],
      ),
      body: compact
          ? pages
          : Row(
              children: [
                NavigationRail(
                  extended: width >= _extendedBreakpoint,
                  labelType: width >= _extendedBreakpoint
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onDestinationSelected,
                  destinations: _destinations
                      .map(
                        (destination) => NavigationRailDestination(
                          icon: Icon(destination.icon),
                          selectedIcon: Icon(destination.selectedIcon),
                          label: Text(destination.label),
                        ),
                      )
                      .toList(),
                ),
                const VerticalDivider(width: 1),
                Expanded(child: pages),
              ],
            ),
      bottomNavigationBar: compact
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
              destinations: _destinations
                  .map(
                    (destination) => NavigationDestination(
                      icon: Icon(destination.icon),
                      selectedIcon: Icon(destination.selectedIcon),
                      label: destination.label,
                    ),
                  )
                  .toList(),
            )
          : null,
    );
  }
}

class _AppTitle extends StatelessWidget {
  const _AppTitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'EC',
            style: theme.textTheme.labelLarge?.copyWith(
              color: scheme.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ec_validations',
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Interactive demo',
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
