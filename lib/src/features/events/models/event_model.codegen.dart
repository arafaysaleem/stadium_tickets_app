import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';

// Enums
import '../enums/event_type_enum.dart';

part 'event_model.codegen.freezed.dart';
part 'event_model.codegen.g.dart';

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required int eventId,
    required String name,
    required DateTime date,
    @JsonKey(fromJson: AppUtils.timeFromJson, toJson: AppUtils.toNull) required TimeOfDay startTime,
    @JsonKey(fromJson: AppUtils.timeFromJson, toJson: AppUtils.toNull) required TimeOfDay endTime,
    required String posterUrl,
    required EventType eventType,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EventModel;

  factory EventModel.fromJson(JSON json) => _$EventModelFromJson(json);
}
