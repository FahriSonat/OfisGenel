enum ProgramLinkType {
  applicationForm('Başvuru Formuna Git'),
  info('Detaylı Bilgi');

  const ProgramLinkType(this.defaultLabel);
  final String defaultLabel;
}

class ProgramLink {
  final String url;
  final ProgramLinkType type;
  final String? customLabel;

  const ProgramLink({
    required this.url,
    required this.type,
    this.customLabel,
  });

  bool get isValidHttps => url.startsWith('https://');
  String get label => customLabel ?? type.defaultLabel;
}
