import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsServisi {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> kullaniciTanit({
    required String uid,
    required String rol,
  }) async {
    await _analytics.setUserId(id: uid);
    await _analytics.setUserProperty(name: 'rol', value: rol);
    await _analytics.setUserProperty(name: 'platform', value: 'flutter');
  }

  Future<void> logEkle(String event, {Map<String, dynamic>? parametreler}) async {
    await _analytics.logEvent(name: event, parameters: parametreler);
  }
}