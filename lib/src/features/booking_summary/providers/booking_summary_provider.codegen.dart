import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Models
import '../models/booking_model.codegen.dart';
import '../models/booking_parking_model.codegen.dart';
import '../models/booking_seat_model.codegen.dart';

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
      (k) {
        final pFloor = ref
            .watch(parkingFloorsFutureProvider)
            .asData!
            .value
            .firstWhere((element) => element.pFloorId == e.key);
        return BookingParkingModel(
          spaceNumber: k.spaceNumber,
          spaceRow: k.spaceRow,
          floorNo: pFloor.floorNumber,
          price: pFloor.price,
          pFloorId: e.key,
        );
      },
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
final buyerContactProvider = StateProvider.autoDispose<String?>((ref) => null);

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

/// A provider used to access instance of this service
@riverpod
BookingSummaryProvider bookingSummary(BookingSummaryRef ref) {
  return BookingSummaryProvider(ref);
}

class BookingSummaryProvider {
  final Ref ref;

  BookingSummaryProvider(this.ref);

  Future<int> reserveBooking() async {
    final bookingsRepository = ref.read(bookingsRepositoryProvider);

    final seatTickets = ref.read(seatTicketsProvider);
    final data = BookingModel(
      personName: seatTickets.first.personName!,
      personEmail: ref.read(buyerEmailProvider)!,
      personContact: ref.read(buyerContactProvider)!,
      amountPayable: ref.read(totalAmountProvider),
      zoneId: ref.read(currentZoneProvider)!.zoneId,
      eventId: ref.read(currentEventProvider)!.eventId,
      bookingSeats: seatTickets,
      bookingParkingSpaces: ref.read(parkingTicketsProvider),
      datetime: DateTime.now(),
      status: BookingStatus.RESERVED,
    );

    final bookingId = bookingsRepository.create(data: data.toJson());

    return bookingId;
  }
}
