import 'package:flutter/material.dart';

class WaterCupAnimation extends StatefulWidget {
  @override
  _WaterCupAnimationState createState() => _WaterCupAnimationState();
}

class _WaterCupAnimationState extends State<WaterCupAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  // 控制水位高度的百分比
  double _waterLevel = 0.5;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _animation = Tween(begin: 0.0, end: _waterLevel)
        .animate(CurvedAnimation(curve: Curves.easeInOut, parent: _animationController));
    _animation.addListener(() {
      setState(() {
        _waterLevel = _animation.value;
      });
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      child: Stack(
        children: [
          // 水杯
          Container(
            width: 100,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.grey),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 200 * _waterLevel,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
