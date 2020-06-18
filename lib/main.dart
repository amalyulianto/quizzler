import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//TODO: Step 2 - Import the rFlutter_Alert package here.
import 'quiz_brain.dart';

void main() => runApp(Quizzler());

QuizBrain quizBrain = QuizBrain();

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
  List<Icon> scoreKeeper = [];

  void addGreenIcon() {
    scoreKeeper.add(Icon(
      Icons.check,
      color: Colors.green,
    ));
  }

  void addRedIcon() {
    scoreKeeper.add(Icon(
      Icons.close,
      color: Colors.red,
    ));
  }

  void checkAnswer(bool userAnswer) {
    setState(() {
      int wrongScore = quizBrain.wrong;
      int correctScore = quizBrain.correct;
      
      if (quizBrain.isFinished() == true) {
        Alert(
      context: context,
      type: AlertType.error,
      title: "Finish!",
      desc: "You've done well!\nCorrect: $correctScore\nWrong: $wrongScore",
      buttons: [
        DialogButton(
          child: Text(
            "Reset",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
        quizBrain.reset();
        scoreKeeper = [];
      } else {
        //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.
        //TODO: Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
        //HINT! Step 4 Part B is in the quiz_brain.dart
        //TODO: Step 4 Part C - reset the questionNumber,
        //TODO: Step 4 Part D - empty out the scoreKeeper.

        //TODO: Step 5 - If we've not reached the end, ELSE do the answer checking steps below 👇
        bool correctAnswer = quizBrain.getCorrectAnswer();
        if (userAnswer == correctAnswer) {
          quizBrain.correctAdd();
          print("You got it right!");
          if (scoreKeeper.length < 10) {
            addGreenIcon();
          } else {
            scoreKeeper.removeAt(0);
            addGreenIcon();
          }
        } else {
          quizBrain.wrongAdd();
          print("You got it wrong!");
          if (scoreKeeper.length < 10) {
            addRedIcon();
          } else {
            scoreKeeper.removeAt(0);
            addRedIcon();
          }
        }

        quizBrain.nextQuestion();
      }
    });
  }

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
                quizBrain.data, // The questions will be pasted here.
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
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True', // Answer True.
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
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False', // Answer False.
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
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

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
