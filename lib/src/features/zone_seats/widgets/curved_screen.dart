import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CurvedScreen extends StatelessWidget {
  final ScrollController screenScrollController;
  final double screenWidth;

  const CurvedScreen({
    super.key,
    required this.screenScrollController,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: screenScrollController,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: CustomPaint(
        size: Size(
          screenWidth,
          screenWidth * 0.1, // * 0.143 was original
        ),
        painter: const ScreenPainter(),
      ),
    );
  }
}

class ScreenPainter extends CustomPainter {
  const ScreenPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint0 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    final path0 = Path()
      ..moveTo(size.width * 0.0685714, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.4917857,
        size.height * -0.2425,
        size.width * 0.9257143,
        size.height * 0.5,
      );

    canvas.drawPath(path0, paint0);

    final paint1 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.50, size.height),
        Offset(size.width * 0.50, size.height * 1.00),
        const [Color(0xcbffffff), Color(0x4dffffff), Color(0x00ffffff)],
        const [0.00, 0.16, 1.00],
      );

    final path1 = Path()
      ..moveTo(size.width * 0.0382429, size.height * 1.0022)
      ..quadraticBezierTo(
        size.width * 0.0597857,
        size.height * 0.6254,
        size.width * 0.0669571,
        size.height * 0.5,
      )
      ..cubicTo(
        size.width * 0.2820143,
        size.height * 0.0483,
        size.width * 0.6836,
        size.height * -0.0022,
        size.width * 0.9273286,
        size.height * 0.5,
      )
      ..quadraticBezierTo(
        size.width * 0.9345,
        size.height * 0.6254,
        size.width * 0.9560429,
        size.height * 1.0022,
      )
      ..lineTo(size.width * 0.0382429, size.height * 1.0022)
      ..close();

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
