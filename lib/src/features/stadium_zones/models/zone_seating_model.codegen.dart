import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';
import '../../zone_seats/zone_seats.dart';

part 'zone_seating_model.codegen.freezed.dart';
part 'zone_seating_model.codegen.g.dart';

@freezed
class ZoneSeatingModel with _$ZoneSeatingModel {
  const factory ZoneSeatingModel({
    required List<SeatModel> missing,
    required List<SeatModel> blocked,
    required List<SeatModel> booked,
  }) = _ZoneSeatingModel;

  factory ZoneSeatingModel.fromJson(JSON json) => _$ZoneSeatingModelFromJson(json);
}
