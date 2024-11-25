import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/task_detail/util/util.dart';
import 'package:gigaturnip/src/widgets/dialogs/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../router/routes/routes.dart';
import '../../../widgets/dialogs/form_dialog.dart';
import '../bloc/bloc.dart';

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
  int _index = 0;

  int _score = 0;
  Map<String, dynamic> _responses = {};

  late final bloc = context.read<TaskBloc>();

  int calculateTotalScore(int score) {
    final totalQuestions = widget.test.questions.length;
    return (score * 100 / totalQuestions).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: Builder(builder: (context) {
        final questions = widget.test.questions;

        if (questions.isEmpty) {
          return SizedBox.shrink();
        }

        final question = questions[_index];

        print(question.title);

        return Padding(
          padding: const EdgeInsets.all(16),
          child: QuestionField(
            key: Key("question_$_index"),
            title: question.title,
            schema: question.jsonSchema,
            uiSchema: question.uiSchema,
            correctFormData: question.correctAnswer,
            onSubmit: (data, isCorrect) {
              if (isCorrect) {
                _score += 1;
              }
              _responses = {..._responses, ...data};

              if (_index < questions.length - 1) {
                setState(() {
                  _index += 1;
                });
              } else {
                if (calculateTotalScore(_score) >= widget.test.passingScore) {
                  context.read<TaskBloc>().add(SubmitTask(_responses));
                } else {
                  showTaskDialog(
                    context,
                    TaskReturnedDialog(
                      onPop: () => navigateToTask(context, null, widget.campaignId),
                    ),
                  );
                }
              }
            },
          ),
        );
      }),
    );
  }
}

const _correctColor = Color.fromRGBO(116, 191, 59, 1);
const _errorColor = Color.fromRGBO(255, 137, 125, 1);

Color _getColor(bool isCorrect) {
  if (isCorrect) {
    return _correctColor;
  } else {
    return _errorColor;
  }
}

class QuestionField extends StatefulWidget {
  final String? title;
  final Map<String, dynamic>? schema;
  final Map<String, dynamic>? uiSchema;
  final Map<String, dynamic>? correctFormData;
  final void Function(Map<String, dynamic> data, bool isCorrect) onSubmit;

  const QuestionField({
    super.key,
    required this.title,
    required this.schema,
    this.uiSchema,
    required this.correctFormData,
    required this.onSubmit,
  });

  @override
  State<QuestionField> createState() => _QuestionFieldState();
}

class _QuestionFieldState extends State<QuestionField> {
  Map<String, dynamic> _formData = {};

  _getCorrectValue() {
    return widget.correctFormData?.values.first;
  }

  _showAnswer(BuildContext context, bool isCorrect, VoidCallback onPop) {
    final color = _getColor(isCorrect);
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                isCorrect ? 'Correct' : 'Incorrect',
                style: TextStyle(fontSize: 24, color: color, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Correct Answer:',
                style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold),
              ),
              Text(
                _getCorrectValue() ?? "",
                style: TextStyle(fontSize: 18, color: color),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: color,
                    foregroundColor: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onPop();
                  },
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF5C5F5F),
            ),
          ),
        Spacer(),
        FlutterJsonSchemaForm(
          key: UniqueKey(),
          schema: widget.schema ?? {},
          uiSchema: widget.uiSchema,
          formData: _formData,
          correctFormData: widget.correctFormData,
          hideFinalScore: true,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onChange: (formData, path) {
            setState(() {
              _formData = formData;
            });
          },
          onSubmit: (data) {
            final isCorrect = _getCorrectValue() == data.values.first;
            _showAnswer(
              context,
              isCorrect,
              () => widget.onSubmit(data, isCorrect),
            );
          },
        ),
      ],
    );
  }
}
