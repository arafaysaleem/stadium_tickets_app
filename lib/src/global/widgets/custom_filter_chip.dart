import 'package:flutter/material.dart';

class CustomFilterChip<T> extends StatefulWidget {
  final bool isSelected;
  final bool Function(bool, T value)? onChanged;
  final Widget label;
  final T value;
  final Color? labelColor;
  final Color? selectedLabelColor;
  final Color? backgroundColor;
  final Color? selectedColor;

  const CustomFilterChip({
    super.key,
    this.labelColor,
    this.selectedLabelColor,
    this.backgroundColor,
    this.selectedColor,
    this.isSelected = false,
    this.onChanged,
    required this.label,
    required this.value,
  });

  @override
  State<CustomFilterChip<T>> createState() => _CustomFilterChipState<T>();
}

class _CustomFilterChipState<T> extends State<CustomFilterChip<T>> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FilterChip(
      label: widget.label,
      pressElevation: 0,
      labelPadding: const EdgeInsets.symmetric(horizontal: 11),
      showCheckmark: false,
      labelStyle: TextStyle(
        fontSize: 13,
        color: _isSelected
            ? (widget.selectedLabelColor ?? colorScheme.onPrimary)
            : widget.labelColor,
      ),
      backgroundColor: widget.backgroundColor,
      selectedColor: widget.selectedColor,
      selected: _isSelected,
      onSelected: (selected) {
        final allowChange = widget.onChanged?.call(selected, widget.value);
        if (allowChange != null && allowChange) {
          setState(() {
            _isSelected = selected;
          });
        }
      },
    );
  }
}
