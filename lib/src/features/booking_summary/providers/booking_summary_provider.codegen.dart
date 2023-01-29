import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Helpers
import '../../../config/config.dart';

// Models
import '../models/booking_snack_model.codegen.dart';
import '../models/booking_model.codegen.dart';
import '../models/booking_parking_model.codegen.dart';
import '../models/booking_seat_model.codegen.dart';

// Enums
import '../enums/booking_status_enum.dart';

// Repositories
import '../repositories/bookings_repository.codegen.dart';

// Features
import '../../food/food.dart';
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

final snackBookingsProvider =
    StateProvider.autoDispose<List<BookingSnackModel>>((ref) {
  final categorySnacksMap = ref.watch(confirmedCategorySnacksProvider);
  final snackBookings = categorySnacksMap.entries.map(
    (e) {
      final snackMap = e.value;

      return snackMap.entries.map(
        (k) {
          final categories = ref.watch(categoriesFutureProvider).asData!.value;

          String findBrandName(int brandId) {
            for (final category in categories) {
              for (final brand in category.brands) {
                if (brand.brandId == brandId) {
                  return brand.name;
                }
              }
            }
            return '';
          }

          return BookingSnackModel(
            snack: k.key,
            brand: findBrandName(k.key.brandId),
            quantity: k.value,
          );
        },
      );
    },
  ).fold(
    <BookingSnackModel>[],
    (prev, element) => [...prev, ...element],
  );
  return snackBookings;
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
  final seatsTotal = selectedSeats.length * ticketPrice;

  final selectedSpaces = ref.watch(parkingTicketsProvider);
  final parkingPrice = selectedSpaces.isEmpty ? 0 : selectedSpaces.first.price!;
  final parkingTotal = selectedSpaces.length * parkingPrice;

  final selectedSnacks = ref.watch(snackBookingsProvider);
  final snackTotal = selectedSnacks.fold(
    0,
    (prev, element) => prev + (element.quantity * element.snack.price),
  );
  return seatsTotal + parkingTotal + snackTotal;
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
      personContact: Config.countryCode + ref.read(buyerContactProvider)!,
      amountPayable: ref.read(totalAmountProvider),
      zoneId: ref.read(currentZoneProvider)!.zoneId,
      eventId: ref.read(currentEventProvider)!.eventId,
      bookingSeats: seatTickets,
      bookingParkingSpaces: ref.read(parkingTicketsProvider),
      bookingSnacks: ref.read(snackBookingsProvider),
      datetime: DateTime.now(),
      status: BookingStatus.RESERVED,
    );

    final bookingId = bookingsRepository.create(data: data.toJson());

    return bookingId;
  }
}
