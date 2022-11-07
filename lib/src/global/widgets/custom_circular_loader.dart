import 'package:flutter/material.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';

class CustomCircularLoader extends StatelessWidget {
  final Color color;
  final double size;
  final double lineWidth;

  const CustomCircularLoader({
    super.key,
    this.color = AppColors.primaryColor,
    this.size = 30,
    this.lineWidth = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: lineWidth,
        ),
      ),
    );
  }
}
