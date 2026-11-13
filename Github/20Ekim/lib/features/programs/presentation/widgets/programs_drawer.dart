import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/programs_providers.dart';

class ProgramsDrawer extends ConsumerWidget {
  final String? currentSlug;

  const ProgramsDrawer({
    super.key,
    this.currentSlug,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programsAsync = ref.watch(programsListProvider);
    final theme = Theme.of(context);

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Icon(
                    Icons.workspace_premium_outlined,
                    color: theme.colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Destek Programları',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Projelerim Hızlı Erişim Butonu
            ListTile(
              leading: const Icon(Icons.rocket_launch_outlined),
              title: const Text(
                'Girişim Projeleri',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Tüm girişimleri inceleyin'),
              onTap: () {
                Navigator.of(context).pop();
                context.go(AppRoutes.startupsPath());
              },
            ),
            const Divider(),
            Expanded(
              child: programsAsync.when(
                data: (programs) => ListView.builder(
                  itemCount: programs.length,
                  itemBuilder: (context, index) {
                    final program = programs[index];
                    final isSelected = currentSlug == program.slug;

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 14,
                        backgroundColor: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surfaceContainerHighest,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      title: Text(
                        program.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                      selected: isSelected,
                      selectedTileColor:
                          theme.colorScheme.primary.withValues(alpha: 0.08),
                      onTap: () {
                        Navigator.of(context).pop();
                        context.go(AppRoutes.programDetailPath(program.slug));
                      },
                    );
                  },
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, _) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline,
                            color: Colors.red, size: 36),
                        const SizedBox(height: AppSpacing.sm),
                        Text('Programlar yüklenemedi: $error'),
                        const SizedBox(height: AppSpacing.sm),
                        TextButton(
                          onPressed: () => ref.invalidate(programsListProvider),
                          child: const Text('Tekrar Dene'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(
                AppConstants.appName,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
