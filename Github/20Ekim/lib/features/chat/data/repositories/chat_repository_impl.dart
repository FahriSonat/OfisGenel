import '../../domain/entities/chat_room.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_mock_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource _dataSource;

  const ChatRepositoryImpl(this._dataSource);

  @override
  Future<List<ChatRoom>> getChatRooms(String roleSlug) async {
    return _dataSource.getChatRooms(roleSlug);
  }

  @override
  Future<List<ChatMessage>> getMessages(String roomId) async {
    return _dataSource.getMessages(roomId);
  }

  @override
  Future<ChatMessage> sendMessage(String roomId, String text) async {
    return _dataSource.sendMessage(roomId, text);
  }
}
