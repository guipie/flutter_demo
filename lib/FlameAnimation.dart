import 'package:flutter/material.dart';

class FlameAnimation extends StatefulWidget {
  const FlameAnimation({super.key});

  @override
  _FlameAnimationState createState() => _FlameAnimationState();
}

class _FlameAnimationState extends State<FlameAnimation> with TickerProviderStateMixin<FlameAnimation> {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _opacity = 1.0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _opacity = 1.0 - _animation.value;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 50),
      child: Image.asset(
        'assets/flame.png',
        width: 80,
        height: 80,
      ),
    );
  }
}
