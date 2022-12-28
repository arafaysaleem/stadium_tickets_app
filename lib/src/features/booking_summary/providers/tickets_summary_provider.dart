import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/booking_parking_model.codegen.dart';
import '../models/booking_seat_model.codegen.dart';

// Features
import '../../parking/parking.dart';
import '../../zone_seats/zone_seats.dart';

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
