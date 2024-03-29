import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Models
import 'space_model.codegen.dart';

part 'parking_floor_model.codegen.freezed.dart';
part 'parking_floor_model.codegen.g.dart';

@freezed
class ParkingFloorModel with _$ParkingFloorModel {
  const factory ParkingFloorModel({
    required int pFloorId,
    required int floorNumber,
    required int numOfRows,
    required int spacesPerRow,
    required int price,
    required List<SpaceModel> missing,
    required List<SpaceModel> blocked,
  }) = _ParkingFloorModel;

  factory ParkingFloorModel.fromJson(JSON json) => _$ParkingFloorModelFromJson(json);
}
