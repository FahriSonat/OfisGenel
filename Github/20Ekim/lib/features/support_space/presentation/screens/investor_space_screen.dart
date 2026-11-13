import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/support_role.dart';
import '../widgets/space_scaffold.dart';

/// [InvestorSpaceScreen]
/// Yatırımcı Destek Alanı Ekranı (/space/investor).
/// - Ortak [SpaceScaffold] yapısını kullanır.
/// - Yatırımcı Görüşmesi planlama ve Girişim Keşif (Dealflow) vitrini erişimini sağlar.
/// - Pitch Deck hazırlığı, Cap Table kontrolü ve yatırım turu süreçlerini özetler.
class InvestorSpaceScreen extends StatelessWidget {
  const InvestorSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SpaceScaffold(
      role: SupportRole.investor,
      roleSections: [
        // Girişim İnceleme Hızlı Erişim Kartı: Yatırımcıları doğrudan dealflow sayfasına yönlendirir
        Card(
          color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: const Icon(
                    Icons.travel_explore,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Girişim Keşif & Dealflow Vitrini',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Yatırım turundaki güncel teknoloji girişimlerini metrikleriyle inceleyin.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                FilledButton.icon(
                  onPressed: () {
                    context.go(AppRoutes.investorStartupsPath());
                  },
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('İncele'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        Text(
          'Yatırımcı Hazırlık Süreci',
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
                    const Icon(Icons.pie_chart_outline, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Pitch Deck ve Cap Table Kontrolü',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Yatırımcı sunumunuzun 10-12 slaytlık standart yapıda olduğundan ve hisse dağılım tablonuzun güncel olduğundan emin olun.',
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
