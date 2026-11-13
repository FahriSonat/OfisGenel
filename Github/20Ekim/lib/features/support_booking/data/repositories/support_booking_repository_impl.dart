import '../../domain/entities/service_type.dart';
import '../../domain/repositories/support_booking_repository.dart';
import '../datasources/support_booking_mock_datasource.dart';

class SupportBookingRepositoryImpl implements SupportBookingRepository {
  final SupportBookingDataSource _dataSource;

  const SupportBookingRepositoryImpl(this._dataSource);

  @override
  Future<List<BookingRequest>> getBookings() async {
    return _dataSource.getBookings();
  }

  @override
  Future<BookingRequest> createBooking({
    required ServiceType serviceType,
    required DateTime preferredDate,
    required String note,
  }) async {
    return _dataSource.createBooking(
      serviceType: serviceType,
      preferredDate: preferredDate,
      note: note,
    );
  }
}
