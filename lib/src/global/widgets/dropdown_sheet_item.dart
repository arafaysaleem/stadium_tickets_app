import 'package:flutter/material.dart';

class DropdownSheetItem extends StatelessWidget {
  final String label;
  final EdgeInsets padding;

  const DropdownSheetItem({
    super.key,
    required this.label,
    this.padding = const EdgeInsets.symmetric(
      vertical: 5,
    ),
  });

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
        title: Text(label),
      ),
    );
  }
}
