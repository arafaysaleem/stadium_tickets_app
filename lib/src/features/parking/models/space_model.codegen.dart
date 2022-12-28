import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/typedefs.dart';

part 'space_model.codegen.freezed.dart';
part 'space_model.codegen.g.dart';

@freezed
class SpaceModel with _$SpaceModel {
  const factory SpaceModel({
    required String spaceRow,
    required int spaceNumber,
    required int floorNumber,
  }) = _SpaceModel;

  const SpaceModel._();

  factory SpaceModel.fromJson(JSON json) => _$SpaceModelFromJson(json);

  String get name => '$spaceRow-$spaceNumber';
}
