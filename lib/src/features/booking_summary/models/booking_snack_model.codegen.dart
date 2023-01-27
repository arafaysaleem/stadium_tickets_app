// Features
import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Features
import '../../food/food.dart';

part 'booking_snack_model.codegen.freezed.dart';
part 'booking_snack_model.codegen.g.dart';

@freezed
class BookingSnackModel with _$BookingSnackModel {
  const factory BookingSnackModel({
    required SnackModel snack,
    required int quantity,
  }) = _BookingSnackModel;
  const BookingSnackModel._();

  factory BookingSnackModel.fromJson(JSON json) =>
      _$BookingSnackModelFromJson(json);

  JSON toCustomJson() {
    return <String, dynamic>{
      'snack_id': snack.snackId,
      'quantity': quantity,
    };
  }
}
