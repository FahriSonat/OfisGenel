import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/service_type.dart';
import '../providers/support_booking_providers.dart';

/// [SupportBookingScreen]
/// Uzman Destek Hizmeti Talep ve Planlama Ekranı (/space/:role/booking/:serviceType).
/// - Üst Kısım: [SegmentedButton] (Mentor, Avukat, Pazarlama, Muhasebe) ile hizmet türünü seçtirir.
///   Açılan role ait servis varsayılan olarak seçili gelir.
/// - Orta Kısım: Tarih seçimi ve danışmanlık talep notu giriş formu.
/// - Alt Kısım: Girişimcinin daha önce ilettiği destek randevu taleplerinin listesi ve durumları.
class SupportBookingScreen extends ConsumerStatefulWidget {
  final String roleSlug;
  final String initialServiceType;

  const SupportBookingScreen({
    super.key,
    required this.roleSlug,
    required this.initialServiceType,
  });

  @override
  ConsumerState<SupportBookingScreen> createState() =>
      _SupportBookingScreenState();
}

class _SupportBookingScreenState extends ConsumerState<SupportBookingScreen> {
  late ServiceType _selectedService;
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 2));

  @override
  void initState() {
    super.initState();
    // Açık olan role göre varsayılan servis türünü belirler
    _selectedService = ServiceType.tryParse(widget.initialServiceType) ??
        ServiceType.tryParse(widget.roleSlug) ??
        ServiceType.mentor;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  /// Yeni destek talebi oluşturur ve listeyi reaktif günceller
  void _submitRequest() {
    final note = _noteController.text.trim();
    if (note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen danışmanlık notunuzu giriniz.')),
      );
      return;
    }
    ref.read(supportBookingListProvider.notifier).createBookingRequest(
          serviceType: _selectedService,
          preferredDate: _selectedDate,
          note: note,
        );
    _noteController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Destek talebiniz başarıyla iletildi.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingsAsync = ref.watch(supportBookingListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Destek Planlama'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              // 1. SegmentedButton: 4 ana danışmanlık türü arasında geçiş
              SegmentedButton<ServiceType>(
                segments: const [
                  ButtonSegment(
                    value: ServiceType.mentor,
                    label: Text('Mentor'),
                    icon: Icon(Icons.school_outlined),
                  ),
                  ButtonSegment(
                    value: ServiceType.lawyer,
                    label: Text('Avukat'),
                    icon: Icon(Icons.gavel_outlined),
                  ),
                  ButtonSegment(
                    value: ServiceType.marketing,
                    label: Text('Pazarlama'),
                    icon: Icon(Icons.campaign_outlined),
                  ),
                  ButtonSegment(
                    value: ServiceType.accountant,
                    label: Text('Muhasebe'),
                    icon: Icon(Icons.calculate_outlined),
                  ),
                ],
                selected: {_selectedService},
                onSelectionChanged: (newSelection) {
                  setState(() => _selectedService = newSelection.first);
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // 2. Talep Formu Kartı: Tarih ve detay notu
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${_selectedService.label} Desteği Randevusu',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.event_available),
                        title: Text(
                          'Tercih Edilen Tarih: ${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
                        ),
                        trailing: TextButton(
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 90)),
                            );
                            if (picked != null) {
                              setState(() => _selectedDate = picked);
                            }
                          },
                          child: const Text('Tarih Seç'),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      TextField(
                        controller: _noteController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Danışmanlık Notu / İhtiyaç Özeti',
                          hintText:
                              'Görüşmek istediğiniz hususları kısaca özetleyin...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      FilledButton.icon(
                        onPressed: _submitRequest,
                        icon: const Icon(Icons.send),
                        label: const Text('Talep Gönder'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 3. Mevcut Talepler Listesi: Durum takibi
              Text('Gönderilen Destek Talepleri',
                  style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              bookingsAsync.when(
                data: (bookings) {
                  if (bookings.isEmpty) {
                    return const Text('Henüz bir destek talebi bulunmuyor.');
                  }
                  return Column(
                    children: bookings.map((b) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: ListTile(
                          title: Text(
                            '${b.serviceType.label} Desteği',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${b.note}\nRandevu: ${b.preferredDate.day}.${b.preferredDate.month}.${b.preferredDate.year}',
                          ),
                          isThreeLine: true,
                          trailing: Chip(label: Text(b.status)),
                        ),
                      );
                    }).toList(),
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (err, _) => Text('Hata: $err'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
