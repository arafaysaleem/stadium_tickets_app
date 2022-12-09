import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/parking_ticket_model.dart';
import '../models/tickets_summary_model.codegen.dart';

// Features
import '../../parking/parking.dart';
import '../../zone_seats/zone_seats.dart';

final ticketsSummaryProvider = StateProvider.autoDispose((ref) {
  final seats = ref.watch(selectedSeatsProvider);
  final parkingSpacesMap = ref.watch(confirmedParkingSpacesProvider);
  final parkingTickets = parkingSpacesMap.entries
      .map(
    (e) => e.value.map(
      (k) => ParkingTicketModel(floorNo: e.key, spaceModel: k),
    ),
  )
      .fold(
    <ParkingTicketModel>[],
    (prev, element) => [...prev, ...element],
  );
  return TicketsSummaryModel(
    seatTickets: seats,
    parkingTickets: parkingTickets,
  );
});