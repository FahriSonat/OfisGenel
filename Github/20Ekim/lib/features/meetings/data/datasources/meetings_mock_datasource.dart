import '../models/meeting_model.dart';

abstract class MeetingsDataSource {
  Future<List<MeetingModel>> getMeetings(String roleSlug);
  Future<MeetingModel> scheduleMeeting({
    required String roleSlug,
    required String title,
    required String participantName,
    required DateTime dateTime,
  });
}

class MeetingsMockDataSource implements MeetingsDataSource {
  final Map<String, List<MeetingModel>> _meetingsByRole = {};

  MeetingsMockDataSource() {
    _initMeetings();
  }

  void _initMeetings() {
    final now = DateTime.now();
    _meetingsByRole['mentor'] = [
      MeetingModel(
        id: 'mt_m1',
        roleSlug: 'mentor',
        title: 'Aylık Strateji ve İlerleme Değerlendirmesi',
        participantName: 'Ahmet Yılmaz (Kıdemli Mentor)',
        dateTime: now.add(const Duration(days: 2, hours: 3)),
        status: 'confirmed',
      ),
      MeetingModel(
        id: 'mt_m2',
        roleSlug: 'mentor',
        title: 'Müşteri Doğrulama Gözden Geçirme',
        participantName: 'Selin Kaya (Girişim Mentoru)',
        dateTime: now.add(const Duration(days: 6, hours: 1)),
        status: 'confirmed',
      ),
    ];

    _meetingsByRole['lawyer'] = [
      MeetingModel(
        id: 'mt_l1',
        roleSlug: 'lawyer',
        title: 'Ortaklar Sözleşmesi ve Vesting Seansı',
        participantName: 'Av. Mehmet Demir',
        dateTime: now.add(const Duration(days: 3, hours: 4)),
        status: 'confirmed',
      ),
    ];

    _meetingsByRole['accountant'] = [
      MeetingModel(
        id: 'mt_a1',
        roleSlug: 'accountant',
        title: 'Ar-Ge Teşvikleri ve Bordro Planlama',
        participantName: 'SMMM Ayşe Çetin',
        dateTime: now.add(const Duration(days: 1, hours: 5)),
        status: 'confirmed',
      ),
    ];

    _meetingsByRole['investor'] = [
      MeetingModel(
        id: 'mt_i1',
        roleSlug: 'investor',
        title: 'Ön Değerleme ve Pitch Provası',
        participantName: 'Burak Tan (Melek Yatırımcı)',
        dateTime: now.add(const Duration(days: 4, hours: 2)),
        status: 'confirmed',
      ),
    ];

    _meetingsByRole['marketing'] = [
      MeetingModel(
        id: 'mt_mk1',
        roleSlug: 'marketing',
        title: 'Q2 Pazarlama Kampanyası & Büyüme Seansı',
        participantName: 'Ece Güner (Growth Danışmanı)',
        dateTime: now.add(const Duration(days: 5, hours: 3)),
        status: 'confirmed',
      ),
    ];
  }

  @override
  Future<List<MeetingModel>> getMeetings(String roleSlug) async {
    await Future.delayed(const Duration(milliseconds: 30));
    return List.from(_meetingsByRole[roleSlug] ?? []);
  }

  @override
  Future<MeetingModel> scheduleMeeting({
    required String roleSlug,
    required String title,
    required String participantName,
    required DateTime dateTime,
  }) async {
    await Future.delayed(const Duration(milliseconds: 60));
    final meeting = MeetingModel(
      id: 'mt_${DateTime.now().millisecondsSinceEpoch}',
      roleSlug: roleSlug,
      title: title,
      participantName: participantName,
      dateTime: dateTime,
      status: 'pending',
    );
    _meetingsByRole.putIfAbsent(roleSlug, () => []).insert(0, meeting);
    return meeting;
  }
}
