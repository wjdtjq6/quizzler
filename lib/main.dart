import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:quizzler/qeustion.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  void checkAnswer (bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.
      if (quizBrain.isFinished() == true) {
        //TODO: Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
        //HINT! Step 4 Part B is in the quiz_brain.dart
        Alert(
          context: context,
          title: 'Finished',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        //TODO: Step 4 Part C - reset the questionNumber,
        quizBrain.reset();
        //TODO: Step 4 Part D - empty out the scoreKeeper.
        scoreKeeper = [];
      }
      //TODO: Step 5 - If we've not reached the end, ELSE do the answer checking steps below 👇
      else {
        if (userPickedAnswer == correctAnswer)
          scoreKeeper.add(
            Icon(
                Icons.check,
                color: Colors.green),
          );
        else
          scoreKeeper.add(
            Icon(
                Icons.close,
                color: Colors.red),
          );
        quizBrain.nextQuestion();
      }
    });
    }

  List<Icon> scoreKeeper = [];

  int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              color: Colors.green,
              child: TextButton(
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              color: Colors.red,
              child: TextButton(
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  checkAnswer(false);
                  },//The user picked false.
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
