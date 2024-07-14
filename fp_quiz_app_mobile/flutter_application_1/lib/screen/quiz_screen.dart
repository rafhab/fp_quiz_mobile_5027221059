import 'package:flutter/material.dart';
import 'dart:ffi';
import 'dart:io';

typedef GetQuestionFunc = Pointer<Utf8> Function();
typedef GetQuestion = Pointer<Utf8> Function();

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late DynamicLibrary _quizLib;
  late GetQuestion _getQuestion;

  @override
  void initState() {
    super.initState();
    _quizLib = Platform.isAndroid
        ? DynamicLibrary.open("libquiz_logic.so")
        : DynamicLibrary.process();
    _getQuestion = _quizLib
        .lookup<NativeFunction<GetQuestionFunc>>('get_question')
        .asFunction();
  }

  String _question = '';

  void _fetchQuestion() {
    final questionPtr = _getQuestion();
    setState(() {
      _question = questionPtr.toDartString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pertanyaan:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _question,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchQuestion,
              child: Text('Ambil Pertanyaan'),
            ),
          ],
        ),
      ),
    );
  }
}
