// Features
import '../../zone_seats/zone_seats.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'seat_ticket_model.codegen.freezed.dart';

@freezed
class SeatTicketModel with _$SeatTicketModel {
  const factory SeatTicketModel({
    required SeatModel seatModel,
    String? personName,
    String? personId,
  }) = _SeatTicketModel;
}
