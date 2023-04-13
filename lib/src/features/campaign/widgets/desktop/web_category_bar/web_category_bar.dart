import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebCategoryBar extends StatefulWidget {
  final String title;

  const WebCategoryBar({super.key, required this.title});

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
        Container(
          width: MediaQuery.of(context).size.width / 5,
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: const Color(0xFF5C5F5F) ///neutral40
                ),
              ),
              TextButton(
                onPressed: () {
                  print('Button pressed...');
                },
                child: Text(
                  'Очистить',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: const Color(0xFFFFB4AB) ///error80
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: MediaQuery.of(context).size.width / 5,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.h),
              fillColor: Theme.of(context).colorScheme.onInverseSurface,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(style: BorderStyle.none),
              )
            ),
            hint: Text(
              'Выберите',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: const Color(0xFFC4C7C7) ///neutral-variant40
              ),
            ),
            icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).colorScheme.primary),
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
