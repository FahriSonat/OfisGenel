import '../../domain/entities/meeting.dart';

class MeetingModel extends Meeting {
  const MeetingModel({
    required super.id,
    required super.roleSlug,
    required super.title,
    required super.participantName,
    required super.dateTime,
    super.status,
  });

  factory MeetingModel.fromMap(Map<String, dynamic> map) {
    return MeetingModel(
      id: map['id'] as String,
      roleSlug: map['roleSlug'] as String,
      title: map['title'] as String,
      participantName: map['participantName'] as String,
      dateTime: DateTime.parse(map['dateTime'] as String),
      status: map['status'] as String? ?? 'confirmed',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roleSlug': roleSlug,
      'title': title,
      'participantName': participantName,
      'dateTime': dateTime.toIso8601String(),
      'status': status,
    };
  }
}
