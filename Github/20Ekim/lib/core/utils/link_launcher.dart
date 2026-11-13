abstract class LinkLauncher {
  Future<bool> canLaunch(String url);
  Future<bool> launch(String url);
}

class PlaceholderLinkLauncher implements LinkLauncher {
  const PlaceholderLinkLauncher();

  @override
  Future<bool> canLaunch(String url) async {
    return url.startsWith('https://');
  }

  @override
  Future<bool> launch(String url) async {
    // Gerçek paket entegrasyonu (örn. url_launcher) kullanıcı onayı ile eklenecektir.
    return true;
  }
}
