import 'package:flutter/material.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return PopupMenuButton<T>(
      initialValue: initialValue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      color: colorScheme.surface,
      itemBuilder: (_) => items.entries
          .map(
            (entry) => PopupMenuItem(
              value: entry.value,
              child: Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 13,
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
