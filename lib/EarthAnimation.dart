import 'package:flutter/material.dart';
import 'dart:math' as math;

class EarthAnimation extends StatefulWidget {
  const EarthAnimation({super.key});

  @override
  _EarthAnimationState createState() => _EarthAnimationState();
}

class _EarthAnimationState extends State<EarthAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _EarthPainter(_controller.value),
      child: SizedBox(
        width: 150,
        height: 150,
      ),
    );
  }
}

class _EarthPainter extends CustomPainter {
  final double rotation;
  _EarthPainter(this.rotation);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(rotation * 2 * math.pi);
    canvas.drawCircle(Offset(-75, 0), 15, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
