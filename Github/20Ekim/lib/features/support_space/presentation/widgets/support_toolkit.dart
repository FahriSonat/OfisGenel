import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/role_style.dart';
import '../../domain/entities/support_role.dart';

class ToolkitItemData {
  final String title;
  final IconData icon;
  final String path;
  final bool isSpecial;

  const ToolkitItemData({
    required this.title,
    required this.icon,
    required this.path,
    this.isSpecial = false,
  });
}

class SupportToolkit extends StatelessWidget {
  final SupportRole currentRole;

  const SupportToolkit({
    super.key,
    required this.currentRole,
  });

  List<ToolkitItemData> _buildItems(String roleSlug) {
    // 1. Ortak 4 Araç
    final baseItems = [
      ToolkitItemData(
        title: 'AI Sohbet',
        icon: Icons.smart_toy_outlined,
        path: AppRoutes.aiChatPath(roleSlug),
      ),
      ToolkitItemData(
        title: 'Dosya Yükleme',
        icon: Icons.upload_file_outlined,
        path: AppRoutes.filesPath(roleSlug),
      ),
      ToolkitItemData(
        title: 'Kullanıcı Sohbeti',
        icon: Icons.forum_outlined,
        path: AppRoutes.chatPath(roleSlug),
      ),
      ToolkitItemData(
        title: 'Toplantı Planla',
        icon: Icons.event_outlined,
        path: AppRoutes.meetingsPath(roleSlug),
      ),
    ];

    // 2. Her rolün SADECE kendi destek aracı
    switch (currentRole) {
      case SupportRole.mentor:
        baseItems.add(
          ToolkitItemData(
            title: 'Mentorluk Desteği',
            icon: Icons.school_outlined,
            path: AppRoutes.bookingPath('mentor', 'mentor'),
            isSpecial: true,
          ),
        );
        break;
      case SupportRole.lawyer:
        baseItems.add(
          ToolkitItemData(
            title: 'Avukat Desteği',
            icon: Icons.gavel_outlined,
            path: AppRoutes.bookingPath('lawyer', 'lawyer'),
            isSpecial: true,
          ),
        );
        break;
      case SupportRole.marketing:
        baseItems.add(
          ToolkitItemData(
            title: 'Pazarlama Desteği',
            icon: Icons.campaign_outlined,
            path: AppRoutes.bookingPath('marketing', 'marketing'),
            isSpecial: true,
          ),
        );
        break;
      case SupportRole.accountant:
        baseItems.add(
          ToolkitItemData(
            title: 'Muhasebe Desteği',
            icon: Icons.calculate_outlined,
            path: AppRoutes.bookingPath('accountant', 'accountant'),
            isSpecial: true,
          ),
        );
        break;
      case SupportRole.investor:
        baseItems.add(
          ToolkitItemData(
            title: 'Yatırımcı Görüşmesi',
            icon: Icons.trending_up,
            path: AppRoutes.bookingPath('investor', 'mentor'),
            isSpecial: true,
          ),
        );
        baseItems.add(
          ToolkitItemData(
            title: 'Girişimleri İncele',
            icon: Icons.visibility_outlined,
            path: AppRoutes.investorStartupsPath(),
            isSpecial: true,
          ),
        );
        break;
    }

    return baseItems;
  }

  @override
  Widget build(BuildContext context) {
    final items = _buildItems(currentRole.name);

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            mainAxisExtent: 110,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _ToolkitTile(
              item: items[index],
              accentColor: currentRole.accent,
            );
          },
        );
      },
    );
  }
}

class _ToolkitTile extends StatelessWidget {
  final ToolkitItemData item;
  final Color accentColor;

  const _ToolkitTile({
    required this.item,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            side: item.isSpecial
                ? BorderSide(color: accentColor, width: 1.5)
                : BorderSide(color: theme.colorScheme.outlineVariant),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            onTap: () => context.go(item.path),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    size: 28,
                    color: accentColor,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(
                    height: 34,
                    child: Center(
                      child: Text(
                        item.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontSize: 13,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (item.isSpecial)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Özel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
