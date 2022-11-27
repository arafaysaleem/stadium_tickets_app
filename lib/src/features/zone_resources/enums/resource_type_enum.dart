// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

/// A collection of types that a zone resource can be.
@JsonEnum()
enum ResourceType {
  @JsonValue('image')
  IMAGE,
  @JsonValue('video')
  VIDEO
}

/// A utility with extensions for enum name and serialized value.
extension ExtResourceType on ResourceType {
  String get toJson => name.toLowerCase();
}
