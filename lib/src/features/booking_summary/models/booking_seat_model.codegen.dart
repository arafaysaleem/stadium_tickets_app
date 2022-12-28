// Features
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/typedefs.dart';

part 'booking_seat_model.codegen.freezed.dart';
part 'booking_seat_model.codegen.g.dart';

@freezed
class BookingSeatModel with _$BookingSeatModel {
  const factory BookingSeatModel({
    String? seatRow,
    int? seatNumber,
    String? personName,
    String? identificationNumber,
  }) = _BookingSeatModel;

  factory BookingSeatModel.fromJson(JSON json) =>
      _$BookingSeatModelFromJson(json);
}
