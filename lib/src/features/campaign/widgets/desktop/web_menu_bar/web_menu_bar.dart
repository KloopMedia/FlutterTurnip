import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebMenuBar extends StatelessWidget {
  const WebMenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          // padding: EdgeInsets.fromLTRB(30.h, 30.h, 30.h, 0.h),
          child: Column(
            children: [
              buildBody(context),
              buildBody(context),
            ],
          ),
        ),
      ],
    );
  }
  Widget buildBody(BuildContext context) {
    const avatar = null;

    final Widget userAvatar;
    if (avatar != null) {
      userAvatar = CircleAvatar(
        radius: 30.r,
        backgroundImage: NetworkImage(avatar),
      );
    } else {
      userAvatar = CircleAvatar(
        radius: 30.r,
        child: Icon(
          Icons.person,
          size: 24.sp,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(30.h, 30.h, 30.h, 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userAvatar,
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Willy Wonka',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: const Color(0xFF45464F)
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'willy.wonka@gmail.com',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: const Color(0xFF747878)
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ]),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(30.h, 0.h, 0.h, 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.language,
                    size: 27.sp,
                    color: const Color(0xFF5E81FB),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(12.h, 0.h, 27.h, 0.h),
                          filled: false,
                          focusColor: Colors.green,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.none),
                          )
                      ),
                      hint: Text(
                        'Русский',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: const Color(0xFF45464F)),
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
              ),
              Container(
                height: 0.5.h,
                color: const Color(0xFFDCE1FF),
              ),
              SizedBox(
                height: 22.h,
              ),
            ]
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(30.h, 0.h, 30.h, 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.window_outlined,
                    size: 27.sp,
                    color: const Color(0xFF5E81FB),
                  ),
                  SizedBox(
                    width: 22.h,
                  ),
                  Text(
                      'Кампании',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: const Color(0xFF2E3132)
                      )
                  )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        size: 27.sp,
                        color: const Color(0xFF5E81FB),
                      ),
                      SizedBox(
                        width: 22.h,
                      ),
                      Text(
                          'Уведомления',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: const Color(0xFF2E3132)
                          )
                      ),
                    ],
                  ),
                  Container(
                      width: 24.h,
                      height: 24.h,
                      margin: EdgeInsets.zero,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF4B9627),
                      ),
                      child: Center(
                        child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Theme.of(context).colorScheme.onPrimary)
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bedtime_outlined,
                        size: 27.sp,
                        color: const Color(0xFF5E81FB),
                      ),
                      Icon(
                        Icons.star_border_outlined,
                        size: 15.sp,
                        color: const Color(0xFF5E81FB),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Text(
                      'Темная тема',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: const Color(0xFF2E3132)
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}


