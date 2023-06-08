import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class WebFilterField extends StatelessWidget {
  const WebFilterField({Key? key, this.dropdownValue}) : super(key: key);
  final String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Text(
            'Страна',
            style: TextStyle(
              color: theme.neutral40,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          style: TextStyle(
            color: theme.neutral40,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: 'Выберите',
            hintStyle: TextStyle(
              color: theme.neutral80,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.neutral95, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.primary, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            filled: true,
            fillColor: theme.neutral95,
            prefixIconConstraints: const BoxConstraints(minWidth: 20, maxHeight: 54),
          ),
          isExpanded: true,
          isDense: true,
          icon: Icon(Icons.keyboard_arrow_down, color: theme.primary),
          value: dropdownValue,//context.read<LocalizationBloc>().state.locale.languageCode.split('_').first,
          onChanged: (locale) {},
          items: const [
            DropdownMenuItem(
              value: 'ch',
              child: Text('Choose'),
            ),
            DropdownMenuItem(
              value: 'ky',
              child: Text('Кыргыз тили'),
            ),
            DropdownMenuItem(
              value: 'ru',
              child: Text('Русский'),
            ),
          ],
        ),
      ],
    );
  }
}