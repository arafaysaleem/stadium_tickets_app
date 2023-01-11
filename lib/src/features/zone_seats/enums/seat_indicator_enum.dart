// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

enum SeatIndicator {
  AVAILABLE(Color(0xFF5A5A5A)),
  TAKEN(Color.fromARGB(255, 53, 53, 53)),
  SELECTED(AppColors.redColor);

  final Color color;

  const SeatIndicator(this.color);
}
