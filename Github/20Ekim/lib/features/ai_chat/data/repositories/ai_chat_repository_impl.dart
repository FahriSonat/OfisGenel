import '../../domain/entities/ai_message.dart';
import '../../domain/repositories/ai_chat_repository.dart';
import '../datasources/ai_chat_mock_datasource.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  final AiChatDataSource _dataSource;

  const AiChatRepositoryImpl(this._dataSource);

  @override
  Future<List<AiMessage>> getMessages(String roleSlug) async {
    return _dataSource.getMessages(roleSlug);
  }

  @override
  Future<AiMessage> sendMessage(String roleSlug, String text) async {
    return _dataSource.sendMessage(roleSlug, text);
  }
}
