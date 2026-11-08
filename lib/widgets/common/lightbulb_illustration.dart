import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// A simple vector-style lightbulb illustration; no external image asset needed.
class LightbulbIllustration extends StatelessWidget {
  const LightbulbIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 235,
      child: CustomPaint(painter: _LightbulbPainter()),
    );
  }
}

class _LightbulbPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final outline = Paint()
      ..color = const Color(0xFF242044)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fill = Paint()
      ..color = AppColors.secondary
      ..style = PaintingStyle.fill;

    // Rays around the bulb.
    for (var i = 0; i < 9; i++) {
      final angle = (i * 40 - 160) * 3.1415926535 / 180;
      final start = Offset(centerX + 78 * _cos(angle), 91 + 78 * _sin(angle));
      final end = Offset(centerX + 99 * _cos(angle), 91 + 99 * _sin(angle));
      canvas.drawLine(start, end, outline);
    }

    final bulb = Path()
      ..moveTo(centerX, 16)
      ..cubicTo(18, 16, 9, 80, 43, 119)
      ..cubicTo(55, 133, 58, 145, 58, 160)
      ..lineTo(132, 160)
      ..cubicTo(132, 143, 137, 130, 149, 114)
      ..cubicTo(181, 73, 158, 16, centerX, 16)
      ..close();

    canvas.drawPath(bulb, fill);
    canvas.drawPath(bulb, outline);

    // Filament.
    final filament = Path()
      ..moveTo(68, 72)
      ..cubicTo(43, 49, 42, 111, 91, 119)
      ..cubicTo(131, 125, 143, 76, 123, 66)
      ..cubicTo(108, 58, 94, 104, 91, 158);
    canvas.drawPath(filament, outline);

    // Bulb base.
    final base = RRect.fromRectAndRadius(
      Rect.fromLTWH(55, 160, 80, 42),
      const Radius.circular(7),
    );
    canvas.drawRRect(base, Paint()..color = AppColors.secondary);
    canvas.drawRRect(base, outline);
    canvas.drawLine(const Offset(58, 174), const Offset(132, 174), outline);
    canvas.drawLine(const Offset(58, 188), const Offset(132, 188), outline);

    final bottom = RRect.fromRectAndRadius(
      Rect.fromLTWH(68, 202, 54, 12),
      const Radius.circular(5),
    );
    canvas.drawRRect(bottom, Paint()..color = const Color(0xFF242044));
  }

  double _cos(double value) => _trig(value, true);
  double _sin(double value) => _trig(value, false);

  double _trig(double value, bool cosine) {
    // Small helper avoids introducing another package dependency.
    return cosine ? _cosApprox(value) : _sinApprox(value);
  }

  double _cosApprox(double x) {
    // Dart's dart:math is used through the import-free approximation below.
    // The ray positions are decorative, so this polynomial is sufficient.
    final y = _normalize(x);
    final y2 = y * y;
    return 1 - y2 / 2 + y2 * y2 / 24 - y2 * y2 * y2 / 720;
  }

  double _sinApprox(double x) {
    final y = _normalize(x);
    final y2 = y * y;
    return y - y * y2 / 6 + y * y2 * y2 / 120;
  }

  double _normalize(double x) {
    while (x > 3.1415926535) {
      x -= 6.283185307;
    }
    while (x < -3.1415926535) {
      x += 6.283185307;
    }
    return x;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
