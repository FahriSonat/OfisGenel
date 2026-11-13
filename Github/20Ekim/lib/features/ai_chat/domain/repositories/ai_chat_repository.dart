import '../entities/ai_message.dart';

abstract class AiChatRepository {
  Future<List<AiMessage>> getMessages(String roleSlug);
  Future<AiMessage> sendMessage(String roleSlug, String text);
}
