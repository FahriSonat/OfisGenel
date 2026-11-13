import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/support_role.dart';
import '../widgets/space_scaffold.dart';

/// [LawyerSpaceScreen]
/// Hukuki Danışmanlık Destek Alanı Ekranı (/space/lawyer).
/// - Ortak [SpaceScaffold] yapısını kullanır.
/// - Sadece Avukat Desteği planlama ve yasal sözleşme araçlarını sunar.
/// - Kurucu ortaklar sözleşmesi (SHA), vesting ve gizlilik (NDA) süreçlerini özetler.
class LawyerSpaceScreen extends StatelessWidget {
  const LawyerSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SpaceScaffold(
      role: SupportRole.lawyer,
      roleSections: [
        Text(
          'Hukuki Dokümantasyon ve İnceleme',
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
                    const Icon(Icons.assignment_outlined, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Kurucu Ortaklar Sözleşmesi (Founders Agreement)',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Hisse hak edişi (vesting), ayrılma şartları ve fikri mülkiyet devir maddelerini hukuk uzmanınızla netleştirin.',
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
