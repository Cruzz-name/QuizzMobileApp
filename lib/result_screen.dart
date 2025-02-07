import 'package:flutter/material.dart';
import 'package:myapp/data/quizz.dart';
import 'package:myapp/question_summary.dart';
import 'package:myapp/start_screen.dart';
 
class ResultScreen extends StatelessWidget{
  const ResultScreen({super.key, required this.selectedAnswers});
 
  final List<String> selectedAnswers;
 
  List<Map<String,Object>> getSummaryData(){
    List<Map<String,Object>>summaryData =[];

    for(int i=0; i < selectedAnswers.length; i++){
      bool is_correct = selectedAnswers[i] == questions[i].answers[0];

      summaryData.add(
        {
          'question_id':i,
          'question':questions[i].question,
          'user_answer':selectedAnswers[i],
          'correct_answer':questions[i].answers[0],
          'is_correct': is_correct
        }
      );
    }
    return summaryData;
  }



  @override
  Widget build(BuildContext context) {
    final summary = getSummaryData();
    final totalMark = summary.where((data) => data['is_correct'] as bool).length;
    final totalQuestion= questions.length;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.purple, Colors.deepPurple],
            )),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text('Your score is : $totalMark / $totalQuestion ',
                  style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  QuestionSummary(data:getSummaryData()),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StartScreen()));
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Restart Quiz'),
                 
          )]
           )
         
        )
      )
    ));
  }
 
}