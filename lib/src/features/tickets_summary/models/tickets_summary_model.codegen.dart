import 'package:freezed_annotation/freezed_annotation.dart';

import 'parking_ticket_model.dart';
import 'seat_ticket_model.codegen.dart';

part 'tickets_summary_model.codegen.freezed.dart';

@freezed
class TicketsSummaryModel with _$TicketsSummaryModel {
  const factory TicketsSummaryModel({
    required List<SeatTicketModel> seatTickets,
    @Default(<ParkingTicketModel>[]) List<ParkingTicketModel> parkingTickets,
  }) = _TicketsSummaryModel;

  const TicketsSummaryModel._();

  bool get personDetailsAdded {
    return seatTickets.every((element) => element.personId != null);
  }
}
