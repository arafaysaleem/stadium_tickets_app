import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

class EventPosterPlaceholder extends StatelessWidget {
  final double? height;
  final double radius;
  final BorderRadius? borderRadius;
  final double iconSize;
  final AlignmentGeometry childXAlign;
  final EdgeInsetsGeometry? margin;
  final EdgeInsets? padding;

  const EventPosterPlaceholder({
    super.key,
    this.height,
    this.padding,
    this.margin,
    this.childXAlign = Alignment.center,
    this.radius = 20,
    this.borderRadius,
    this.iconSize = 65,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: borderRadius ?? Corners.rounded(radius),
      ),
      child: Align(
        alignment: childXAlign,
        child: Icon(
          Icons.movie_creation_rounded,
          color: AppColors.primaryColor,
          size: iconSize,
        ),
      ),
    );
  }
}
