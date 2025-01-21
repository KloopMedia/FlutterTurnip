import 'package:flutter/material.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import 'answer_feedback_sheet.dart';

/// A widget representing a single question field. It uses `FlutterJsonSchemaForm`
/// to render the question and validate against the correct answer.
class QuestionField extends StatefulWidget {
  final String? title;
  final Map<String, dynamic>? schema;
  final Map<String, dynamic>? uiSchema;
  final Map<String, dynamic>? correctFormData;
  final List<QuestionAttachment> attachments;
  final bool isLast;
  final void Function(Map<String, dynamic> data, bool isCorrect) onSubmit;

  const QuestionField({
    super.key,
    required this.title,
    required this.schema,
    this.uiSchema,
    this.attachments = const [],
    required this.correctFormData,
    required this.onSubmit,
    required this.isLast,
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
        if (widget.attachments.isNotEmpty)
          Builder(
            builder: (context) {
              final attachment = widget.attachments.first;
              if (widget.attachments.first.type == QuestionAttachmentType.image) {
                return Container(
                  margin: EdgeInsets.only(bottom: 32),
                  height: 192,
                  width: double.infinity,
                  child: Image.network(attachment.file),
                );
              }
              return SizedBox.shrink();
            },
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
            onPressed: _formData.isNotEmpty
                ? () => formKey.currentState!.formBloc.add(SubmitFormEvent())
                : null,
            child: Text(
              widget.isLast
                  ? context.loc.form_submit_button
                  : context.loc.question_field_next_button,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
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
      builder: (_) => AnswerFeedbackSheet(
        isCorrect: isCorrect,
        color: color,
        correctValue: correctValue,
        onPop: onPop,
      ),
    );
  }
}
