name:flutter-feature-scaffold 
description: flutter projelerinde feature bazlı kod yazmak için gerekli klasör yapısını oluşturur. ValueNotifier state mimarisini UI ayrımını ve birim test iskeletini standartlara uygun olarak üretir.

# Flutter feature scaffold (modüler ekran iskeleti) 
bu yetenek, projede yeni bir ekranda yada işlev modülü açarken Clean UI ve reaktif State kurallarına tam uyulmasını garanti altına alır.

## temel Kurallar 
1.**Asla tek dosyada toplama:**
UI (`_vier.dart`) State Controller (`_controller.dart`) ve model (`_model.dart`) katmanları her zaman ayrı dosyalarda üretilmelidir.

2.**State Yönetimi:**
Basit ve reaktif durumlar için `ValueNotifier` kullanılacaktır.
Doğrudan devasa StatefulWidgets yazarak işi karmaşıklaştırma.

3. **Const zorunluluğu:**
Mümkün olan tüm widgetlarda `const` olmalıdır.

---
name: entrepreneurship-app-architecture
description: Girişimcilik mobil uygulaması (Flutter + Riverpod + go_router) için katmanlı mimari, rol bazlı destek alanları (mentor, muhasebe, avukat, yatırımcı, pazarlama uzmanı), ortak destek araçları (AI sohbet, dosya, kullanıcı sohbeti, toplantı, destek planlama) ve 7 destek programı sayfa yapısı. Yeni feature, screen, provider, route, navigation değişikliği veya mimari review yapılırken kullan.
---

# Girişimcilik Mobil Uygulaması – Mimari Skill

## Stack (sadece bunlar)
- Flutter
- Riverpod (state management + dependency injection)
- go_router (navigation)

Kurallar:
1. Bu üç teknoloji dışında paket ekleme, önermeden önce kullanıcıya sor.
2. Backend yok. Veri `mock/in-memory datasource` ile gelir.
3. Datasource sonradan değiştirilebilsin diye her feature'da `Repository interface` zorunludur.

## Temel İlke
Dependency Rule: bağımlılık dıştan içe doğrudur. Üst katman alt katmanı bilir, tersi olmaz.

---

## 1. Navigasyon Modeli (ZORUNLU)

| Alan | Görev | Widget |
|---|---|---|
| **Header (AppBar)** | Destek alanı (rol) değiştirme | `RoleSwitcherDropdown` (aşağı açılır menü) |
| **Sidebar (Drawer)** | Sadece 7 destek programı listesi | `ProgramsDrawer` |

Kurallar:
1. Rol değiştirme ASLA sidebar'a konmaz, sadece header dropdown'dan yapılır.
2. Programlar ASLA header dropdown'a konmaz, sadece sidebar'dan seçilir.
3. Header + Drawer ortak `AppShell` içinde tanımlanır, tüm ekranlar bu shell içinde render edilir.
4. go_router'da `ShellRoute` kullan, `AppShell` bu shell'in builder'ıdır.
5. Dropdown seçimi `context.go('/space/<role>')` ile route değiştirir. State'in kaynağı URL'dir, ayrı bir "seçili rol" state'i tutma.

Dropdown sırası:

| Slug | Etiket |
|---|---|
| `mentor` | Mentor |
| `accountant` | Muhasebe |
| `lawyer` | Avukat |
| `investor` | Yatırımcı |
| `marketing` | Pazarlama Uzmanı |

---

## 2. Roller

```dart
// lib/features/support_space/domain/entities/support_role.dart
enum SupportRole {
  mentor('Mentor'),
  accountant('Muhasebe'),
  lawyer('Avukat'),
  investor('Yatırımcı'),
  marketing('Pazarlama Uzmanı');

  const SupportRole(this.label);
  final String label;

  static SupportRole? tryParse(String slug) {
    for (final r in SupportRole.values) {
      if (r.name == slug) return r;
    }
    return null;
  }
}
```

Slug, enum adı ve route parametresi AYNI string'dir. Farklı isimlendirme yapma.

---

## 3. Destek Alanları (Role Spaces)

Her rol için AYRI bir screen dosyası olur. Screen'ler ince tutulur, ortak iskeleti `SpaceScaffold` sağlar, role özel bölümler `roleSections` parametresiyle verilir.

Her destek alanında ortak `SupportToolkit` bulunur (8 araç):

| # | Araç | Feature klasörü |
|---|---|---|
| 1 | AI sohbet | `ai_chat` |
| 2 | Dosya yükleme | `files` |
| 3 | Diğer kullanıcılarla sohbet | `chat` |
| 4 | Toplantı planlama | `meetings` |
| 5 | Mentor desteği planlama | `support_booking` (`serviceType = mentor`) |
| 6 | Avukat desteği planlama | `support_booking` (`serviceType = lawyer`) |
| 7 | Pazarlama uzmanı desteği planlama | `support_booking` (`serviceType = marketing`) |
| 8 | Muhasebe desteği planlama | `support_booking` (`serviceType = accountant`) |

Kurallar:
1. `SupportToolkit` tek widget'tır, rol screen'lerinde kopyalanmaz.
2. 5–8 numaralı araçlar tek feature'dır (`support_booking`), `serviceType` ile ayrışır.
3. Açık olan role ait servis varsayılan seçili gelir (Avukat alanında `lawyer`), diğerleri de seçilebilir kalır.
4. AI sohbet, dosya ve chat verisi `spaceRole` ile etiketlenir, alanlar arası karışmaz.
5. Role özel içerik `roleSections` ile eklenir, toolkit'e dokunulmaz.
6. Dosya yükleme ve AI sohbet şimdilik mock'tur: dosya listesi in-memory, AI cevabı sahte (fake) repository'den gelir.

---

## 4. Destek Programları (7 adet)

- Her program için AYRI screen iskeleti: `program_01_screen.dart` … `program_07_screen.dart`.
- Screen'ler ince tutulur, ortak iskeleti `ProgramScaffold(slug: ...)` sağlar.
- İçerik (metin blokları + başvuru linkleri) `ProgramsRepository` üzerinden gelir. Şimdilik `ProgramsMockDataSource` döner, UI içine hardcode edilmez.
- Program seçimi sadece sidebar'dan yapılır.

Her program sayfasında:
1. Başlık + kısa özet
2. Metin blokları (`ProgramSection`, sıralı)
3. Başvuru formu yönlendirme butonları (`ProgramLink`)

Başvuru linkleri:
- Sadece `https://` ile başlayan link için buton gösterilir.
- Linki açma işi `LinkLauncher` interface'i arkasındadır (`core/utils/link_launcher.dart`). Gerçek implementasyon ayrı paket gerektirdiği için şimdilik boş/placeholder bırakılır, kullanıcı onaylayınca eklenir.
- Link türleri: `applicationForm`, `info`.

Program slug'ları kebab-case ve değişmezdir. Gerçek adlar netleşene kadar `program-1` … `program-7` kullan.

---

## 5. Klasör Yapısı

```
lib/
├── core/
│   ├── error/            # failures.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   └── routes.dart
│   ├── theme/
│   ├── constants/
│   └── utils/
│       └── link_launcher.dart
├── shared/
│   └── widgets/
│       └── app_shell.dart            # AppBar + Drawer
├── features/
│   ├── support_space/
│   │   ├── domain/entities/support_role.dart
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── mentor_space_screen.dart
│   │       │   ├── accountant_space_screen.dart
│   │       │   ├── lawyer_space_screen.dart
│   │       │   ├── investor_space_screen.dart
│   │       │   └── marketing_space_screen.dart
│   │       ├── widgets/
│   │       │   ├── space_scaffold.dart
│   │       │   ├── role_switcher_dropdown.dart
│   │       │   └── support_toolkit.dart
│   │       └── providers/
│   ├── ai_chat/          (data / domain / presentation)
│   ├── files/            (data / domain / presentation)
│   ├── chat/             (data / domain / presentation)
│   ├── meetings/         (data / domain / presentation)
│   ├── support_booking/  (data / domain / presentation)
│   └── programs/
│       ├── data/
│       │   ├── datasources/programs_mock_datasource.dart
│       │   ├── models/
│       │   └── repositories/programs_repository_impl.dart
│       ├── domain/
│       │   ├── entities/ (program.dart, program_section.dart, program_link.dart)
│       │   ├── repositories/programs_repository.dart
│       │   └── usecases/
│       └── presentation/
│           ├── screens/
│           │   ├── program_01_screen.dart
│           │   ├── program_02_screen.dart
│           │   ├── program_03_screen.dart
│           │   ├── program_04_screen.dart
│           │   ├── program_05_screen.dart
│           │   ├── program_06_screen.dart
│           │   └── program_07_screen.dart
│           ├── widgets/
│           │   ├── programs_drawer.dart
│           │   ├── program_scaffold.dart
│           │   ├── program_section_card.dart
│           │   └── apply_button.dart
│           └── providers/
└── main.dart
```

Her feature: `data/` (datasources, models, repositories impl), `domain/` (entities, repository interface, usecases), `presentation/` (screens, widgets, providers).

---

## 6. go_router Route Haritası

```
ShellRoute (AppShell)
├── /space/:role                         -> <Role>SpaceScreen
├── /space/:role/ai-chat                 -> AiChatScreen
├── /space/:role/files                   -> FilesScreen
├── /space/:role/chat                    -> ChatScreen
├── /space/:role/meetings                -> MeetingsScreen
├── /space/:role/booking/:serviceType    -> SupportBookingScreen
└── /programs/:slug                      -> Program0XScreen
```

Kurallar:
1. Route path'leri `core/router/routes.dart` içinde sabit olarak tutulur, string'i screen içinde yazma.
2. `:role` ve `:serviceType` enum'a parse edilir, geçersizse `redirect` ile `/space/mentor`'a yönlendir.
3. `:slug` bilinmeyen bir program ise "Program bulunamadı" ekranı göster.
4. Router, Riverpod provider olarak tanımlanır (`goRouterProvider`).
5. Başlangıç route'u `/space/mentor`.

---

## 7. Riverpod Kuralları

1. Her feature'ın provider'ları kendi `presentation/providers/` klasöründe olur.
2. Provider zinciri: `datasourceProvider` → `repositoryProvider` → `usecaseProvider` → `controller/notifier` → UI.
3. Repository provider'ı interface tipinde döner (`Provider<ProgramsRepository>`), impl dışarı sızmaz.
4. Async veri için `AsyncNotifier` / `FutureProvider`, UI'da `.when(data/loading/error)` ile üçlü durum zorunlu.
5. Parametreli veri için `family` kullan (ör. `programProvider(slug)`).
6. UI'da `ref.watch` sadece `build` içinde, aksiyonlarda `ref.read`.
7. Global mutable state (singleton, static) kullanma.
8. Mock → gerçek kaynağa geçiş sadece `datasourceProvider`'ı override ederek yapılabilmeli.

---

## 8. Mimari Kuralları

1. UI içinde veri çekme kodu yazma → Provider → UseCase → Repository.
2. Domain katmanı Flutter, Riverpod ve go_router import etmez (pure Dart).
3. Model ↔ Entity dönüşümü sadece Data katmanında yapılır.
4. Feature'lar birbirini doğrudan import etmez, ortak kod `core/` ve `shared/` altında olur.
5. Hatalar `Failure` sınıflarına çevrilir (`core/error/`), UI'a raw exception gitmez.
6. Screen dosyaları ince kalır, 150 satırı geçen widget'ları parçala.
7. Renk, spacing, text style `core/theme/` üzerinden gelir, widget içinde hardcode edilmez.

---

## 9. Checklist

### Yeni destek rolü eklerken
1. `SupportRole` enum'a ekle.
2. `<role>_space_screen.dart` oluştur (`SpaceScaffold` kullan).
3. `RoleSwitcherDropdown` listesi enum'dan üretildiği için elle ekleme yapma.
4. Route `:role` parse'ı enum'dan geldiği için ek route gerekmez, screen eşlemesini `app_router.dart` içinde ekle.
5. Booking'e dahilse `ServiceType` enum'unu güncelle.

### Yeni program eklerken
1. `ProgramsMockDataSource` içine program + section + link verisini ekle.
2. `program_0X_screen.dart` oluştur (`ProgramScaffold(slug: ...)`).
3. `ProgramsDrawer` listesi repository'den gelir, elle ekleme yapma.
4. Route'u `app_router.dart` içine ekle.

### Yeni feature eklerken
1. Sıra: entity → repository interface → model → mock datasource → repository impl → usecase → provider → screen.
2. Route'u `routes.dart` ve `app_router.dart` içine ekle.
3. `spaceRole` etiketlemesi gerekiyorsa entity'ye ekle.

---

## Çıktı Kuralları
- Tam dosya içeriğini code block ile ver, dosya yolunu başa yaz.
- Windows (PowerShell/cmd) komutları kullan.
- Açıklamayı kısa tut, Türkçe yaz, teknik terimler İngilizce kalsın.
- Stack dışı paket gerekirse önce sor, sessizce ekleme.