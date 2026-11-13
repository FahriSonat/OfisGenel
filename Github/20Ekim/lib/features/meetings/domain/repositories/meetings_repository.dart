import '../entities/meeting.dart';

abstract class MeetingsRepository {
  Future<List<Meeting>> getMeetings(String roleSlug);
  Future<Meeting> scheduleMeeting({
    required String roleSlug,
    required String title,
    required String participantName,
    required DateTime dateTime,
  });
}
