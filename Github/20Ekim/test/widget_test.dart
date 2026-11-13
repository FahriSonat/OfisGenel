import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:entrepreneurship_app/main.dart';
import 'package:entrepreneurship_app/features/support_space/domain/entities/support_role.dart';

void main() {
  testWidgets(
      'Rol bazlı araç kiti testi - Mentor alanında sadece mentorluk desteği görünür',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: EntrepreneurshipApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Rol dropdown ve başlık kartı doğrulaması
    expect(find.text(SupportRole.mentor.label), findsWidgets);
    expect(find.text('Mentor Destek Alanı'), findsOneWidget);
    expect(find.text('Destek Araçları'), findsOneWidget);

    // 2. Ortak 4 Araç
    expect(find.text('AI Sohbet'), findsOneWidget);
    expect(find.text('Dosya Yükleme'), findsOneWidget);
    expect(find.text('Kullanıcı Sohbeti'), findsOneWidget);
    expect(find.text('Toplantı Planla'), findsOneWidget);

    // 3. Sadece Mentorluk Desteği olmalı, diğer destekler bu sayfada olmamalı
    expect(find.text('Mentorluk Desteği'), findsOneWidget);
    expect(find.text('Avukat Desteği'), findsNothing);
    expect(find.text('Muhasebe Desteği'), findsNothing);
  });

  testWidgets(
      'Sidebar testi - Destek programları ve Girişim Projeleri listelenir',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: EntrepreneurshipApp(),
      ),
    );
    await tester.pumpAndSettle();

    final drawerFinder = find.byTooltip('Open navigation menu');
    if (drawerFinder.evaluate().isNotEmpty) {
      await tester.tap(drawerFinder);
    } else {
      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
    }
    await tester.pumpAndSettle();

    expect(find.text('Destek Programları'), findsOneWidget);
    expect(find.text('Girişim Projeleri'), findsOneWidget);
  });
}
