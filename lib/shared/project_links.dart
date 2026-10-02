import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import 'package:ec_validator/shared/app_strings.dart';

const authorName = 'JaviKo500';
final authorUrl = Uri.parse('https://github.com/JaviKo500');
final pubDevUrl = Uri.parse('https://pub.dev/packages/ec_validations');
final packageSourceUrl = Uri.parse(
  'https://github.com/JaviKo500/ec_validations',
);
final demoSourceUrl = Uri.parse('https://github.com/JaviKo500/ec-validator');
final issuesUrl = Uri.parse(
  'https://github.com/JaviKo500/ec_validations/issues',
);

/// Text button that opens [uri] in a new tab, as a real link on the web.
class ProjectLinkButton extends StatelessWidget {
  final Uri uri;
  final IconData icon;
  final String label;

  const ProjectLinkButton({
    super.key,
    required this.uri,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: uri,
      target: LinkTarget.blank,
      builder: (context, followLink) => TextButton.icon(
        onPressed: followLink,
        icon: Icon(icon, size: 18),
        label: Text(label),
      ),
    );
  }
}

/// Every project link, laid out as a wrapping row of buttons.
class ProjectLinks extends StatelessWidget {
  final WrapAlignment alignment;

  const ProjectLinks({super.key, this.alignment = WrapAlignment.start});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return Wrap(
      alignment: alignment,
      spacing: 4,
      runSpacing: 4,
      children: [
        ProjectLinkButton(
          uri: pubDevUrl,
          icon: Icons.inventory_2_outlined,
          label: strings.linkPubDev,
        ),
        ProjectLinkButton(
          uri: packageSourceUrl,
          icon: Icons.code,
          label: strings.linkPackageSource,
        ),
        ProjectLinkButton(
          uri: demoSourceUrl,
          icon: Icons.web_outlined,
          label: strings.linkDemoSource,
        ),
        ProjectLinkButton(
          uri: issuesUrl,
          icon: Icons.bug_report_outlined,
          label: strings.linkIssues,
        ),
      ],
    );
  }
}

/// "Made by" line linking to the author's profile.
class AuthorCredit extends StatelessWidget {
  const AuthorCredit({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${AppStrings.of(context).madeBy} ',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        Link(
          uri: authorUrl,
          target: LinkTarget.blank,
          builder: (context, followLink) => InkWell(
            onTap: followLink,
            borderRadius: BorderRadius.circular(4),
            child: Text(
              '@$authorName',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Footer with the package credit and its links, shown under each page.
class CreditsFooter extends StatelessWidget {
  const CreditsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const Divider(height: 48),
        Text(
          AppStrings.of(context).aboutDescription,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        const AuthorCredit(),
        const SizedBox(height: 8),
        const ProjectLinks(alignment: WrapAlignment.center),
      ],
    );
  }
}

/// Bottom sheet with the credit and links, for screens without room for them
/// in the app bar.
void showAboutSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      final theme = Theme.of(context);
      final strings = AppStrings.of(context);

      return SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ec_validations', style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(strings.aboutDescription),
              const SizedBox(height: 12),
              const AuthorCredit(),
              const SizedBox(height: 12),
              const ProjectLinks(),
            ],
          ),
        ),
      );
    },
  );
}
