import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Models
import 'brand_model.codegen.dart';

part 'category_model.codegen.freezed.dart';
part 'category_model.codegen.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required int categoryId,
    required String name,
    required BrandModel sellerBrand,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(JSON json) => _$CategoryModelFromJson(json);
}
