import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/support_role.dart';
import '../widgets/space_scaffold.dart';

/// [MentorSpaceScreen]
/// Mentorluk Destek Alanı Ekranı (/space/mentor).
/// - Ortak [SpaceScaffold] yapısını kullanır.
/// - Sadece Mentorluk Desteği ve ortak iletişim araçlarını sunar.
/// - Rol bölümünde İş Modeli ve PMF (Ürün-Pazar Uyumu) odak konularını öne çıkarır.
class MentorSpaceScreen extends StatelessWidget {
  const MentorSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SpaceScaffold(
      role: SupportRole.mentor,
      roleSections: [
        Text(
          'Öne Çıkan Mentorluk Konuları',
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
                    const Icon(Icons.lightbulb_outline, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'İş Modeli ve Ürün-Pazar Uyumu (PMF)',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Hedef kitlenizi doğrulayın, müşteri görüşmelerini yapılandırın ve değer önerinizi netleştirin.',
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
