import 'dart:math';
import 'package:flutter/material.dart';

class Particle {
  double x;
  double y;
  double size;
  double speed;
  Particle({required this.x, required this.y, required this.size, required this.speed});
}

class RainAnimation extends StatefulWidget {
  @override
  _RainAnimationState createState() => _RainAnimationState();
}

class _RainAnimationState extends State<RainAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> _particles = [];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )
      ..addListener(() {
        setState(() {
          _particles.removeWhere((p) => p.y >= MediaQuery.of(context).size.height);
          _particles.forEach((p) {
            p.y += p.speed;
          });
          _particles.addAll(_generateParticles());
        });
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Particle> _generateParticles() {
    List<Particle> particles = [];
    for (int i = 0; i < 10; i++) {
      particles.add(
        Particle(
          x: Random().nextDouble() * MediaQuery.of(context).size.width,
          y: 0,
          size: Random().nextDouble() * 2 + 1,
          speed: Random().nextDouble() * 5 + 5,
        ),
      );
    }
    return particles;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (Particle particle in _particles)
          Positioned(
            left: particle.x,
            top: particle.y,
            child: Container(
              width: particle.size,
              height: particle.size,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}

class RainPage extends StatefulWidget {
  @override
  _RainPageState createState() => _RainPageState();
}

class _RainPageState extends State<RainPage> {
  bool _isRaining = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_isRaining) RainAnimation(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isRaining = !_isRaining;
          });
        },
        child: Icon(_isRaining ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
