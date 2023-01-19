import 'package:flutter/material.dart';

// Helper
import '../../../../helpers/constants/constants.dart';

class DashedTicketSeparator extends StatelessWidget {
  const DashedTicketSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      child: Stack(
        alignment: Alignment.center,
        children: const [
          // Dotted line
          CustomPaint(
            size: Size(double.infinity, 0),
            painter: _DashedLinePainter(
              thickness: 1.5,
              spacing: 4,
              color: AppColors.backgroundColor,
              dashLength: 6,
            ),
          ),

          // Left circle cut
          Positioned(
            left: -25,
            child: SizedBox(
              height: 15,
              width: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundColor,
                ),
              ),
            ),
          ),

          // Right circle cut
          Positioned(
            right: -25,
            child: SizedBox(
              height: 15,
              width: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double thickness;
  final double spacing;
  final double dashLength;
  final Color color;

  const _DashedLinePainter({
    required this.thickness,
    required this.spacing,
    required this.color,
    required this.dashLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final count = (size.width) / (dashLength + spacing);
    if (count < 2.0) return;
    var startOffset = Offset.zero;
    for (var i = 0; i < count.toInt(); i++) {
      canvas.drawLine(startOffset, startOffset.translate(dashLength, 0), paint);
      startOffset = startOffset.translate(dashLength + spacing, 0);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
