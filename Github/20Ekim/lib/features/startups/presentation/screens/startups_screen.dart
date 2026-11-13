import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/startups_providers.dart';
import '../widgets/startup_card.dart';
import 'startup_detail_screen.dart';

/// [StartupsScreen]
/// Girişim Projeleri Kataloğu Ekranı (/startups).
/// - Uygulamaya kayıtlı teknoloji girişimlerini listeler.
/// - Her kartta ([StartupCard]) sektör, aşama, MRR, büyüme ve fonlama ilerleme çubuğu yer alır.
/// - Kart veya detay butonuna tıklandığında [StartupDetailScreen] detay ve yatırımcı sayfasına yönlendirir.
class StartupsScreen extends ConsumerWidget {
  const StartupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startupsAsync = ref.watch(startupsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Girişim Projeleri'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: startupsAsync.when(
            data: (startups) {
              if (startups.isEmpty) {
                return const Center(
                  child: Text('Kayıtlı girişim projesi bulunamadı.'),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: startups.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final startup = startups[index];
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
                    trailingAction: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                StartupDetailScreen(startupId: startup.id),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_forward, size: 16),
                      label: const Text('Detayları İncele'),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 36),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Hata: $err'),
                  TextButton(
                    onPressed: () => ref.invalidate(startupsListProvider),
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
