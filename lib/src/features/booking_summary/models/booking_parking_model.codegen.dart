// Features
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';

part 'booking_parking_model.codegen.freezed.dart';
part 'booking_parking_model.codegen.g.dart';

@freezed
class BookingParkingModel with _$BookingParkingModel {
  const factory BookingParkingModel({
    required String? spaceRow,
    required int? spaceNumber,
    required int? pFloorId,
    required int? price,
    @JsonKey(toJson: AppUtils.toNull) required int? floorNo,
  }) = _BookingParkingModel;

  factory BookingParkingModel.fromJson(JSON json) =>
      _$BookingParkingModelFromJson(json);
}
