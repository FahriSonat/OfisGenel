import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../support_space/domain/entities/support_role.dart';
import '../providers/meetings_providers.dart';

/// [MeetingsScreen]
/// Randevu ve Toplantı Yönetimi Ekranı (/space/:role/meetings).
/// - İlgili destek alanındaki yaklaşan ve onaylanan danışmanlık seanslarını listeler.
/// - Sağ alttaki [FloatingActionButton.extended] ("Toplantı Planla") ile [showDatePicker] ve [showTimePicker]
///   aracılığıyla yeni toplantı planlama imkanı sunar.
class MeetingsScreen extends ConsumerWidget {
  final String roleSlug;

  const MeetingsScreen({
    super.key,
    required this.roleSlug,
  });

  /// Tarih ve saat seçimi içeren toplantı planlama diyaloğunu açar
  void _showScheduleDialog(BuildContext context, WidgetRef ref) async {
    final titleCtrl = TextEditingController(text: 'Birebir Danışmanlık Seansı');
    final nameCtrl = TextEditingController(text: 'Uzman Danışman');
    DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
    TimeOfDay selectedTime = const TimeOfDay(hour: 14, minute: 0);

    await showDialog(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Toplantı Planla'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleCtrl,
                      decoration:
                          const InputDecoration(labelText: 'Konu Başlığı'),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Katılımcı / Danışman'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Tarih seçici kutusu
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(
                        'Tarih: ${selectedDate.day}.${selectedDate.month}.${selectedDate.year}',
                      ),
                      trailing: const Text('Değiştir'),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 90)),
                        );
                        if (picked != null) {
                          setState(() => selectedDate = picked);
                        }
                      },
                    ),
                    // Saat seçici kutusu
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: Text(
                        'Saat: ${selectedTime.format(context)}',
                      ),
                      trailing: const Text('Değiştir'),
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (picked != null) {
                          setState(() => selectedTime = picked);
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                  child: const Text('İptal'),
                ),
                FilledButton(
                  onPressed: () async {
                    final title = titleCtrl.text.trim();
                    final participant = nameCtrl.text.trim();
                    if (title.isNotEmpty && participant.isNotEmpty) {
                      final meetingDateTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );
                      await ref
                          .read(meetingsRepositoryProvider)
                          .scheduleMeeting(
                            roleSlug: roleSlug,
                            title: title,
                            participantName: participant,
                            dateTime: meetingDateTime,
                          );
                      ref.invalidate(meetingsListProvider(roleSlug));
                      if (dialogCtx.mounted) Navigator.of(dialogCtx).pop();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Toplantı başarıyla planlandı.')),
                        );
                      }
                    }
                  },
                  child: const Text('Planla'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = SupportRole.tryParse(roleSlug) ?? SupportRole.mentor;
    final meetingsAsync = ref.watch(meetingsListProvider(roleSlug));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${role.label} Toplantıları'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showScheduleDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Toplantı Planla'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: meetingsAsync.when(
            data: (meetings) {
              if (meetings.isEmpty) {
                return const Center(
                    child: Text('Planlanmış toplantı bulunamadı.'));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: meetings.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final m = meetings[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: Icon(Icons.event,
                                color: theme.colorScheme.primary),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  m.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  m.participantName,
                                  style: theme.textTheme.bodyMedium,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  m.formattedDateTime,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Chip(
                            label: Text(
                              m.status == 'confirmed'
                                  ? 'Onaylandı'
                                  : 'Beklemede',
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
