import 'package:flutter/material.dart';

class DropdownSheetItem extends StatelessWidget {
  final String? label;
  final Widget? child;
  final EdgeInsets padding;

  const DropdownSheetItem({
    super.key,
    this.label,
    this.child,
    this.padding = const EdgeInsets.symmetric(
      vertical: 5,
    ),
  }) : assert(
          label != null || child != null,
          'Either label or a child widget is required',
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).inputDecorationTheme;
    return Padding(
      padding: padding,
      child: ListTile(
        tileColor: theme.fillColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        title: child ?? Text(label!),
      ),
    );
  }
}
