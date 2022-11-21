import 'package:flutter/material.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';

class CustomBackIcon extends StatelessWidget {
  final VoidCallback onTap;

  const CustomBackIcon({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      radius: 25,
      onTap: onTap,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(Icons.arrow_back_rounded, size: 23),
        ),
      ),
    );
  }
}
