import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

import 'date_filter.dart';
import 'field_filter.dart';
import 'order_filter.dart';

class MobileFilter extends StatefulWidget {
  final int stageId;
  final Map<String, dynamic>? data;
  final void Function(Map<String, dynamic> value) onSubmit;

  const MobileFilter(
      {super.key, required this.stageId, required this.onSubmit, required this.data});

  @override
  State<MobileFilter> createState() => _MobileFilterState();
}

class _MobileFilterState extends State<MobileFilter> {
  OrderType _order = OrderType.recent;
  late Map<String, dynamic> filterValue = widget.data ?? {};

  @override
  Widget build(BuildContext context) {
    const _padding = EdgeInsets.symmetric(horizontal: 24);
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: _padding,
            sliver: DateFilter(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 23)),
          SliverPadding(
            padding: _padding,
            sliver: OrderFilter(
              value: _order,
              onChanged: (order) {
                setState(() {
                  _order = order;
                });
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 31)),
          SliverPadding(
            padding: _padding,
            sliver: FieldFilter(
              stageId: widget.stageId,
              data: filterValue,
              onChanged: (value) {
                setState(() {
                  filterValue = value;
                });
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 46),
            sliver: SubmitButton(
              onSubmit: () => widget.onSubmit(filterValue),
            ),
          )
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const SubmitButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onSubmit,
          child: Text(
            context.loc.apply_filter,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
