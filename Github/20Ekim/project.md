# Girişimcilik Uygulaması
Bu döküman Flutter projesinde geliştirme yapacak olan ajan yapay zeka ve geliştiriciler için bağlayıcı bir kılavuzdur. Projede üretilen her kod satırı burdaki kurallara UYMAK ZORUNDADIR.

## 1.Projenin Özeti ve Teknolojiler 
- **Uygulama Adı:** 
-**Hedef Platform:** İos, Android öncelikli ardından web ve masaüstü.
**Flutter SDK:** 3.39.0 (Öncesi kabul edilmez)
**Dart SDK:** 3.10.1 (Öncesi kabul edilmez)
**Tasarım Dili:** Material 3, Koyu Tema (Dark Theme)

## Mimari Yapı : Özellik bazlı (feature-based) katmanlı mimari kullanılacaktır.

lib/
├─ core/
extensions/
│  ├─ theme/             # Temel tema ayarları
│  ├─ constants/         # Sabitler
│  ├─ utils/             # Yardımcı fonksiyonlar
│  └─ navigation/        # Navigasyon (go_router)
│
├─ features/
│ presentation/
│
├── screens/
│   ├── LoginScreen
│   ├── RegisterScreen
│   ├── HomeScreen
│   ├── StartupDetailScreen
│   ├── CreateStartupScreen
│   └── ProfileScreen
│
├── components/
│   ├── StartupCard
│   ├── Button
│   ├── Input
│   ├── Navbar
│   └── Loading
│
└── navigation/
    └── AppNavigator


## 3 Kırmızı çizgiler
1- **State Yönetim Standartları:**
Sayfa düzeyinde ağır 'setState' KULLANILMAYACAKTIR.
Sadece yerel arayüz durumunu yöneten (örneğin buton animasyonları vb.) StatefulWidget kabul edilir.

## 4 geliştirme kuralları 
ajan yaptığı herhangi bir kod değişikliklerinden sonra mutlaka alttaki komutlarun çalıştığını doğrulamalıdır.

* **statik kod analizi**
```bash
flutter analyze
````

* **Birim testleri**
```bash
flutter test
```
* **projeyi çalıştırma**
```bash
flutter run
```
## % ajanın çıktı ve yanıt verme standartları 
**açıklamlar** Türkçe teknik terimlerin özünü bozmadan net ve doğrudan olacaktır.
** değişiklik önerileri ** her zaman projenin mevcut mimari ve kodlama standartlarına tam uyum sağlamalıdır.