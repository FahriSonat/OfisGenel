import '../../domain/entities/ai_message.dart';

class AiMessageModel extends AiMessage {
  const AiMessageModel({
    required super.id,
    required super.roleSlug,
    required super.text,
    required super.sender,
    required super.timestamp,
    super.showLegalDisclaimer,
  });

  factory AiMessageModel.fromMap(Map<String, dynamic> map) {
    return AiMessageModel(
      id: map['id'] as String,
      roleSlug: map['roleSlug'] as String,
      text: map['text'] as String,
      sender: map['sender'] == 'assistant' ? AiSender.assistant : AiSender.user,
      timestamp: DateTime.parse(map['timestamp'] as String),
      showLegalDisclaimer: map['showLegalDisclaimer'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roleSlug': roleSlug,
      'text': text,
      'sender': sender.name,
      'timestamp': timestamp.toIso8601String(),
      'showLegalDisclaimer': showLegalDisclaimer,
    };
  }
}
