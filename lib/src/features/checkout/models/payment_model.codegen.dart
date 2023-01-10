import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';
import 'card_details_model.codegen.dart';

part 'payment_model.codegen.freezed.dart';
part 'payment_model.codegen.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    @JsonKey(toJson: AppUtils.dateToJson) required DateTime orderDate,
    required int orderAmount,
    required PaymentEventModel event,
    required PaymentSeatsModel seats,
    required PaymentParkingModel parking,
    @JsonKey(toJson: AppUtils.toNull, includeIfNull: false) CardDetailsModel? card,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(JSON json) => _$PaymentModelFromJson(json);
}

@freezed
class PaymentEventModel with _$PaymentEventModel {
  const factory PaymentEventModel({
    @JsonKey(toJson: AppUtils.dateToJson) required DateTime date,
    required String name,
    @JsonKey(toJson: AppUtils.timeToJson, fromJson: AppUtils.timeFromJson) required TimeOfDay time,
  }) = _PaymentEventModel;

  factory PaymentEventModel.fromJson(JSON json) => _$PaymentEventModelFromJson(json);
}

@freezed
class PaymentSeatsModel with _$PaymentSeatsModel {
  const factory PaymentSeatsModel({
    required int price,
    required int qty,
    required int total,
  }) = _PaymentSeatsModel;

  factory PaymentSeatsModel.fromJson(JSON json) => _$PaymentSeatsModelFromJson(json);
}

@freezed
class PaymentParkingModel with _$PaymentParkingModel {
  const factory PaymentParkingModel({
    required int price,
    required int qty,
    required int total,
  }) = _PaymentParkingModel;

  factory PaymentParkingModel.fromJson(JSON json) => _$PaymentParkingModelFromJson(json);
}
