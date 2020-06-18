class Question {
  String questionText;
  bool questionAnswer;

  Question(String q, bool a) {
    questionText = q;
    questionAnswer = a;
  }
}
void nextQuestion(questionNumber) {

    print(questionNumber);
    if (questionNumber < 3 - 1) {
      questionNumber++;
    }
    print(questionNumber);
  }