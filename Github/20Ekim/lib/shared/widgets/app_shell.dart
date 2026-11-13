import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/routes.dart';
import '../../core/theme/role_style.dart';
import '../../features/programs/presentation/widgets/programs_drawer.dart';
import '../../features/support_space/domain/entities/support_role.dart';
import '../../features/support_space/presentation/widgets/role_switcher_dropdown.dart';

/// [AppShell]
/// Uygulamanın tüm ekranlarını çevreleyen ana ortak kabuk (ShellRoute) bileşenidir.
/// - Üst Kısım (AppBar): Sadece rol değiştirme dropdown'ı ve profil/bildirim/proje aksiyonlarını barındırır.
/// - Alt Çizgi: Aktif role ait dinamik 2px accent renk çizgisi çizer.
/// - Sol Menü (Drawer): Sadece 7 destek programı ve girişim projeleri erişimini sağlar.
/// - Gövde: URL rotasına göre dinamik sayfa içeriğini ve yumuşak fade geçişini yönetir.
class AppShell extends StatelessWidget {
  final Widget child;
  final String location;

  const AppShell({
    super.key,
    required this.child,
    required this.location,
  });

  /// URL yolundan aktif destek rolünü (mentor, lawyer vb.) çözümler
  SupportRole _resolveCurrentRole() {
    final segments = Uri.parse(location).pathSegments;
    if (segments.length >= 2 && segments[0] == 'space') {
      final parsed = SupportRole.tryParse(segments[1]);
      if (parsed != null) return parsed;
    }
    return SupportRole.mentor;
  }

  /// URL yolundan aktif destek programı slug'ını çözümler
  String? _resolveCurrentProgramSlug() {
    final segments = Uri.parse(location).pathSegments;
    if (segments.length >= 2 && segments[0] == 'programs') {
      return segments[1];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final currentRole = _resolveCurrentRole();
    final currentSlug = _resolveCurrentProgramSlug();
    final accentColor = currentRole.accent;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        // Rol değiştirme yalnızca AppBar dropdown'ı üzerinden yapılır
        title: RoleSwitcherDropdown(currentRole: currentRole),
        actions: [
          // Girişim projeleri kataloğuna hızlı erişim
          IconButton(
            tooltip: 'Girişim Projeleri',
            icon: const Icon(Icons.rocket_launch_outlined),
            onPressed: () {
              context.go(AppRoutes.startupsPath());
            },
          ),
          IconButton(
            tooltip: 'Bildirimler',
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Yeni bildiriminiz bulunmuyor.'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Profil',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Girişimci Profili: Kurucu Ortak'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
        // Aktif role özel accent renk çizgisi
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            color: accentColor,
            height: 2,
          ),
        ),
      ),
      // Destek programları sidebar çekmecesi
      drawer: ProgramsDrawer(currentSlug: currentSlug),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: KeyedSubtree(
          key: ValueKey<String>(location),
          child: child,
        ),
      ),
    );
  }
}
