import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';

// Enums
import '../enums/event_status_enum.dart';

part 'event_model.codegen.freezed.dart';
part 'event_model.codegen.g.dart';

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required int eventId,
    required String name,
    required DateTime date,
    @JsonKey(fromJson: AppUtils.timeFromJson, toJson: AppUtils.toNull)
        required TimeOfDay startTime,
    @JsonKey(fromJson: AppUtils.timeFromJson, toJson: AppUtils.toNull)
        required TimeOfDay endTime,
    required String posterUrl,
    required EventStatus eventStatus,
  }) = _EventModel;

  factory EventModel.fromJson(JSON json) => _$EventModelFromJson(json);

  static JSON toCustomJson({
    int? eventId,
    String? name,
    DateTime? date,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? posterUrl,
    EventStatus? eventStatus,
  }) {
    return <String, Object?>{
      if (eventId != null) 'event_id': eventId,
      if (name != null) 'name': name,
      if (date != null) 'date': AppUtils.dateToJson(date),
      if (startTime != null) 'start_time': AppUtils.timeToJson(startTime),
      if (endTime != null) 'end_time': AppUtils.timeToJson(endTime),
      if (posterUrl != null) 'poster_url': posterUrl,
      if (eventStatus != null) 'event_status': eventStatus.toJson,
    };
  }
}
