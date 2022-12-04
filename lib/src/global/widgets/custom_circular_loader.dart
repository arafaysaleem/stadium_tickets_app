import 'package:flutter/material.dart';

class CustomCircularLoader extends StatelessWidget {
  final Color? color;
  final double size;
  final double lineWidth;

  const CustomCircularLoader({
    super.key,
    this.color,
    this.size = 30,
    this.lineWidth = 4,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? primary,
          strokeWidth: lineWidth,
        ),
      ),
    );
  }
}
