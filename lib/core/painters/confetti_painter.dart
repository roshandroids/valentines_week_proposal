import 'dart:math';

import 'package:flutter/material.dart';

class ConfettiPiece {
  const ConfettiPiece({
    required this.angle,
    required this.speed,
    required this.size,
    required this.spin,
    required this.color,
  });

  final double angle;
  final double speed;
  final double size;
  final double spin;
  final Color color;
}

class ConfettiPainter extends CustomPainter {
  ConfettiPainter({required this.progress, required this.confetti});

  final double progress;
  final List<ConfettiPiece> confetti;

  @override
  void paint(Canvas canvas, Size size) {
    final origin = Offset(size.width * 0.5, size.height * 0.45);
    for (final piece in confetti) {
      final t = progress;
      final dx = cos(piece.angle) * piece.speed * t;
      final dy = sin(piece.angle) * piece.speed * t + 220 * t * t;
      final pos = origin + Offset(dx, dy);
      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(piece.spin * t);
      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: piece.size,
        height: piece.size * 0.6,
      );
      canvas.drawRect(rect, Paint()..color = piece.color);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
