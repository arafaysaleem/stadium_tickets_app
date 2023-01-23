import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

part 'snack_model.codegen.freezed.dart';
part 'snack_model.codegen.g.dart';

@freezed
class SnackModel extends Equatable with _$SnackModel {
  const factory SnackModel({
    required int snackId,
    required int categoryId,
    required String name,
    required int price,
    required String imageUrl,
  }) = _SnackModel;

  const SnackModel._();

  factory SnackModel.fromJson(JSON json) => _$SnackModelFromJson(json);

  @override
  List<Object?> get props => [snackId];
}
