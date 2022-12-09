import 'package:freezed_annotation/freezed_annotation.dart';

import '../../zone_seats/zone_seats.dart';
import 'parking_ticket_model.dart';

part 'tickets_summary_model.codegen.freezed.dart';

@freezed
class TicketsSummaryModel with _$TicketsSummaryModel {
  const factory TicketsSummaryModel({
    required List<SeatModel> seatTickets,
    @Default(<ParkingTicketModel>[]) List<ParkingTicketModel> parkingTickets,
  }) = _TicketsSummaryModel;
}
