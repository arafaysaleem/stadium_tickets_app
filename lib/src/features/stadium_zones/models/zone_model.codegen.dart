import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';
import 'zone_type_model.codegen.dart';

part 'zone_model.codegen.freezed.dart';
part 'zone_model.codegen.g.dart';

@freezed
class ZoneModel with _$ZoneModel {
  const factory ZoneModel({
    required int zoneId,
    required int number,
    required String name,
    required int numOfRows,
    required int seatsPerRow,
    required String colorHexCode,
    required ZoneTypeModel type,
  }) = _ZoneModel;

  factory ZoneModel.fromJson(JSON json) => _$ZoneModelFromJson(json);
}
