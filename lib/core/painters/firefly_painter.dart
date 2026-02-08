import 'dart:math';

import 'package:flutter/material.dart';

class Firefly {
  const Firefly({
    required this.x,
    required this.y,
    required this.radius,
    required this.twinkle,
  });

  final double x;
  final double y;
  final double radius;
  final double twinkle;
}

class FireflyPainter extends CustomPainter {
  FireflyPainter({required this.time, required this.fireflies});

  final double time;
  final List<Firefly> fireflies;

  @override
  void paint(Canvas canvas, Size size) {
    for (final fly in fireflies) {
      final twinkle = (sin(time * 2 * pi + fly.twinkle) + 1) / 2;
      final paint =
          Paint()
            ..color = const Color(
              0xFFFFE9A6,
            ).withValues(alpha: 0.3 + twinkle * 0.6)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      final pos = Offset(fly.x * size.width, fly.y * size.height);
      canvas.drawCircle(pos, fly.radius + twinkle * 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant FireflyPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
