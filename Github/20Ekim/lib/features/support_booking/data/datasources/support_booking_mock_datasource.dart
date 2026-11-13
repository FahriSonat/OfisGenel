import '../models/booking_request_model.dart';
import '../../domain/entities/service_type.dart';

abstract class SupportBookingDataSource {
  Future<List<BookingRequestModel>> getBookings();
  Future<BookingRequestModel> createBooking({
    required ServiceType serviceType,
    required DateTime preferredDate,
    required String note,
  });
}

class SupportBookingMockDataSource implements SupportBookingDataSource {
  final List<BookingRequestModel> _bookings = [];

  SupportBookingMockDataSource() {
    _initDefaultBookings();
  }

  void _initDefaultBookings() {
    final now = DateTime.now();
    _bookings.addAll([
      BookingRequestModel(
        id: 'b1',
        serviceType: ServiceType.mentor,
        preferredDate: now.add(const Duration(days: 3)),
        note: 'Büyüme metrikleri ve pazar doğrulama üzerine seans talebi.',
        createdAt: now.subtract(const Duration(days: 1)),
        status: 'Onaylandı',
      ),
      BookingRequestModel(
        id: 'b2',
        serviceType: ServiceType.lawyer,
        preferredDate: now.add(const Duration(days: 5)),
        note: 'Kurucular sözleşmesi ve hisse opsiyon planı hukuki incelemesi.',
        createdAt: now.subtract(const Duration(hours: 12)),
        status: 'İnceleniyor',
      ),
    ]);
  }

  @override
  Future<List<BookingRequestModel>> getBookings() async {
    await Future.delayed(const Duration(milliseconds: 30));
    return List.from(_bookings);
  }

  @override
  Future<BookingRequestModel> createBooking({
    required ServiceType serviceType,
    required DateTime preferredDate,
    required String note,
  }) async {
    await Future.delayed(const Duration(milliseconds: 60));
    final item = BookingRequestModel(
      id: 'b_${DateTime.now().millisecondsSinceEpoch}',
      serviceType: serviceType,
      preferredDate: preferredDate,
      note: note,
      createdAt: DateTime.now(),
      status: 'Gönderildi',
    );
    _bookings.insert(0, item);
    return item;
  }
}
