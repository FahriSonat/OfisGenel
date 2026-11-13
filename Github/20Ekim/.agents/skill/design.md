# Girişimcilik Mobil Uygulaması – Tasarım Rehberi (DESIGN.md)

## 1. Tasarım İlkeleri

1. **Material 3** (`useMaterial3: true`), özel widget yerine önce Material widget'ı kullan.
2. **Sade ve güven veren**: girişimcilik + hukuk/muhasebe içeriği var, abartılı efekt yok.
3. **Tek tutarlı iskelet**: tüm ekranlar `AppShell` içinde (AppBar + Drawer).
4. **Rol = vurgu rengi**: her destek alanının kendi accent rengi var, geri kalan her şey ortak.
5. **Light + Dark mode** zorunlu.
6. Hardcode renk/spacing/text style yok, hepsi `core/theme/` üzerinden.

---

## 2. Renkler

### Marka (Seed)

| Token | Light | Dark |
|---|---|---|
| `primary` (seed) | `#3949AB` | `#9FA8DA` |
| `background` | `#F7F8FC` | `#12131A` |
| `surface` | `#FFFFFF` | `#1B1D27` |
| `onSurface` | `#1B1D27` | `#E6E7F0` |
| `outline` | `#D5D8E6` | `#363A4D` |

### Durum Renkleri

| Durum | Renk |
|---|---|
| success | `#2E7D32` |
| warning | `#ED6C02` |
| error | `#D32F2F` |
| info | `#0288D1` |

### Rol Accent Renkleri

| Rol | Accent | İkon |
|---|---|---|
| Mentor | `#3949AB` (indigo) | `Icons.school_outlined` |
| Muhasebe | `#00796B` (teal) | `Icons.calculate_outlined` |
| Avukat | `#455A64` (blue grey) | `Icons.gavel_outlined` |
| Yatırımcı | `#F9A825` (amber) | `Icons.trending_up` |
| Pazarlama Uzmanı | `#D81B60` (pink) | `Icons.campaign_outlined` |

Kural: accent sadece AppBar alt çizgisi, toolkit ikonları, başlık kartı ve primary button'da kullanılır. Arka plan rengini değiştirme.

---

## 3. Tipografi

Font: **sistem varsayılanı (Roboto)**. `google_fonts` kullanma.

| Stil | Material Token | Boyut / Ağırlık | Kullanım |
|---|---|---|---|
| Sayfa başlığı | `headlineSmall` | 24 / w600 | Rol ve program başlığı |
| Bölüm başlığı | `titleMedium` | 16 / w600 | Section card başlığı |
| Gövde | `bodyMedium` | 14 / w400 | Metin blokları |
| Küçük açıklama | `bodySmall` | 12 / w400 | Tarih, etiket |
| Buton | `labelLarge` | 14 / w600 | Tüm butonlar |

Metin bloklarında satır yüksekliği `1.5`.

---

## 4. Spacing, Radius, Elevation

| Token | Değer |
|---|---|
| `xs` | 4 |
| `sm` | 8 |
| `md` | 16 |
| `lg` | 24 |
| `xl` | 32 |

| Radius | Değer | Kullanım |
|---|---|---|
| `sm` | 8 | Chip, input |
| `md` | 12 | Card, button |
| `lg` | 20 | Bottom sheet, dialog |

- Sayfa yatay padding: `16`
- Card elevation: `0`, 1px `outline` border kullan (flat görünüm)
- Dokunma alanı minimum `48x48`

---

## 5. Layout

### Breakpoints

| Genişlik | Tip | Toolkit grid |
|---|---|---|
| `< 600` | Phone | 2 sütun |
| `600 – 1024` | Tablet | 4 sütun |
| `> 1024` | Geniş | 4 sütun, içerik `maxWidth: 900` ortalı |

### AppShell

```
┌──────────────────────────────────────┐
│ ☰  [ Mentor ▾ ]              🔔  👤  │  ← AppBar (rol dropdown burada)
├──────────────────────────────────────┤
│                                      │
│              İçerik                  │
│                                      │
└──────────────────────────────────────┘

Drawer (☰): 7 destek programı
```

- AppBar: solda menü (Drawer), ortada/solda `RoleSwitcherDropdown`, sağda bildirim + profil.
- AppBar altında 2px accent renkli çizgi (aktif role göre).
- Drawer: üstte başlık "Destek Programları", altında 7 `ListTile`. Aktif program `selected: true`.

---

## 6. Bileşenler

### 6.1 RoleSwitcherDropdown

- Widget: `PopupMenuButton<SupportRole>` veya `DropdownMenu`.
- Kapalıyken: rol ikonu + etiket + `arrow_drop_down`.
- Açıkken: 5 rol, her satırda accent renkli ikon + etiket, aktif olan check ile işaretli.
- Seçim: `context.go('/space/<role>')`.

### 6.2 SpaceScaffold (rol sayfası)

Sıra:
1. **Başlık kartı**: rol ikonu (accent arka plan, %12 opacity), rol adı, tek cümle açıklama.
2. **SupportToolkit** (8 araç grid)
3. **Role özel bölümler** (`roleSections`)

### 6.3 SupportToolkit (8 araç)

| # | Araç | İkon |
|---|---|---|
| 1 | AI Sohbet | `Icons.smart_toy_outlined` |
| 2 | Dosya Yükleme | `Icons.upload_file_outlined` |
| 3 | Kullanıcı Sohbeti | `Icons.forum_outlined` |
| 4 | Toplantı Planla | `Icons.event_outlined` |
| 5 | Mentor Desteği | `Icons.school_outlined` |
| 6 | Avukat Desteği | `Icons.gavel_outlined` |
| 7 | Pazarlama Desteği | `Icons.campaign_outlined` |
| 8 | Muhasebe Desteği | `Icons.calculate_outlined` |

Tile tasarımı:
- Yükseklik ~110, `Card` (flat + border), radius `12`.
- Üstte ikon (28px, aktif rolün accent rengi), altında etiket (`titleSmall`, max 2 satır).
- Aktif role ait servis tile'ında accent renkli 1.5px border + küçük "Önerilen" rozeti.
- Tıklama: `InkWell` ripple, ilgili route'a `context.go`.

### 6.4 ProgramScaffold (program sayfası)

Sıra:
1. **Başlık alanı**: program adı (`headlineSmall`) + özet (`bodyMedium`, `onSurfaceVariant`).
2. **Metin blokları**: her biri `ProgramSectionCard` (başlık + gövde).
3. **Başvuru alanı**: sayfa altında sabit (`bottomNavigationBar`) `ApplyButton` listesi.

### 6.5 ApplyButton

- `applicationForm` türü: `FilledButton` + `Icons.open_in_new`, "Başvuru Formuna Git".
- `info` türü: `OutlinedButton`, "Detaylı Bilgi".
- Birden fazla link varsa dikey sırala, aralarında `sm` boşluk.
- Link `https://` ile başlamıyorsa buton gösterilmez.

### 6.6 Ortak Durumlar

| Durum | Gösterim |
|---|---|
| Loading | `CircularProgressIndicator` ortada, liste ise skeleton yerine basit shimmer'sız placeholder card |
| Empty | İkon (48px, soluk) + başlık + tek cümle açıklama |
| Error | `error` renkli ikon + mesaj + "Tekrar Dene" butonu (`ref.invalidate`) |

Her `AsyncValue.when` bu üç durumu karşılamak zorunda.

---

## 7. Ekran Davranışları

| Ekran | Not |
|---|---|
| AI Sohbet | Kullanıcı mesajı sağda (primary container), AI sol (surfaceVariant). Altta sabit input + gönder butonu. AI cevabında hukuki/mali alanlarda küçük "Bilgilendirme amaçlıdır" notu. |
| Dosyalar | Liste: dosya ikonu, ad, boyut, tarih. Üstte "Dosya Yükle" `FloatingActionButton.extended`. |
| Kullanıcı Sohbeti | Oda listesi → mesaj ekranı. Okunmamış sayısı `Badge` ile. |
| Toplantı | Yaklaşan toplantılar listesi + "Toplantı Planla" FAB. Tarih/saat için `showDatePicker` + `showTimePicker`. |
| Destek Planlama | Üstte `SegmentedButton` (Mentor / Avukat / Pazarlama / Muhasebe), altında tarih-saat seçimi + not alanı + "Talep Gönder". |

---

## 8. Hareket (Animation)

- Süre: `200 ms`, eğri: `Curves.easeOut`.
- Sayfa geçişi: go_router varsayılanı.
- Rol değişiminde içerik `AnimatedSwitcher` ile fade (200 ms).
- Gereksiz animasyon ekleme, ek animasyon paketi kullanma.

---

## 9. Erişilebilirlik

1. Metin/arka plan kontrastı en az **4.5:1**.
2. Sadece renkle bilgi verme (ikon veya metin ekle).
3. Tüm ikon butonlarında `tooltip` veya `Semantics(label: ...)`.
4. Font ölçeklemeyi bozma, sabit yükseklikli text container kullanma.
5. Dokunma alanı minimum 48x48.

---

## 10. Kod: Theme Dosyaları

### `lib/core/theme/app_spacing.dart`

```dart
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 20;
}
```

### `lib/core/theme/app_colors.dart`

```dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color seed = Color(0xFF3949AB);

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
  static const Color info = Color(0xFF0288D1);

  static const Color bgLight = Color(0xFFF7F8FC);
  static const Color bgDark = Color(0xFF12131A);
  static const Color outlineLight = Color(0xFFD5D8E6);
  static const Color outlineDark = Color(0xFF363A4D);

  // Rol accent renkleri
  static const Color mentor = Color(0xFF3949AB);
  static const Color accountant = Color(0xFF00796B);
  static const Color lawyer = Color(0xFF455A64);
  static const Color investor = Color(0xFFF9A825);
  static const Color marketing = Color(0xFFD81B60);
}
```

### `lib/core/theme/role_style.dart`

```dart
import 'package:flutter/material.dart';
import '../../features/support_space/domain/entities/support_role.dart';
import 'app_colors.dart';

extension SupportRoleStyle on SupportRole {
  Color get accent => switch (this) {
        SupportRole.mentor => AppColors.mentor,
        SupportRole.accountant => AppColors.accountant,
        SupportRole.lawyer => AppColors.lawyer,
        SupportRole.investor => AppColors.investor,
        SupportRole.marketing => AppColors.marketing,