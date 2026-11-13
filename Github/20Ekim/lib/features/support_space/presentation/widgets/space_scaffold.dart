import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/role_style.dart';
import '../../domain/entities/support_role.dart';
import 'support_toolkit.dart';

/// [SpaceScaffold]
/// Tüm destek alanları (Mentor, Muhasebe, Avukat, Yatırımcı, Pazarlama) için ortak sayfa iskeletidir.
/// Sırasıyla şu 3 ana bileşeni render eder:
/// 1. Rol Başlık Kartı (İkon, Rol Adı, Kısa Açıklama)
/// 2. Destek Araç Kiti (SupportToolkit - 110px eşit ölçülü kartlar)
/// 3. Role Özel Ek Bölümler (roleSections - Danışmanlık ve süreç kartları)
class SpaceScaffold extends StatelessWidget {
  final SupportRole role;
  final List<Widget> roleSections;

  const SpaceScaffold({
    super.key,
    required this.role,
    this.roleSections = const [],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = role.accent;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppConstants.maxContentWidth,
        ),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // 1. Rol Başlık Kartı: İlgili rolün tematik rengini ve özetini sunar
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      child: Icon(
                        role.icon,
                        color: accentColor,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${role.label} Destek Alanı',
                            style: theme.textTheme.headlineSmall,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            role.shortDescription,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // 2. Destek Araç Kiti: Ortak 4 araç ve role özel destek aracı
            Text(
              'Destek Araçları',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            SupportToolkit(currentRole: role),

            // 3. Role Özel İçerik ve Takip Kartları
            if (roleSections.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.lg),
              ...roleSections,
            ],
          ],
        ),
      ),
    );
  }
}
