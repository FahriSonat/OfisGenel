import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/meetings_mock_datasource.dart';
import '../../data/repositories/meetings_repository_impl.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/repositories/meetings_repository.dart';

final meetingsDataSourceProvider = Provider<MeetingsDataSource>((ref) {
  return MeetingsMockDataSource();
});

final meetingsRepositoryProvider = Provider<MeetingsRepository>((ref) {
  final dataSource = ref.watch(meetingsDataSourceProvider);
  return MeetingsRepositoryImpl(dataSource);
});

final meetingsListProvider =
    FutureProvider.family<List<Meeting>, String>((ref, roleSlug) async {
  final repo = ref.watch(meetingsRepositoryProvider);
  return repo.getMeetings(roleSlug);
});
