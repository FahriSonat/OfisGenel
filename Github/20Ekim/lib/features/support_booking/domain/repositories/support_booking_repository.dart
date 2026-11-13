import '../entities/service_type.dart';

abstract class SupportBookingRepository {
  Future<List<BookingRequest>> getBookings();
  Future<BookingRequest> createBooking({
    required ServiceType serviceType,
    required DateTime preferredDate,
    required String note,
  });
}
