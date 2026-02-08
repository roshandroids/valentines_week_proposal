import 'dart:math';

import 'package:flutter/material.dart';

class Petal {
  const Petal({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.sway,
    required this.phase,
    required this.color,
  });

  final double x;
  final double y;
  final double size;
  final double speed;
  final double sway;
  final double phase;
  final Color color;
}

class PetalPainter extends CustomPainter {
  PetalPainter({required this.time, required this.petals});

  final double time;
  final List<Petal> petals;

  @override
  void paint(Canvas canvas, Size size) {
    for (final petal in petals) {
      final t = (time * 2 * pi * petal.speed + petal.phase) % (2 * pi);
      final dx = (petal.x + sin(t) * petal.sway) % 1.0;
      final dy = (petal.y + time * petal.speed) % 1.0;
      final pos = Offset(dx * size.width, dy * size.height);

      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(sin(t) * 0.5);
      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: petal.size * 0.8,
        height: petal.size,
      );
      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(8));
      canvas.drawRRect(
        rrect,
        Paint()..color = petal.color.withValues(alpha: 0.8),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant PetalPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
