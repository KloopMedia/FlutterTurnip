import 'package:flutter/material.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

/// A widget representing a single question field. It uses `FlutterJsonSchemaForm`
/// to render the question and validate against the correct answer.
class QuestionField extends StatefulWidget {
  final String? title;
  final Map<String, dynamic>? schema;
  final Map<String, dynamic>? uiSchema;
  final Map<String, dynamic>? correctFormData;
  final List<QuestionAttachment> attachments;
  final void Function(Map<String, dynamic> data, bool isCorrect) onSubmit;

  const QuestionField({
    super.key,
    required this.title,
    required this.schema,
    this.uiSchema,
    this.attachments = const [],
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
    final formKey = GlobalKey<FlutterJsonSchemaFormState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (widget.attachments.isNotEmpty)
        //   Builder(
        //     builder: (context) {
        //       final attachment = widget.attachments.first;
        //       if (widget.attachments.first.type == QuestionAttachmentType.image) {
        //         return Container(
        //           margin: EdgeInsets.only(bottom: 32),
        //           height: 192,
        //           width: double.infinity,
        //           child: Image.network(attachment.file),
        //         );
        //       }
        //       return SizedBox.shrink();
        //     },
        //   ),

        Container(
          margin: EdgeInsets.only(bottom: 32),
          height: 192,
          width: double.infinity,
          child: Image.network("https://s3-alpha-sig.figma.com/img/0f33/314b/98995bd3b995bdbd4139a4c1cb0be115?Expires=1737936000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=TXf3Vfodr3UqQ4ey7B~ERHoqN-esI7f8dLkN8lhMAY-ntYW9642WrPl0O6mBQCsjki0uewOOhdo1WzGJ4bF41oui6R1bqoYzesnhjxE4hdvzyxgzcVJAFvWJydFDKxZovjA1vntODZDUXWjf8YKXaiyAbZS4dnoAHQ5HKzthVjU7bGZJvWmdVX~e8IGgBCRUqL~Y7Rl3UY2zaMw3Jgtl0cRuHSr9ObtaDTJ09iSWiQJYTChwGWXL0rSV0XrZlbA-Np68Bi-UvSpQDQsCNLohbfxvOJkqAegDD5j1nctVeJSVEaLFfKT47vQnC-dBmpbF-3vLoe0-H1wALpooC2g91A__"),
        ),
        if (widget.title != null)
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              widget.title!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5C5F5F),
              ),
            ),
          ),
        FlutterJsonSchemaForm(
          key: formKey,
          schema: widget.schema ?? const {},
          uiSchema: widget.uiSchema,
          formData: _formData,
          correctFormData: widget.correctFormData,
          hideFinalScore: true,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onChange: (formData, _) => setState(() => _formData = formData),
          onSubmit: (data) => _handleSubmit(context, data),
          hideSubmitButton: true,
          alternativeTheme: true,
        ),
        Spacer(),
        SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor:
                  Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
            ),
            onPressed: () => formKey.currentState!.formBloc.add(SubmitFormEvent()),
            child: Text(context.loc.form_submit_button),
          ),
        )
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
          Row(
            children: [
              Icon(isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined, color: color),
              SizedBox(width: 8),
              Text(
                isCorrect ? 'Correct' : 'Incorrect',
                style: TextStyle(fontSize: 24, color: color, fontWeight: FontWeight.bold),
              ),
            ],
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
                foregroundColor:
                    Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
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
