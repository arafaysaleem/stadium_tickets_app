import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/card_details_model.codegen.dart';

// Features
import '../../stadium_zones/stadium_zones.dart';
import '../../tickets_summary/tickets_summary.dart';

final totalAmountProvider = Provider.autoDispose<int>((ref) {
  final ticketsSummary = ref.watch(ticketsSummaryProvider);
  final ticketPrice = ref.watch(
    currentZoneProvider.select((value) => value!.type.price),
  );
  final selectedSeats = ticketsSummary.seatTickets;
  final selectedSpaces = ticketsSummary.parkingTickets;
  final total =
      selectedSeats.length * ticketPrice + selectedSpaces.length * ticketPrice;
  return total;
});

final cardDetailsProvider = StateProvider.autoDispose<CardDetailsModel?>((ref) {
  return null;
});
