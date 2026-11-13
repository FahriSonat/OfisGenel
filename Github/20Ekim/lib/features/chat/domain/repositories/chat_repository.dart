import '../entities/chat_room.dart';

abstract class ChatRepository {
  Future<List<ChatRoom>> getChatRooms(String roleSlug);
  Future<List<ChatMessage>> getMessages(String roomId);
  Future<ChatMessage> sendMessage(String roomId, String text);
}
