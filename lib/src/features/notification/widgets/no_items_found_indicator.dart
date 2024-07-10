import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

import 'first_page_exception_indicator.dart';

class NoItemsFoundIndicator extends StatelessWidget {
  const NoItemsFoundIndicator({super.key});

  @override
  Widget build(BuildContext context) => FirstPageExceptionIndicator(
        title: context.loc.no_notifications,
      );
}
