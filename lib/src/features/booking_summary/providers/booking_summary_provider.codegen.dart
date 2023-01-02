import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Models
import '../models/booking_model.codegen.dart';
import '../models/booking_parking_model.codegen.dart';
import '../models/booking_seat_model.codegen.dart';

// Helpers
import '../../../helpers/extensions/extensions.dart';

// Enums
import '../enums/booking_status_enum.dart';

// Repositories
import '../repositories/bookings_repository.codegen.dart';

// Features
import '../../parking/parking.dart';
import '../../zone_seats/zone_seats.dart';
import '../../events/events.dart';
import '../../stadium_zones/stadium_zones.dart';

part 'booking_summary_provider.codegen.g.dart';

final parkingTicketsProvider =
    StateProvider.autoDispose<List<BookingParkingModel>>((ref) {
  final parkingSpacesMap = ref.watch(confirmedParkingSpacesProvider);
  final parkingTickets = parkingSpacesMap.entries
      .map(
    (e) => e.value.map(
      (k) => BookingParkingModel(
        spaceNumber: k.spaceNumber,
        spaceRow: k.spaceRow,
        pFloorId: e.key,
        floorNo: k.floorNumber,
      ),
    ),
  )
      .fold(
    <BookingParkingModel>[],
    (prev, element) => [...prev, ...element],
  );
  return parkingTickets;
});

final seatTicketsProvider =
    StateProvider.autoDispose<List<BookingSeatModel>>((ref) {
  final seats = ref.watch(selectedSeatsProvider);
  final seatTickets = [
    for (var s in seats)
      BookingSeatModel(
        seatNumber: s.seatNumber,
        seatRow: s.seatRow,
      )
  ];
  return seatTickets;
});

final buyerEmailProvider = StateProvider.autoDispose<String?>((ref) => null);

final totalAmountProvider = Provider.autoDispose<int>((ref) {
  final ticketPrice = ref.watch(
    currentZoneProvider.select((value) => value!.type.price),
  );
  final selectedSeats = ref.watch(seatTicketsProvider);
  final selectedSpaces = ref.watch(parkingTicketsProvider);
  final total =
      selectedSeats.length * ticketPrice + selectedSpaces.length * ticketPrice;
  return total;
});

final reservedBookingProvider = Provider.autoDispose<int?>((ref) {
  final bookingSummary = ref.watch(bookingSummaryProvider);
  return bookingSummary.asData?.value;
});

@riverpod
class BookingSummary extends _$BookingSummary {
  @override
  FutureOr<int?> build() => null;

  Future<void> reserveBooking() async {
    final bookingsRepository = ref.read(bookingsRepositoryProvider);
    state = const AsyncLoading();

    state = await state.makeGuardedRequest(() {
      final data = BookingModel(
        personEmail: ref.read(buyerEmailProvider)!,
        amountPayable: ref.read(totalAmountProvider),
        zoneId: ref.read(currentZoneProvider)!.zoneId,
        eventId: ref.read(currentEventProvider)!.eventId,
        bookingSeats: ref.read(seatTicketsProvider),
        bookingParkingSpaces: ref.read(parkingTicketsProvider),
        dateTime: DateTime.now(),
        status: BookingStatus.RESERVED,
      );

      final bookingId = bookingsRepository.create(data: data.toJson());

      return bookingId;
    });
  }
}
