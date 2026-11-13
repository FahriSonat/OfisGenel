import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/programs_providers.dart';
import 'apply_button.dart';
import 'program_section_card.dart';

/// [ProgramScaffold]
/// 7 Destek Programı (TÜBİTAK BİGG, KOSGEB, Global Hızlandırıcı vb.) için ortak sayfa iskeletidir.
/// - Slug bazlı program detayını Riverpod üzerinden çeker.
/// - Sırasıyla:
///   1. Program Başlığı ve Kısa Özeti
///   2. Metin Blokları ([ProgramSectionCard] sıralı kartlar)
///   3. Alt Başvuru Butonları ([ApplyButtonGroup] - sadece geçerli https linkleri)
class ProgramScaffold extends ConsumerWidget {
  final String slug;

  const ProgramScaffold({
    super.key,
    required this.slug,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programAsync = ref.watch(programDetailProvider(slug));
    final theme = Theme.of(context);

    return programAsync.when(
      data: (program) {
        if (program == null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search_off, size: 48, color: Colors.grey),
                const SizedBox(height: AppSpacing.sm),
                Text('Program bulunamadı', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text('Aradığınız "$slug" kodlu program mevcut değil.',
                    style: theme.textTheme.bodyMedium),
              ],
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppConstants.maxContentWidth,
              ),
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  // 1. Program Başlığı ve Özeti
                  Text(
                    program.title,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    program.summary,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // 2. Metin Blokları ve Şartlar
                  for (final section in program.sections) ...[
                    ProgramSectionCard(section: section),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ],
              ),
            ),
          ),
          // 3. Sabit Alt Başvuru ve Bilgi Butonları
          bottomNavigationBar: program.links.isNotEmpty
              ? SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      border: Border(
                        top: BorderSide(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: AppConstants.maxContentWidth,
                        ),
                        child: ApplyButtonGroup(links: program.links),
                      ),
                    ),
                  ),
                )
              : null,
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: AppSpacing.sm),
            Text('Hata oluştu: $error', style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            FilledButton(
              onPressed: () => ref.invalidate(programDetailProvider(slug)),
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }
}
