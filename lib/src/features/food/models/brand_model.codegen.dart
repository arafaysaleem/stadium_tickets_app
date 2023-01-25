import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

part 'brand_model.codegen.freezed.dart';
part 'brand_model.codegen.g.dart';

@freezed
class BrandModel with _$BrandModel {
  const factory BrandModel({
    required int brandId,
    required int categoryId,
    required String name,
    required String logoUrl,
  }) = _BrandModel;

  factory BrandModel.fromJson(JSON json) => _$BrandModelFromJson(json);
}
