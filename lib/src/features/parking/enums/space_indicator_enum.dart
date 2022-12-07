// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

enum SpaceIndicator {
  AVAILABLE(Color(0xFF5A5A5A)),
  TAKEN(Color.fromARGB(255, 57, 57, 57)),
  SELECTED(AppColors.redColor);

  final Color color;

  const SpaceIndicator(this.color);
}
