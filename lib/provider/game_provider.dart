// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  final Dio _dio = Dio();
  List<dynamic>? questions;
  int currentQuestionCount = 0;
  int maxQuestionCount = 10;
  int correctCount = 0;
  GameProvider() {
    startGame();
  }

  Future<void> startGame() async {
    try {
      Response response = await _dio.get(
        "https://opentdb.com/api.php",
        queryParameters: {
          "amount": 10,
          "difficulty": "easy",
          "type": "boolean",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.toString());
        questions = data["results"];
        notifyListeners();
      } else {
        Text("No data available: ${response.statusCode}");
      }
    } catch (e) {
      e.toString();
    }
  }

  // Current Question Check index
  String currentQuestion() {
    if (questions != null) {
      return questions![currentQuestionCount]["question"];
    }
    return "";
  }

//  Check if the answer is correct
  void answeQuestions(String answer, BuildContext context) async {
    bool isCorrect =
        questions![currentQuestionCount]["correct_answer"] == answer;
    correctCount += isCorrect ? 1 : 0;
    currentQuestionCount++;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(),
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          icon: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
            size: 30,
          ),
        );
      },
    );

    await Future.delayed(
      const Duration(seconds: 1),
    );

    Navigator.pop(context);
    if (currentQuestionCount == maxQuestionCount) {
      return endGame(context);
    } else {
      notifyListeners();
    }
  }

//  End game alert dilouge
  Future<void> endGame(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            "End Game!",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          content: Text(
            "Score: $correctCount/$maxQuestionCount",
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }

//  index of Current Question;
}
