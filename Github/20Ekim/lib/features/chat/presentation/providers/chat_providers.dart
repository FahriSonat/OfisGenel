import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/chat_mock_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/entities/chat_room.dart';
import '../../domain/repositories/chat_repository.dart';

final chatDataSourceProvider = Provider<ChatDataSource>((ref) {
  return ChatMockDataSource();
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final dataSource = ref.watch(chatDataSourceProvider);
  return ChatRepositoryImpl(dataSource);
});

final chatRoomsProvider =
    FutureProvider.family<List<ChatRoom>, String>((ref, roleSlug) async {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.getChatRooms(roleSlug);
});

final chatMessagesProvider =
    FutureProvider.family<List<ChatMessage>, String>((ref, roomId) async {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.getMessages(roomId);
});
