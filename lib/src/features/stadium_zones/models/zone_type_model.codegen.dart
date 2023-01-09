import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

part 'zone_type_model.codegen.freezed.dart';
part 'zone_type_model.codegen.g.dart';

@freezed
class ZoneTypeModel with _$ZoneTypeModel {
  const factory ZoneTypeModel({
    required int zTypeId,
    required String type,
    required int price,
  }) = _ZoneTypeModel;

  factory ZoneTypeModel.fromJson(JSON json) => _$ZoneTypeModelFromJson(json);
}
