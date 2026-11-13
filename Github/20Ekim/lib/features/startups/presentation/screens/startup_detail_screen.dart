import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/startups_providers.dart';
import 'pitch_presentation_screen.dart';

/// [StartupDetailScreen]
/// Kapsamlı Proje ve Yatırımcı Sayfası.
/// - Üst Kısım: "Yatırımcı Pitch Deck Sunumu" başlatan interaktif sunum banner'ı.
/// - Finansman ve Metrik Paneli: Hedef fon, toplanan miktar, ilerleme barı, MRR, büyüme oranı.
/// - Girişim Detayı: Değer önerisi, kurucu ortaklar ve ekip büyüklüğü.
/// - Pitch Fihristi: Sunumda yer alan 5 slaytın özet kontrol listesi.
class StartupDetailScreen extends ConsumerWidget {
  final String startupId;

  const StartupDetailScreen({
    super.key,
    required this.startupId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startupAsync = ref.watch(startupDetailProvider(startupId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proje & Yatırımcı Sayfası'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: startupAsync.when(
            data: (startup) {
              if (startup == null) {
                return const Center(child: Text('Girişim bulunamadı.'));
              }

              return ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  // 1. Canlı Yatırımcı Sunumu Başlatma Banner'ı
                  Card(
                    color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: const Icon(
                              Icons.slideshow,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Yatırımcı Pitch Deck Sunumu',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Problem, Çözüm, Pazar ve Finansal Slaytları interaktif sunum modunda inceleyin.',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          // Canlı sunum moduna geçiş butonu
                          FilledButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => PitchPresentationScreen(
                                    startup: startup,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Sunumu Başlat'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // 2. Başlık ve Aşama Kartı
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          startup.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Chip(
                        label: Text(
                          startup.stage,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    startup.tagLine,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // 3. Finansman & Çekiş Durumu Paneli
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Finansman & Yatırım Turu',
                              style: theme.textTheme.titleMedium),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Hedef: ${startup.formattedFundingGoal}'),
                              Text('Toplanan: ${startup.formattedRaised}'),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: startup.fundingProgress,
                              minHeight: 8,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _DetailStat(title: 'MRR', value: startup.mrr),
                              _DetailStat(
                                  title: 'Büyüme', value: startup.growthRate),
                              _DetailStat(
                                  title: 'Ekip',
                                  value: '${startup.teamSize} Kişi'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // 4. Girişim Detay Metni & Kurucu Bilgisi
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Girişim Özeti & Değer Önerisi',
                              style: theme.textTheme.titleMedium),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            startup.description,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'Kurucu Ekip: ${startup.founderName}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // 5. Sunum Slaytları Fihristi
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pitch Deck Slayt Başlıkları',
                              style: theme.textTheme.titleMedium),
                          const SizedBox(height: AppSpacing.sm),
                          const ListTile(
                            dense: true,
                            leading: Icon(Icons.check_circle, size: 18),
                            title: Text('1. Problem & Pazar İhtiyacı'),
                          ),
                          const ListTile(
                            dense: true,
                            leading: Icon(Icons.check_circle, size: 18),
                            title: Text('2. Çözüm & Değer Önerisi'),
                          ),
                          const ListTile(
                            dense: true,
                            leading: Icon(Icons.check_circle, size: 18),
                            title: Text('3. Pazar Büyüklüğü (TAM / SAM / SOM)'),
                          ),
                          const ListTile(
                            dense: true,
                            leading: Icon(Icons.check_circle, size: 18),
                            title: Text('4. Çekiş & Büyüme (Traction / MRR)'),
                          ),
                          const ListTile(
                            dense: true,
                            leading: Icon(Icons.check_circle, size: 18),
                            title: Text('5. Yatırım İhtiyacı & Fonlama'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Hata: $err')),
          ),
        ),
      ),
    );
  }
}

/// İstatistiksel metrik gösterge hücresi
class _DetailStat extends StatelessWidget {
  final String title;
  final String value;

  const _DetailStat({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
