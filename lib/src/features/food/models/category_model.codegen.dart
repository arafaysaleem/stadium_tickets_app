import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Models
import 'brand_model.codegen.dart';

part 'category_model.codegen.freezed.dart';
part 'category_model.codegen.g.dart';

@freezed
class CategoryModel extends Equatable with _$CategoryModel {
  const factory CategoryModel({
    required int categoryId,
    required String name,
    required List<BrandModel> brands,
  }) = _CategoryModel;
  
  const CategoryModel._();

  factory CategoryModel.fromJson(JSON json) => _$CategoryModelFromJson(json);
  
  @override
  List<Object?> get props => [categoryId, name];
}
