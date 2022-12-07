import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

import 'space_model.codegen.dart';

part 'parking_floor_spaces_model.codegen.freezed.dart';
part 'parking_floor_spaces_model.codegen.g.dart';

@freezed
class ParkingFloorSpacesModel with _$ParkingFloorSpacesModel {
  const factory ParkingFloorSpacesModel({
    required List<SpaceModel> missing,
    required List<SpaceModel> blocked,
    required List<SpaceModel> booked,
  }) = _ParkingFloorSpacesModel;

  factory ParkingFloorSpacesModel.fromJson(JSON json) => _$ParkingFloorSpacesModelFromJson(json);
}
