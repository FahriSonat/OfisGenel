class Meeting {
  final String id;
  final String roleSlug;
  final String title;
  final String participantName;
  final DateTime dateTime;
  final String status; // 'confirmed', 'pending', 'completed'

  const Meeting({
    required this.id,
    required this.roleSlug,
    required this.title,
    required this.participantName,
    required this.dateTime,
    this.status = 'confirmed',
  });

  String get formattedDateTime {
    final d = dateTime;
    final day = d.day.toString().padLeft(2, '0');
    final month = d.month.toString().padLeft(2, '0');
    final hour = d.hour.toString().padLeft(2, '0');
    final min = d.minute.toString().padLeft(2, '0');
    return '$day.$month.${d.year} - $hour:$min';
  }
}
