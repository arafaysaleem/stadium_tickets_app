import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';
import '../enums/resource_type_enum.dart';

part 'zone_resource_model.codegen.freezed.dart';
part 'zone_resource_model.codegen.g.dart';

@freezed
class ZoneResourceModel with _$ZoneResourceModel {
  const factory ZoneResourceModel({
    required int resourceId,
    required String resourceUrl,
    required int zoneId,
    required ResourceType type,
  }) = _ZoneResourceModel;

  factory ZoneResourceModel.fromJson(JSON json) => _$ZoneResourceModelFromJson(json);
}
