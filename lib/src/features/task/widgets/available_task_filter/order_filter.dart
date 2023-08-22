import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

import '../../../../widgets/widgets.dart';

enum OrderType { recent, old }

class OrderFilter extends StatelessWidget {
  final OrderType value;
  final void Function(OrderType order) onChanged;

  const OrderFilter({super.key, required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.loc.sort,
            style: const TextStyle(
              color: Color(0xFF5C5F5F),
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          CustomRadioListTile(
            title: Text(
              context.loc.sort_by_new,
              style: const TextStyle(
                color: Color(0xFF444748),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            value: OrderType.recent,
            groupValue: value,
            onChanged: (newValue) {
              onChanged(newValue!);
            },
          ),
          const Divider(
            height: 1,
          ),
          CustomRadioListTile(
            title: Text(
              context.loc.sort_by_old,
              style: const TextStyle(
                color: Color(0xFF444748),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            value: OrderType.old,
            groupValue: value,
            onChanged: (newValue) {
              onChanged(newValue!);
            },
          )
        ],
      ),
    );
  }
}
