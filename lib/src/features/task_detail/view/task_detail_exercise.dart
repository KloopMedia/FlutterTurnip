import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../widgets/dialogs/index.dart';
import '../bloc/bloc.dart';
import '../util/util.dart';
import '../widgets/question_field_widget.dart';

/// A page that presents a series of questions for a task test.
/// The user's answers determine if the task is submitted or returned.
class ExercisePage extends StatefulWidget {
  final Test test;
  final int campaignId;

  const ExercisePage({
    super.key,
    required this.test,
    required this.campaignId,
  });

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  Map<String, dynamic> _responses = {};

  late final TaskBloc bloc = context.read<TaskBloc>();

  @override
  Widget build(BuildContext context) {
    final questions = widget.test.questions;
    return Scaffold(
      appBar: _buildAppBar(),
      body: questions.isEmpty ? const SizedBox.shrink() : _buildQuestion(context, questions),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.close),
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, List<Question> questions) {
    final currentQuestion = questions[_currentQuestionIndex];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: QuestionField(
        key: Key("question_$_currentQuestionIndex"),
        title: currentQuestion.title,
        schema: currentQuestion.jsonSchema,
        uiSchema: currentQuestion.uiSchema,
        correctFormData: currentQuestion.correctAnswer,
        onSubmit: (data, isCorrect) => _handleSubmit(data, isCorrect, questions),
      ),
    );
  }

  void _handleSubmit(Map<String, dynamic> data, bool isCorrect, List<Question> questions) {
    if (isCorrect) _score++;
    _responses = {..._responses, ...data};

    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _finalizeExercise();
    }
  }

  void _finalizeExercise() {
    final finalScore = _calculateTotalScore();
    if (finalScore >= widget.test.passingScore) {
      bloc.add(SubmitTask(_responses));
    } else {
      showTaskDialog(
        context,
        TaskReturnedDialog(
          onPop: () => navigateToTask(context, null, widget.campaignId),
        ),
      );
    }
  }

  int _calculateTotalScore() {
    final totalQuestions = widget.test.questions.length;
    return (_score * 100 / totalQuestions).round();
  }
}