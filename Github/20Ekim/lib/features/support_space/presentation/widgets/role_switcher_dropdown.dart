import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/role_style.dart';
import '../../domain/entities/support_role.dart';

class RoleSwitcherDropdown extends StatelessWidget {
  final SupportRole currentRole;

  const RoleSwitcherDropdown({
    super.key,
    required this.currentRole,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopupMenuButton<SupportRole>(
      initialValue: currentRole,
      tooltip: 'Destek Alanını Değiştir',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      onSelected: (SupportRole selectedRole) {
        if (selectedRole != currentRole) {
          context.go(AppRoutes.spacePath(selectedRole.name));
        }
      },
      itemBuilder: (context) {
        return SupportRole.values.map((role) {
          final isSelected = role == currentRole;
          return PopupMenuItem<SupportRole>(
            value: role,
            child: Row(
              children: [
                Icon(
                  role.icon,
                  size: 20,
                  color: role.accent,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    role.label,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
              ],
            ),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              currentRole.icon,
              size: 20,
              color: currentRole.accent,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              currentRole.label,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            const Icon(
              Icons.arrow_drop_down,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
