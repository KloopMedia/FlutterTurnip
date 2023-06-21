import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../bloc/bloc.dart';
import '../../task/widgets/filter_bar.dart';
import '../bloc/campaign_cubit.dart';
import '../bloc/category_bloc/category_cubit.dart';

class FilterBarWidget extends StatelessWidget {
  final List<dynamic> queries;
  final void Function(Map<String, dynamic>? query) onChanged;
  const FilterBarWidget({super.key, required this.queries, required this.onChanged});

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
            return FilterBar(
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