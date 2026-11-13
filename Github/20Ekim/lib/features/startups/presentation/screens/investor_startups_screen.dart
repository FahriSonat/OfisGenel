import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/startups_providers.dart';
import '../widgets/startup_card.dart';
import 'pitch_presentation_screen.dart';
import 'startup_detail_screen.dart';

/// [InvestorStartupsScreen]
/// Yatırımcılar İçin Girişim Keşif & Dealflow İnceleme Ekranı (/space/investor/startups).
/// - Sektörel Filtreleme (AI & FinTech, CleanTech, LegalTech, HealthTech).
/// - Girişim kartları üzerinde hızlı aksiyonlar:
///   1. "Sunumu İzle": Doğrudan tam ekran Pitch Deck modunu açar.
///   2. "Görüşme Başlat": Yatırımcı görüşmesi / toplantı planlama adımını tetikler.
///   3. Kart tıklaması: Detay sayfasına yönlendirir.
class InvestorStartupsScreen extends ConsumerStatefulWidget {
  const InvestorStartupsScreen({super.key});

  @override
  ConsumerState<InvestorStartupsScreen> createState() =>
      _InvestorStartupsScreenState();
}

class _InvestorStartupsScreenState
    extends ConsumerState<InvestorStartupsScreen> {
  String _selectedSector = 'Tümü';
  final List<String> _sectors = [
    'Tümü',
    'AI & FinTech',
    'CleanTech',
    'LegalTech',
    'HealthTech'
  ];

  @override
  Widget build(BuildContext context) {
    final startupsAsync = ref.watch(startupsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yatırımcı Portföy & Girişim Keşfi'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Sektör Filtreleme Çipleri
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: _sectors.map((sec) {
                    final isSelected = _selectedSector == sec;
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: FilterChip(
                        selected: isSelected,
                        label: Text(sec),
                        onSelected: (_) {
                          setState(() => _selectedSector = sec);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              // 2. Filtrelenmiş Girişimler Listesi
              Expanded(
                child: startupsAsync.when(
                  data: (allStartups) {
                    final filtered = _selectedSector == 'Tümü'
                        ? allStartups
                        : allStartups
                            .where((s) => s.sector == _selectedSector)
                            .toList();

                    if (filtered.isEmpty) {
                      return const Center(
                        child: Text(
                            'Bu filtreye uygun yatırım fırsatı bulunamadı.'),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      itemCount: filtered.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final startup = filtered[index];
                        return StartupCard(
                          startup: startup,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    StartupDetailScreen(startupId: startup.id),
                              ),
                            );
                          },
                          // Yatırımcıya özel aksiyon butonları: Sunumu İzle ve Görüşme Başlat
                          trailingAction: Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.xs,
                            children: [
                              OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => PitchPresentationScreen(
                                        startup: startup,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.slideshow, size: 16),
                                label: const Text('Sunumu İzle'),
                              ),
                              FilledButton.icon(
                                onPressed: () {
                                  context.go(AppRoutes.meetingsPath('investor'));
                                },
                                icon: const Icon(Icons.event, size: 16),
                                label: const Text('Görüşme Başlat'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Center(child: Text('Hata: $err')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
