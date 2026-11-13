import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/link_launcher.dart';
import '../../domain/entities/program_link.dart';

class ApplyButtonGroup extends StatelessWidget {
  final List<ProgramLink> links;
  final LinkLauncher linkLauncher;

  const ApplyButtonGroup({
    super.key,
    required this.links,
    this.linkLauncher = const PlaceholderLinkLauncher(),
  });

  @override
  Widget build(BuildContext context) {
    final validLinks = links.where((link) => link.isValidHttps).toList();
    if (validLinks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < validLinks.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.sm),
          _buildButton(context, validLinks[i]),
        ],
      ],
    );
  }

  Widget _buildButton(BuildContext context, ProgramLink link) {
    void handlePress() {
      linkLauncher.launch(link.url);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${link.label} açılıyor: ${link.url}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    if (link.type == ProgramLinkType.applicationForm) {
      return FilledButton.icon(
        onPressed: handlePress,
        icon: const Icon(Icons.open_in_new, size: 18),
        label: Text(link.label),
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      );
    }

    return OutlinedButton.icon(
      onPressed: handlePress,
      icon: const Icon(Icons.info_outline, size: 18),
      label: Text(link.label),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),
    );
  }
}
