// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';

enum SeatIndicator {
  AVAILABLE(Colors.white),
  TAKEN(Color(0xFF5A5A5A)),
  SELECTED(AppColors.redColor);

  final Color color;

  const SeatIndicator(this.color);
}
