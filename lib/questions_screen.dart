import 'package:flutter/material.dart';
import 'package:myapp/answer_button.dart';
import 'package:myapp/data/quizz.dart';
import 'package:myapp/result_screen.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState(){
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  
  int currentQuestionIndex = 0;
  final List<String> selectedAnswers = [];

  void answerQuestion(String answers) {
    setState(() {
      selectedAnswers.add(answers);
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // เมื่อถึงคำถามสุดท้าย ให้ไปหน้าผลลัพธ์
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => 
            ResultScreen(selectedAnswers: selectedAnswers),
          ),
        );
      }
    });
}
  
  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Questions'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurple],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentQuestion.question,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ...currentQuestion.getShuffledAnswers().map(
                    (answer){
                    return AnswerButton(
                      answer: answer, 
                      onTap:() => answerQuestion(answer));
                  },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}