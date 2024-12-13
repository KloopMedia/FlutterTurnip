import 'package:flutter/material.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';

/// A widget representing a single question field. It uses `FlutterJsonSchemaForm`
/// to render the question and validate against the correct answer.
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

  static const _correctColor = Color.fromRGBO(116, 191, 59, 1);
  static const _errorColor = Color.fromRGBO(255, 137, 125, 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF5C5F5F)),
          ),
        const Spacer(),
        FlutterJsonSchemaForm(
          key: UniqueKey(),
          schema: widget.schema ?? const {},
          uiSchema: widget.uiSchema,
          formData: _formData,
          correctFormData: widget.correctFormData,
          hideFinalScore: true,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onChange: (formData, _) => setState(() => _formData = formData),
          onSubmit: (data) => _handleSubmit(context, data),
        ),
      ],
    );
  }

  void _handleSubmit(BuildContext context, Map<String, dynamic> data) {
    final isCorrect = _isAnswerCorrect(data);
    _showAnswerFeedback(context, isCorrect, () => widget.onSubmit(data, isCorrect));
  }

  bool _isAnswerCorrect(Map<String, dynamic> data) {
    final correctValue = widget.correctFormData?.values.first;
    final userValue = data.values.first;
    return userValue == correctValue;
  }

  void _showAnswerFeedback(BuildContext context, bool isCorrect, VoidCallback onPop) {
    final color = isCorrect ? _correctColor : _errorColor;
    final correctValue = widget.correctFormData?.values.first?.toString() ?? "";

    showModalBottomSheet<void>(
      context: context,
      builder: (_) => _AnswerFeedbackSheet(
        isCorrect: isCorrect,
        color: color,
        correctValue: correctValue,
        onPop: onPop,
      ),
    );
  }
}

class _AnswerFeedbackSheet extends StatelessWidget {
  final bool isCorrect;
  final Color color;
  final String correctValue;
  final VoidCallback onPop;

  const _AnswerFeedbackSheet({
    required this.isCorrect,
    required this.color,
    required this.correctValue,
    required this.onPop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isCorrect ? 'Correct' : 'Incorrect',
            style: TextStyle(fontSize: 24, color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Correct Answer:',
            style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold),
          ),
          Text(correctValue, style: TextStyle(fontSize: 18, color: color)),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                backgroundColor: color,
                foregroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
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
  }
}