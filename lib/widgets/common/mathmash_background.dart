import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Decorative background used on the welcome and authentication screens.
class MathMashBackground extends StatelessWidget {
  const MathMashBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: ColoredBox(color: AppColors.primary)),
        const Positioned(
          left: -100,
          top: 390,
          child: _DecorativeRing(size: 300),
        ),
        const Positioned(right: -115, bottom: -95, child: _WaveDecoration()),
        const Positioned(left: -8, top: 110, child: _Sparkle()),
        const Positioned(right: -8, top: 455, child: _Sparkle()),
        SafeArea(child: child),
      ],
    );
  }
}

class _DecorativeRing extends StatelessWidget {
  const _DecorativeRing({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.95),
          width: 75,
        ),
      ),
    );
  }
}

class _WaveDecoration extends StatelessWidget {
  const _WaveDecoration();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(280, 190), painter: _WavePainter());
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.secondary.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    for (var i = 0; i < 14; i++) {
      final path = Path()
        ..moveTo(size.width * (0.15 + i * 0.018), size.height)
        ..cubicTo(
          size.width * (0.32 + i * 0.008),
          size.height * 0.72,
          size.width * (0.42 + i * 0.008),
          size.height * 0.20,
          size.width * (0.70 + i * 0.012),
          0,
        );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Sparkle extends StatelessWidget {
  const _Sparkle();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.auto_awesome, color: AppColors.blue, size: 42);
  }
}
