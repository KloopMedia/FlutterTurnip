import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebCategoryBar extends StatefulWidget {
  const WebCategoryBar({super.key});

  @override
  State<WebCategoryBar> createState() => _WebCategoryBarState();
}

class _WebCategoryBarState extends State<WebCategoryBar> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Категория',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: const Color(0xFF5C5F5F)),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.h),
              fillColor: Theme.of(context).colorScheme.onInverseSurface,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(style: BorderStyle.none)// Theme.of(context).colorScheme.onInverseSurface),
              )
            ),
            hint: Text(
              'Выберите',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: const Color(0xFFC4C7C7)),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF5E81FB)),
            onChanged: (String? value) {
              print('Button pressed ...');
            },
            borderRadius: BorderRadius.circular(15.r),
            items: <String>['One', 'Two'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
