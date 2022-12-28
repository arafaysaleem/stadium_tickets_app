// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

/// A collection of types that a booking can be.
@JsonEnum()
enum BookingStatus {
  @JsonValue('confirmed')
  CONFIRMED,
  @JsonValue('cancelled')
  CANCELLED,
  @JsonValue('reserved')
  RESERVED,
}

/// A utility with extensions for enum name and serialized value.
extension ExtBookingType on BookingStatus {
  String get toJson => name.toLowerCase();
}
