import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/typedefs.dart';

part 'zone_seat_model.codegen.freezed.dart';
part 'zone_seat_model.codegen.g.dart';

@freezed
class ZoneSeatModel with _$ZoneSeatModel {
  const factory ZoneSeatModel({
    required String seatRow,
    required int seatNumber,
  }) = _ZoneSeatModel;

  factory ZoneSeatModel.fromJson(JSON json) => _$ZoneSeatModelFromJson(json);
}
