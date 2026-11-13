import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/pitch_slide.dart';
import '../../domain/entities/startup.dart';

/// [PitchPresentationScreen]
/// Yatırımcılara Canlı Proje Sunumu (Pitch Mode / Demo Day Sahnesi) Ekranı.
/// - 5 Ana Slayt Modeli (Problem, Çözüm, Pazar TAM/SAM/SOM, Çekiş Traction, Yatırım Fon Dağılımı).
/// - İlerleyen slayt indikatörü ve slayt numaralandırması.
/// - Altta Önceki / Sonraki geçiş kontrolleri ve "Yatırım Teklifi / İletişim" aksiyon butonu.
class PitchPresentationScreen extends StatefulWidget {
  final Startup startup;

  const PitchPresentationScreen({
    super.key,
    required this.startup,
  });

  @override
  State<PitchPresentationScreen> createState() =>
      _PitchPresentationScreenState();
}

class _PitchPresentationScreenState extends State<PitchPresentationScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  /// Projeye özel dinamik Demo Day slayt içeriklerini üretir
  List<PitchSlide> _generateSlides(Startup s) {
    return [
      PitchSlide(
        order: 1,
        title: '1. Problem & Pazar İhtiyacı',
        subtitle:
            'Geleneksel yöntemler yavaş, manuel ve yüksek maliyetli hatalara yol açıyor.',
        bulletPoints: [
          'İşletmeler her ay yüzlerce saatini verimsiz operasyonlara harcıyor.',
          'Hata payı %15’e varan manuel süreçler ciddi ciro kaybı yaratıyor.',
          'Mevcut yazılımlar karmaşık ve küçük ekipler için erişilemez.',
        ],
        metricHighlight: '%68 İşletme Çözüm Arıyor',
        iconName: 'warning',
      ),
      PitchSlide(
        order: 2,
        title: '2. Çözüm & Değer Önerisi',
        subtitle: s.tagLine,
        bulletPoints: [
          s.description,
          'Otonom algoritmalar ile %80 zaman tasarrufu.',
          'Dakikalar içinde entegrasyon ve sıfır kurulum maliyeti.',
        ],
        metricHighlight: '10x Daha Hızlı',
        iconName: 'lightbulb',
      ),
      PitchSlide(
        order: 3,
        title: '3. Pazar Büyüklüğü (TAM / SAM / SOM)',
        subtitle: 'Global ve yerel ölçekte hızla büyüyen pazar dinamikleri.',
        bulletPoints: [
          'TAM (Toplam Adreslenebilir Pazar): \$12.4 Milyar',
          'SAM (Hizmet Edilebilir Pazar): \$2.1 Milyar (MENA & CEE)',
          'SOM (İlk 3 Yıl Hedef Pazar): \$85 Milyon',
        ],
        metricHighlight: '\$12.4B Global Pazar',
        iconName: 'pie_chart',
      ),
      PitchSlide(
        order: 4,
        title: '4. Çekiş & Büyüme (Traction)',
        subtitle: 'Ürün-pazar uyumu kanıtlandı ve ivmelenme başladı.',
        bulletPoints: [
          'Aylık Tekrarlayan Gelir (MRR): ${s.mrr}',
          'Aylık Büyüme Oranı (MoM): ${s.growthRate}',
          'Aktif Ekip: ${s.teamSize} tam zamanlı yetenek',
        ],
        metricHighlight: '${s.growthRate} Büyüme',
        iconName: 'trending_up',
      ),
      PitchSlide(
        order: 5,
        title: '5. Yatırım İhtiyacı & Fonlama',
        subtitle:
            'Büyümeyi hızlandırmak ve pazar payını artırmak için yatırım turundayız.',
        bulletPoints: [
          'Hedeflenen Yatırım: ${s.formattedFundingGoal}',
          'Şu Ana Kadar Toplanan: ${s.formattedRaised}',
          'Fon Kullanımı: %50 Ürün & AI Ar-Ge, %35 Pazarlama, %15 Operasyon',
        ],
        metricHighlight: 'Hedef: ${s.formattedFundingGoal}',
        iconName: 'monetization_on',
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slides = _generateSlides(widget.startup);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.startup.name} – Yatırımcı Sunumu'),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            margin: const EdgeInsets.only(right: AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Slayt ${_currentIndex + 1} / ${slides.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              // Slayt İlerleme Çubuğu
              LinearProgressIndicator(
                value: (_currentIndex + 1) / slides.length,
                minHeight: 4,
              ),

              // Ana Slayt İçeriği (PageView)
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: slides.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final slide = slides[index];
                    return Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        theme.colorScheme.primaryContainer,
                                    child: Icon(
                                      Icons.slideshow_outlined,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.md),
                                  Expanded(
                                    child: Text(
                                      slide.title,
                                      style: theme.textTheme.headlineSmall,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                slide.subtitle,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const Divider(height: AppSpacing.lg),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: slide.bulletPoints.length,
                                  separatorBuilder: (_, _) =>
                                      const SizedBox(height: AppSpacing.md),
                                  itemBuilder: (context, i) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline,
                                          size: 20,
                                          color: theme.colorScheme.primary,
                                        ),
                                        const SizedBox(width: AppSpacing.sm),
                                        Expanded(
                                          child: Text(
                                            slide.bulletPoints[i],
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                              fontSize: 15,
                                              height: 1.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              // Slaytın can alıcı metrik rozeti
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(AppSpacing.md),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surfaceContainerHighest,
                                  borderRadius:
                                      BorderRadius.circular(AppSpacing.radiusMd),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber),
                                    const SizedBox(width: AppSpacing.sm),
                                    Text(
                                      'Öne Çıkan Değer: ',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      slide.metricHighlight,
                                      style: TextStyle(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Alt Gezinme ve Yatırım Aksiyon Barı
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  border: Border(
                    top: BorderSide(color: theme.colorScheme.outlineVariant),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _currentIndex > 0
                          ? () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Önceki'),
                    ),
                    FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.startup.name} için yatırımcı görüşme talebiniz iletildi.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.handshake_outlined),
                      label: const Text('Yatırım Teklifi / İletişim'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _currentIndex < slides.length - 1
                          ? () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Sonraki'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
