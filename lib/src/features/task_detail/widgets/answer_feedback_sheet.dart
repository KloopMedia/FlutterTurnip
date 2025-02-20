import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

class AnswerFeedbackSheet extends StatelessWidget {
  final bool isCorrect;
  final Color color;
  final String correctValue;
  final VoidCallback onPop;

  const AnswerFeedbackSheet({
    super.key,
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
                isCorrect
                    ? context.loc.question_field_header_correct
                    : context.loc.question_field_header_incorrect,
                style: TextStyle(fontSize: 24, color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            context.loc.question_field_correct_answer_label,
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
              child: Text(
                context.loc.question_field_next_button,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
