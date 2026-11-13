import '../../domain/entities/service_type.dart';

class BookingRequestModel extends BookingRequest {
  const BookingRequestModel({
    required super.id,
    required super.serviceType,
    required super.preferredDate,
    required super.note,
    required super.createdAt,
    super.status,
  });

  factory BookingRequestModel.fromMap(Map<String, dynamic> map) {
    return BookingRequestModel(
      id: map['id'] as String,
      serviceType: ServiceType.values.firstWhere(
        (s) => s.name == map['serviceType'],
        orElse: () => ServiceType.mentor,
      ),
      preferredDate: DateTime.parse(map['preferredDate'] as String),
      note: map['note'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      status: map['status'] as String? ?? 'Gönderildi',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serviceType': serviceType.name,
      'preferredDate': preferredDate.toIso8601String(),
      'note': note,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }
}
