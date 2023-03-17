import 'dart:math';
import 'package:flutter/material.dart';

class StarAnimation extends StatefulWidget {
  const StarAnimation({super.key});

  @override
  _StarAnimationState createState() => _StarAnimationState();
}

class _StarAnimationState extends State<StarAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                left: 50,
                top: 100,
                child: Transform.rotate(
                  angle: pi / 4,
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow.withOpacity(_animation.value),
                    size: 50,
                  ),
                ),
              ),
              Positioned(
                left: 100,
                top: 50,
                child: Transform.rotate(
                  angle: pi / 4 * 3,
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow.withOpacity(_animation.value),
                    size: 50,
                  ),
                ),
              ),
              Positioned(
                left: 150,
                top: 100,
                child: Transform.rotate(
                  angle: pi / 4,
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow.withOpacity(_animation.value),
                    size: 50,
                  ),
                ),
              ),
              Positioned(
                left: 100,
                top: 150,
                child: Transform.rotate(
                  angle: pi / 4 * 3,
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow.withOpacity(_animation.value),
                    size: 50,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
