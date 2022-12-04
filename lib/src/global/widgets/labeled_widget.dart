import 'package:flutter/material.dart';

enum LabelPosition {
  start,
  end;

  VerticalDirection get direction => this == LabelPosition.start
      ? VerticalDirection.down
      : VerticalDirection.up;
}

class LabeledWidget extends StatelessWidget {
  final Widget child;
  final String label;
  final SizedBox labelGap;
  final SizedBox horizontalLabelGap;
  final TextStyle labelStyle;
  final bool useDarkerLabel;
  final Axis labelDirection;
  final LabelPosition labelPosition;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final bool expand;

  const LabeledWidget({
    super.key,
    required this.child,
    required this.label,
    this.labelGap = const SizedBox(height: 5),
    this.labelPosition = LabelPosition.start,
    this.expand = false,
    this.horizontalLabelGap = const SizedBox(width: 10),
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.labelDirection = Axis.vertical,
    this.useDarkerLabel = false,
    this.labelStyle = const TextStyle(
      fontSize: 14,
      color: Color.fromRGBO(171, 180, 185, 1),
    ),
  });

  @override
  Widget build(BuildContext context) {
    final children = [
      // Label
      Text(
        label,
        style: useDarkerLabel ? const TextStyle(fontSize: 16) : labelStyle,
      ),

      if (labelDirection == Axis.vertical) labelGap else horizontalLabelGap,

      // Widget
      if (expand) Expanded(child: child) else child,
    ];
    return labelDirection == Axis.vertical
        ? Column(
            verticalDirection: labelPosition.direction,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: children,
          )
        : Row(
            verticalDirection: labelPosition.direction,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: children,
          );
  }
}
