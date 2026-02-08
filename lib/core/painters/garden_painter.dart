import 'dart:math';

import 'package:flutter/material.dart';

class GardenPainter extends CustomPainter {
  GardenPainter({required this.time});

  final double time;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final skyGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF121A34),
        const Color(0xFF2B1D3A),
        const Color(0xFF3F1A33),
      ],
      stops: const [0, 0.6, 1],
    );
    canvas.drawRect(rect, Paint()..shader = skyGradient.createShader(rect));

    final glow =
        Paint()..color = const Color(0xFFFFC1CC).withValues(alpha: 0.3);
    final moonOffset = Offset(size.width * 0.78, size.height * 0.18);
    canvas.drawCircle(moonOffset, size.width * 0.08, glow);
    canvas.drawCircle(
      moonOffset,
      size.width * 0.05,
      Paint()..color = const Color(0xFFFFE6F0),
    );

    _paintHills(canvas, size, 0.55, const Color(0xFF1F2B3E));
    _paintHills(canvas, size, 0.68, const Color(0xFF1A2030));
    _paintHills(canvas, size, 0.8, const Color(0xFF112119));

    final pathPaint = Paint()..color = const Color(0xFF3B2B2C);
    final path =
        Path()
          ..moveTo(size.width * 0.4, size.height)
          ..cubicTo(
            size.width * 0.45,
            size.height * 0.85,
            size.width * 0.55,
            size.height * 0.85,
            size.width * 0.6,
            size.height,
          )
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
    canvas.drawPath(path, pathPaint);

    _paintBench(canvas, size);
    _paintFlowers(canvas, size, time);
  }

  void _paintHills(Canvas canvas, Size size, double heightFactor, Color color) {
    final paint = Paint()..color = color;
    final path = Path()..moveTo(0, size.height * heightFactor);
    for (int i = 0; i <= 6; i++) {
      final x = size.width * i / 6;
      final y = size.height * heightFactor + sin(i * 1.1) * 18;
      path.quadraticBezierTo(
        x + size.width / 12,
        y - 24,
        x + size.width / 6,
        y,
      );
    }
    path
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _paintBench(Canvas canvas, Size size) {
    final benchPaint = Paint()..color = const Color(0xFF5A2A2F);
    final baseY = size.height * 0.7;
    final benchWidth = size.width * 0.18;
    final benchHeight = size.height * 0.03;
    final left = size.width * 0.2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, baseY, benchWidth, benchHeight),
        const Radius.circular(6),
      ),
      benchPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(left, baseY + benchHeight, benchWidth, benchHeight * 0.5),
      benchPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(left + 8, baseY + benchHeight * 1.5, 6, benchHeight * 1.5),
      benchPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        left + benchWidth - 14,
        baseY + benchHeight * 1.5,
        6,
        benchHeight * 1.5,
      ),
      benchPaint,
    );
  }

  void _paintFlowers(Canvas canvas, Size size, double time) {
    final stemPaint =
        Paint()
          ..color = const Color(0xFF2E6B3A)
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;
    final flowerPaint = Paint()..color = const Color(0xFFFF8FB1);

    for (int i = 0; i < 8; i++) {
      final x = size.width * (0.1 + i * 0.1);
      final sway = sin(time * 2 * pi + i) * 8;
      final baseY = size.height * 0.78;
      final topY = size.height * 0.7 - (i % 3) * 10;
      canvas.drawLine(Offset(x, baseY), Offset(x + sway, topY), stemPaint);
      canvas.drawCircle(Offset(x + sway, topY), 6, flowerPaint);
      canvas.drawCircle(
        Offset(x + sway + 6, topY + 2),
        4,
        Paint()..color = const Color(0xFFFFD1DC),
      );
    }
  }

  @override
  bool shouldRepaint(covariant GardenPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
