import 'package:flutter/material.dart';


class CardProgressIndicator extends StatelessWidget {
  final EdgeInsetsGeometry? _padding;

  const CardProgressIndicator({Key? key, EdgeInsetsGeometry? padding})
      : _padding = padding,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: _padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Осталось 4 задания до следующего уровня!',
            style: TextStyle(fontSize: 14, color: theme.onSurfaceVariant),
          ),
          Row(
            children: const [
              Icon(Icons.looks_one, color: Color(0xffDFC902)),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: LinearProgressIndicator(
                      value: 3,
                      minHeight: 6,
                    ),
                  ),
                ),
              ),
              Icon(Icons.looks_two, color: Color(0xffDFC902)),
            ],
          ),
        ],
      ),
    );
  }
}
