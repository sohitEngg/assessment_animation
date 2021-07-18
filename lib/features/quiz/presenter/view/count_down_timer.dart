import 'package:animation_app/common/animation_constants.dart';
import 'package:animation_app/features/quiz/presenter/view/cutom_timer_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    Future.delayed(const Duration(milliseconds: FIRST_ANIM_START_TIME * 4), () {
      _startAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            height: 100,
            width: 100,
            child: CustomPaint(
                painter: CustomTimerPainter(
              animation: controller,
              backgroundColor: Colors.white,
              color: Colors.deepOrangeAccent,
            )),
          );
        });
  }

  _startAnimation() {
    if (controller.isAnimating)
      controller.stop();
    else {
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
