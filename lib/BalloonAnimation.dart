import 'dart:math';
import 'package:flutter/material.dart';

class BalloonAnimation extends StatefulWidget {
  @override
  _BalloonAnimationState createState() => _BalloonAnimationState();
}

class _BalloonAnimationState extends State<BalloonAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _top = 500;
  double _left = 150;
  double _size = 50.0;
  double _scale = 1.0;
  double _rotate = 0.0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
      ..addListener(() {
        setState(() {
          _top = 500 - _animation.value * 400;
          _left = 150 + sin(_animation.value * 3.14) * 100;
          _size = 50 + _animation.value * 50;
          _scale = 1 + _animation.value;
          _rotate = sin(_animation.value * 3.14) * 0.2;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _top,
      left: _left,
      child: Transform.scale(
        scale: _scale,
        child: Transform.rotate(
          angle: _rotate,
          child: SizedBox(
            width: _size,
            height: _size,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BalloonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BalloonAnimation(),
      ],
    ));
  }
}
