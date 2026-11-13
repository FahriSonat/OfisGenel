enum ServiceType {
  mentor('Mentor'),
  lawyer('Avukat'),
  marketing('Pazarlama'),
  accountant('Muhasebe');

  const ServiceType(this.label);
  final String label;

  static ServiceType? tryParse(String slug) {
    for (final s in ServiceType.values) {
      if (s.name == slug) return s;
    }
    return null;
  }
}

class BookingRequest {
  final String id;
  final ServiceType serviceType;
  final DateTime preferredDate;
  final String note;
  final DateTime createdAt;
  final String status;

  const BookingRequest({
    required this.id,
    required this.serviceType,
    required this.preferredDate,
    required this.note,
    required this.createdAt,
    this.status = 'Gönderildi',
  });
}
