import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/widgets/chip_bar/index.dart';

import '../../../bloc/bloc.dart';
import '../bloc/campaign_cubit.dart';
import '../bloc/category_bloc/category_cubit.dart';

class CategoryFilterBarWidget extends StatelessWidget {
  final List<dynamic> queries;
  final void Function(Map<String, dynamic>? query) onChanged;
  const CategoryFilterBarWidget({super.key, required this.queries, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    String? queryValue;
    for (var query in queries) {
      if (query is Category) {
        queryValue = query.name;
        break;
      } else {
        continue;
      }
    }

    return BlocBuilder<CategoryCubit, RemoteDataState<Category>>(
        builder: (context, state) {
          final Map<String, Map<String, dynamic>?> taskFilterMap = {'Все': {}};
          final filterNames = ['Все'];
          if (state is RemoteDataLoaded<Category> && state.data.isNotEmpty) {
            for (var category in state.data) {
              taskFilterMap.addAll({category.name: {'categories': category.id}});
            }
            for (var category in state.data) {
              filterNames.add(category.name);
            }
            return CategoryFilterBar(
              onChanged: (query) {
                context.read<SelectableCampaignCubit>().refetchWithFilter(query!.values.first);
                context.read<UserCampaignCubit>().refetchWithFilter(query.values.first);
                onChanged(query);
              },
              value: queryValue ?? taskFilterMap.keys.first,
              filters: taskFilterMap,
              names: filterNames,
            );
          }
          return const SizedBox.shrink();
        }
    );
  }
}

class CategoryFilterBar extends StatefulWidget {
  final String value;
  final Map<String, Map<String, dynamic>?> filters;
  final List<String> names;
  final void Function(Map<String, dynamic>? value) onChanged;

  const CategoryFilterBar({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.filters,
    required this.names,
  }) : super(key: key);

  @override
  State<CategoryFilterBar> createState() => _CategoryFilterBarState();
}

class _CategoryFilterBarState extends State<CategoryFilterBar> {

  @override
  Widget build(BuildContext context) {
    final keys = widget.filters.keys.toList();
    final values = widget.filters.values.toList();

    return FixedChipBar(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      children: [
        for (var i = 0; i < widget.filters.length; i++)
          DefaultChip(
            label: widget.names[i],
            active: keys[i] == widget.value,
            onPressed: () {
              widget.onChanged({keys[i]: values[i]});
            },
          ),
      ],

    );
  }
}