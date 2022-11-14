import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

import '../../zone_seats/model/zone_seat_model.codegen.dart';

part 'zone_seating_model.codegen.freezed.dart';
part 'zone_seating_model.codegen.g.dart';

@freezed
class ZoneSeatingModel with _$ZoneSeatingModel {
  const factory ZoneSeatingModel({
    required List<ZoneSeatModel> missing,
    required List<ZoneSeatModel> blocked,
    required List<ZoneSeatModel> booked,
  }) = _ZoneSeatingModel;

  factory ZoneSeatingModel.fromJson(JSON json) => _$ZoneSeatingModelFromJson(json);
}
