import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ffi/ffi.dart';

typedef GetQuestionFunc = Pointer<Utf8> Function();
typedef GetQuestion = Pointer<Utf8> Function();

class MockQuizLogic {
  static Pointer<Utf8> get_question() {
    return "Apa ibu kota Indonesia?".toNativeUtf8();
  }
}

@GenerateMocks([QuizScreen])
void main() {
  testWidgets('QuizScreen displays a question when button is pressed',
      (WidgetTester tester) async {
    // Build the QuizApp widget.
    await tester.pumpWidget(QuizApp());

    // Verify that initially the question is empty.
    expect(find.text('Pertanyaan:'), findsOneWidget);
    expect(find.text('Ambil Pertanyaan'), findsOneWidget);

    // Tap the 'Ambil Pertanyaan' button and trigger a frame.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that a question is displayed.
    expect(find.text('Apa ibu kota Indonesia?'), findsOneWidget);
  });
}
