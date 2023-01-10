// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

/// A collection of types that an event can be.
@JsonEnum()
enum EventStatus {
  @JsonValue('open')
  OPEN,
  @JsonValue('closed')
  CLOSED
}

/// A utility with extensions for enum name and serialized value.
extension ExtEventType on EventStatus {
  String get toJson => name.toLowerCase();
}
