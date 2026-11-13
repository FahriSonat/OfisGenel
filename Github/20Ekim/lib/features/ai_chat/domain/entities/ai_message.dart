enum AiSender {
  user,
  assistant,
}

class AiMessage {
  final String id;
  final String roleSlug;
  final String text;
  final AiSender sender;
  final DateTime timestamp;
  final bool showLegalDisclaimer;

  const AiMessage({
    required this.id,
    required this.roleSlug,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.showLegalDisclaimer = false,
  });
}
