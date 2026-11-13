import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../support_space/domain/entities/support_role.dart';
import '../providers/files_providers.dart';

/// [FilesScreen]
/// Rol Bazlı Doküman ve Dosya Yönetimi Ekranı (/space/:role/files).
/// - Yüklenen dosyalar ilgili destek alanına (Mentor, Avukat, Muhasebe vb.) göre filtrelenir.
/// - Dosya uzantısına göre (PDF, XLSX, DOCX) özel simgeler ve dosya boyutu gösterilir.
/// - Sağ altta [FloatingActionButton.extended] ile yeni dosya yükleme diyaloğu sunulur.
class FilesScreen extends ConsumerWidget {
  final String roleSlug;

  const FilesScreen({
    super.key,
    required this.roleSlug,
  });

  /// Yeni dosya yükleme mock diyaloğunu açar
  void _handleUpload(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        final textCtrl = TextEditingController(text: 'Yeni_Dokuman.pdf');
        return AlertDialog(
          title: const Text('Yeni Dosya Yükle (Mock)'),
          content: TextField(
            controller: textCtrl,
            decoration: const InputDecoration(
              labelText: 'Dosya Adı',
              hintText: 'Örn: Finansal_Model.xlsx',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: const Text('İptal'),
            ),
            FilledButton(
              onPressed: () async {
                final name = textCtrl.text.trim();
                if (name.isNotEmpty) {
                  await ref.read(filesRepositoryProvider).uploadFile(
                        roleSlug,
                        name,
                        1024 * 512,
                      );
                  ref.invalidate(filesListProvider(roleSlug));
                  if (dialogCtx.mounted) Navigator.of(dialogCtx).pop();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$name yüklendi.')),
                    );
                  }
                }
              },
              child: const Text('Yükle'),
            ),
          ],
        );
      },
    );
  }

  /// Uzantıya göre uygun Material ikonunu belirler
  IconData _getFileIcon(String ext) {
    return switch (ext.toLowerCase()) {
      'pdf' => Icons.picture_as_pdf_outlined,
      'xlsx' || 'xls' => Icons.table_chart_outlined,
      'docx' || 'doc' => Icons.description_outlined,
      _ => Icons.insert_drive_file_outlined,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = SupportRole.tryParse(roleSlug) ?? SupportRole.mentor;
    final filesAsync = ref.watch(filesListProvider(roleSlug));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${role.label} Dosyaları'),
      ),
      // Standart FloatingActionButton.extended dosya yükleme butonu
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleUpload(context, ref),
        icon: const Icon(Icons.upload_file),
        label: const Text('Dosya Yükle'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: filesAsync.when(
            data: (files) {
              if (files.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.folder_open, size: 48, color: Colors.grey),
                      SizedBox(height: AppSpacing.sm),
                      Text('Bu alanda henüz dosya yüklenmedi.'),
                    ],
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: files.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final file = files[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        child: Icon(
                          _getFileIcon(file.fileType),
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        file.fileName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '${file.formattedSize} • ${file.formattedDate}',
                        style: theme.textTheme.bodySmall,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.download_outlined),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('${file.fileName} indiriliyor...')),
                          );
                        },
                      ),
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
                    onPressed: () => ref.invalidate(filesListProvider(roleSlug)),
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
