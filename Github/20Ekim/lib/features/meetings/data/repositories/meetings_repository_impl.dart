import '../../domain/entities/meeting.dart';
import '../../domain/repositories/meetings_repository.dart';
import '../datasources/meetings_mock_datasource.dart';

class MeetingsRepositoryImpl implements MeetingsRepository {
  final MeetingsDataSource _dataSource;

  const MeetingsRepositoryImpl(this._dataSource);

  @override
  Future<List<Meeting>> getMeetings(String roleSlug) async {
    return _dataSource.getMeetings(roleSlug);
  }

  @override
  Future<Meeting> scheduleMeeting({
    required String roleSlug,
    required String title,
    required String participantName,
    required DateTime dateTime,
  }) async {
    return _dataSource.scheduleMeeting(
      roleSlug: roleSlug,
      title: title,
      participantName: participantName,
      dateTime: dateTime,
    );
  }
}
