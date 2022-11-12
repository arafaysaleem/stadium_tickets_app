// ignore_for_file: constant_identifier_names

/// A collection of types that a student can be.
enum EventType {
  OPEN,
  CLOSED
}

/// A utility with extensions for enum name and serialized value.
extension ExtEventType on EventType {
  String get toJson => name.toLowerCase();
}
