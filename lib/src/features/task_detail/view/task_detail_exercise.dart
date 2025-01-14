import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/widgets/app_bar/new_scaffold_appbar.dart';
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
    return ScaffoldAppbar(
      title: progressAppbar(questions.length),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.close),
      ),
      child: questions.isEmpty ? const SizedBox.shrink() : _buildQuestion(context, questions),
    );
  }

  Widget progressAppbar(int count) {
    return Row(
      children: List.generate(count, (index) {
        final isActive = index <= _currentQuestionIndex;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 10),
            height: 10,
            decoration: BoxDecoration(
              color: isActive ? Theme.of(context).colorScheme.primary : Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildQuestion(BuildContext context, List<Question> questions) {
    final currentQuestion = questions[_currentQuestionIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
