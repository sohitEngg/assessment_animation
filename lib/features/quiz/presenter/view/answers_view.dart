import 'package:animation_app/common/animation_constants.dart';
import 'package:animation_app/features/quiz/data/quiz_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:spring/spring.dart';

class AnswersView extends StatefulWidget {
  final List<Option> options;
  Function onSelectingAnswer;

  AnswersView({this.options, this.onSelectingAnswer});

  @override
  _AnswersViewState createState() => _AnswersViewState();
}

class _AnswersViewState extends State<AnswersView>
    with SingleTickerProviderStateMixin {
  final SpringController springController =
      SpringController(initialAnim: Motion.play);
  int index = 0;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 40,
        child: GridView.count(
            crossAxisSpacing: 40,
            mainAxisSpacing: 40,
            crossAxisCount: 2,
            controller: new ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: _buildOptionList(widget.options)));
  }

  _buildOptionList(List<Option> options) {
    return options
        .map(
          (option) => Spring.fadeIn(
            delay:
                Duration(milliseconds: (2 * ANIM_START_TIME) + (index++ * 200)),
            springController: springController,
            startOpacity: 0,
            endOpacity: 1,
            animDuration: Duration(microseconds: 400),
            curve: Curves.bounceIn,
            child: Spring.rotate(
              springController: springController,
              startAngle: 0,
              endAngle: 360,
              delay: Duration(
                  milliseconds: (2 * ANIM_START_TIME) + (index++ * 200)),
              animDuration: Duration(milliseconds: ANIM_START_TIME),
              animStatus: (T) => print(T),
              child: InkWell(
                onTap: () {
                  _onSelectAnswer(option);
                },
                child: Container(
                  margin: new EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.ac_unit,
                          size: 20,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Html(
                          data: option.label,
                          padding: EdgeInsets.fromLTRB(40, 0, 30, 0),
                          defaultTextStyle:
                              TextStyle(fontSize: 16, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  _onSelectAnswer(Option option) {
    widget.onSelectingAnswer(option);
  }
}
