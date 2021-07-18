import 'package:animation_app/common/animation_constants.dart';
import 'package:animation_app/features/quiz/data/quiz_model.dart';
import 'package:animation_app/features/quiz/presenter/view/answers_view.dart';
import 'package:animation_app/features/quiz/presenter/view/count_down_timer.dart';
import 'package:animation_app/features/quiz/presenter/view/result_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:spring/spring.dart';

class QuizView extends StatefulWidget {
  final QuizModel quiz;

  QuizView({this.quiz});

  @override
  State<StatefulWidget> createState() {
    return _QuizViewState();
  }
}

class _QuizViewState extends State<QuizView> {
  bool isAnswered = false;
  Option selectedOption;

  @override
  Widget build(BuildContext context) {
    return isAnswered ? _buildAnswerView(selectedOption) : _buildQuizView();
  }

  _buildQuizView() {
    return Container(
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Spring.slide(
                delay: Duration(milliseconds: FIRST_ANIM_START_TIME),
                slideType: SlideType.slide_in_bottom,
                animDuration: Duration(milliseconds: SLIDE_ANIM_DURATION),
                animStatus: (status) => null,
                curve: Curves.easeInToLinear,
                child: Html(
                  data: widget.quiz.data.stimulus,
                  defaultTextStyle:
                      TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Spring.slide(
                  delay: Duration(milliseconds: FIRST_ANIM_START_TIME + 1000),
                  slideType: SlideType.slide_in_bottom,
                  animDuration: Duration(milliseconds: SLIDE_ANIM_DURATION),
                  animStatus: (status) => null,
                  child: CountDownTimer()),
              SizedBox(
                height: 20,
              ),
              AnswersView(
                  options: widget.quiz.data.options,
                  onSelectingAnswer: (option) {
                    _displayAnswer(option);
                  })
            ],
          ),
        ),
      ),
    );
  }

  _buildAnswerView(value) {
    return ResultView(option: value, onNextQuiz: _displayNextQuiz);
  }

  _displayAnswer(option) {
    selectedOption = option;
    setState(() {
      isAnswered = true;
    });
  }

  _displayNextQuiz() {
    print('next quiz...');
    setState(() {
      isAnswered = false;
    });
  }
}
