// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

enum SpaceIndicator {
  AVAILABLE(Color.fromARGB(255, 76, 76, 76)),
  TAKEN(Color.fromARGB(255, 57, 57, 57)),
  SELECTED(AppColors.redColor);

  final Color color;

  const SpaceIndicator(this.color);
}
