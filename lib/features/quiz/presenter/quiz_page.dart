import 'package:animation_app/features/quiz/data/quiz_model.dart';
import 'package:animation_app/features/quiz/presenter/view/quiz_view.dart';
import 'package:animation_app/json_db/quiz_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QuizModel> quizList;

  @override
  void initState() {
    super.initState();
    quizList = quizFromJson(QuizDatabase.quizJsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: QuizView(quiz: quizList[0]),
    );
  }
}
