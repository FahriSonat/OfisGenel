import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/support_role.dart';
import '../widgets/space_scaffold.dart';

/// [AccountantSpaceScreen]
/// Mali Müşavirlik & Muhasebe Destek Alanı Ekranı (/space/accountant).
/// - Ortak [SpaceScaffold] yapısını kullanır.
/// - Sadece Muhasebe Desteği planlama ve finansal araçları barındırır.
/// - Vergi takvimi, KDV, muhtasar ve beyanname dönemlerini hatırlatır.
class AccountantSpaceScreen extends StatelessWidget {
  const AccountantSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SpaceScaffold(
      role: SupportRole.accountant,
      roleSections: [
        Text(
          'Mali Takvim ve Hatırlatmalar',
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
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'KDV ve Muhtasar Beyanname Dönemi',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Ayın 26’sına kadar faturalarınızı ve gider makbuzlarınızı sisteme yükleyiniz.',
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
