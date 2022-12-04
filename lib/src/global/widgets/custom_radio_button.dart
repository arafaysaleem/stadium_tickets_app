import 'package:flutter/material.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final void Function(T) onTap;
  final T value;

  const CustomRadioButton({
    super.key,
    this.width = 106,
    this.height = 46,
    this.borderRadius = const BorderRadius.all(Radius.circular(7)),
    required this.value,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap.call(value),
      child: SizedBox(
        width: width,
        height: height,
        child: AnimatedContainer(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: isSelected ? AppColors.buttonGradientPrimary : null,
            color: AppColors.fieldFillColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Icon(
                  icon,
                  color: isSelected ? Colors.white : AppColors.textGreyColor,
                ),

                const SizedBox(width: 3),

                // Label
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? Colors.white : AppColors.textGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
