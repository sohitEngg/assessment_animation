import 'package:animation_app/features/quiz/data/quiz_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

class ResultView extends StatefulWidget {
  final Option option;
  Function onNextQuiz;

  ResultView({this.option, this.onNextQuiz});

  @override
  State<ResultView> createState() => _ResultView();
}

class _ResultView extends State<ResultView> {
  final SpringController springController = SpringController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => springController.play());
    _proceedToNextQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Spring.flip(
          springController: springController,
          frontWidget: _placeHolderAnswer(),
          rearWidget: _resultAnswer(widget.option),
          flipAxis: Axis.vertical,
          toggleOnClick: true,
          animDuration: Duration(seconds: 2),
        ),
      ),
    );
  }

  _placeHolderAnswer() {
    print('placeholder...');
    return Container(
      height: 200,
      width: 200,
      margin: new EdgeInsets.all(1.0),
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  _resultAnswer(Option option) {
    print('result...');
    return Container(
      height: 200,
      width: 200,
      margin: new EdgeInsets.all(1.0),
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
          child: Icon(
        Icons.check,
        color: Colors.white,
        size: 100,
      )),
    );
  }

  void _proceedToNextQuiz() {
    Future.delayed(const Duration(milliseconds: 4000), () {
      widget.onNextQuiz();
      // setState(() {
      //   // Here you can write your code for open new view
      // });
    });
  }
}
