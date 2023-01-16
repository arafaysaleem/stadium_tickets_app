import 'package:flutter/material.dart';

class CustomBackIcon extends StatelessWidget {
  final VoidCallback onTap;

  const CustomBackIcon({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkResponse(
      radius: 25,
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Icon(Icons.arrow_back_rounded, size: 23),
        ),
      ),
    );
  }
}
