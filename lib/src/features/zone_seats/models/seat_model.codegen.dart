import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/typedefs.dart';

part 'seat_model.codegen.freezed.dart';
part 'seat_model.codegen.g.dart';

@freezed
class SeatModel with _$SeatModel {
  const factory SeatModel({
    required String seatRow,
    required int seatNumber,
  }) = _SeatModel;
  
  const SeatModel._();

  factory SeatModel.fromJson(JSON json) => _$SeatModelFromJson(json);

  String get name => '$seatRow-$seatNumber';
}
