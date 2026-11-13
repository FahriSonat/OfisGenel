import 'package:firebase_analytics/firebase_analytics.dart';

class AnalitikServisi {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> ekranGoruntulemeKaydet(String ekranAdi) async {
    await _analytics.logScreenView(screenName: ekranAdi);
  }

  Future<void> butonTiklandi({
    required String butonAdi,
    required String kategori,
  }) async {
    await _analytics.logEvent(
      name: 'buton_tiklandi',
      parameters: {
        'buton_adi': butonAdi,
        'kategori': kategori,
        'zaman': DateTime.now().toIso8601String(),
      },
    );
  }
  Future<void> sepeteEklendi({
    required String urunId,
    required String fiyat,
  }) async {
    await _analytics.logEvent(
      name: 'sepete_eklendi',
      parameters: {
        'urun_id': urunId,
        'fiyat': fiyat,
        'parabirimi': 'TL',
      },
    );
  }

  Future<void> olayKaydet(String olayAdi, {Map<String, dynamic>? parametreler}) async {
    await _analytics.logEvent(name: olayAdi, parameters: parametreler);
  }
}