import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/support_booking_mock_datasource.dart';
import '../../data/repositories/support_booking_repository_impl.dart';
import '../../domain/entities/service_type.dart';
import '../../domain/repositories/support_booking_repository.dart';

final supportBookingDataSourceProvider =
    Provider<SupportBookingDataSource>((ref) {
  return SupportBookingMockDataSource();
});

final supportBookingRepositoryProvider =
    Provider<SupportBookingRepository>((ref) {
  final dataSource = ref.watch(supportBookingDataSourceProvider);
  return SupportBookingRepositoryImpl(dataSource);
});

class SupportBookingNotifier extends AsyncNotifier<List<BookingRequest>> {
  @override
  FutureOr<List<BookingRequest>> build() async {
    final repo = ref.watch(supportBookingRepositoryProvider);
    return repo.getBookings();
  }

  Future<void> createBookingRequest({
    required ServiceType serviceType,
    required DateTime preferredDate,
    required String note,
  }) async {
    final repo = ref.read(supportBookingRepositoryProvider);
    state = const AsyncLoading();
    try {
      await repo.createBooking(
        serviceType: serviceType,
        preferredDate: preferredDate,
        note: note,
      );
      final updated = await repo.getBookings();
      state = AsyncData(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final supportBookingListProvider =
    AsyncNotifierProvider<SupportBookingNotifier, List<BookingRequest>>(
  SupportBookingNotifier.new,
);
