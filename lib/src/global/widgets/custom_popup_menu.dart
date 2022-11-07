import 'package:flutter/material.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';
import '../../helpers/constants/app_typography.dart';

class CustomPopupMenu<T> extends StatelessWidget {
  final Widget child;
  final Map<String, T> items;
  final T? initialValue;
  final void Function(T) onSelected;

  const CustomPopupMenu({
    super.key,
    this.initialValue,
    required this.child,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      initialValue: initialValue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      color: AppColors.surfaceColor,
      itemBuilder: (_) => items.entries
          .map(
            (entry) => PopupMenuItem(
              value: entry.value,
              child: Text(
                entry.key,
                style: AppTypography.primary.subtitle13.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ),
          )
          .toList(),
      onSelected: onSelected,
      child: child,
    );
  }
}
