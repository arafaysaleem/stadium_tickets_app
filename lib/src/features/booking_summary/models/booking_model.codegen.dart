import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';

// Enums
import '../enums/booking_status_enum.dart';
import 'booking_parking_model.codegen.dart';
import 'booking_seat_model.codegen.dart';

part 'booking_model.codegen.freezed.dart';
part 'booking_model.codegen.g.dart';

@freezed
class BookingModel with _$BookingModel {
  const factory BookingModel({
    required String personName,
    required String personEmail,
    required int amountPayable,
    @JsonKey(toJson: AppUtils.dateTimeToJson) required DateTime datetime,
    required BookingStatus status,
    required int zoneId,
    required int eventId,
    required List<BookingSeatModel> bookingSeats,
    required List<BookingParkingModel> bookingParkingSpaces,
  }) = _BookingModel;

  factory BookingModel.fromJson(JSON json) => _$BookingModelFromJson(json);
}
