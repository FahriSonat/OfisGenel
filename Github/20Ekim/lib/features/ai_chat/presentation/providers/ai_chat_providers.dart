import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/ai_chat_mock_datasource.dart';
import '../../data/repositories/ai_chat_repository_impl.dart';
import '../../domain/entities/ai_message.dart';
import '../../domain/repositories/ai_chat_repository.dart';

final aiChatDataSourceProvider = Provider<AiChatDataSource>((ref) {
  return AiChatMockDataSource();
});

final aiChatRepositoryProvider = Provider<AiChatRepository>((ref) {
  final dataSource = ref.watch(aiChatDataSourceProvider);
  return AiChatRepositoryImpl(dataSource);
});

final aiChatMessagesProvider =
    FutureProvider.family<List<AiMessage>, String>((ref, roleSlug) async {
  final repo = ref.watch(aiChatRepositoryProvider);
  return repo.getMessages(roleSlug);
});
