import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/support_role.dart';
import '../widgets/space_scaffold.dart';

/// [MarketingSpaceScreen]
/// Pazarlama & Büyüme (Growth) Destek Alanı Ekranı (/space/marketing).
/// - Ortak [SpaceScaffold] yapısını kullanır.
/// - Sadece Pazarlama Desteği planlama ve büyüme kanalları araçlarını içerir.
/// - CAC (Müşteri Edinme Maliyeti), LTV ve kullanıcı kazanım taktiklerini özetler.
class MarketingSpaceScreen extends StatelessWidget {
  const MarketingSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SpaceScaffold(
      role: SupportRole.marketing,
      roleSections: [
        Text(
          'Büyüme ve Pazarlama Kanalları',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.show_chart, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'CAC ve LTV Metrik Analizi',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Müşteri edinme maliyeti (CAC) ile müşteri yaşam boyu değerini (LTV) optimize etmek için büyüme deneyleri kurgulayın.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
