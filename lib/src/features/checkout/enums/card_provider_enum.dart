// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/constants/app_assets.dart';

/// A collection of providers that a card can be.
@JsonEnum()
enum CardProvider {
  @JsonValue('visa')
  VISA(AppAssets.visaIcon),
  @JsonValue('mastercard')
  MASTERCARD(AppAssets.mastercardIcon);

  final String icon;

  const CardProvider(this.icon);
}

/// A utility with extensions for enum name and serialized value.
extension ExtCardProvider on CardProvider {
  String get toJson => name.toLowerCase();
}
