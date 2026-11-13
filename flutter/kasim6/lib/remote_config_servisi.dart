import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigServisi {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await _remoteConfig.setDefaults(const{
      'kampanya_aktif': false,
      'kampanya_metni': 'Welcome to the app!',
      'zorunlu_surum': '1.0.0',
    });

    await _remoteConfig.fetchAndActivate();
  }

  String getString(String key) {
    return _remoteConfig.getString(key);
  }

  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  double getDouble(String key) {
    return _remoteConfig.getDouble(key);
  }
}