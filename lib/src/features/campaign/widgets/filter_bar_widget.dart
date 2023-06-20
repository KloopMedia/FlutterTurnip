import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../bloc/bloc.dart';
import '../../task/widgets/filter_bar.dart';
import '../bloc/campaign_cubit.dart';
import '../bloc/category_bloc/category_cubit.dart';

class FilterBarWidget extends StatelessWidget {
  const FilterBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                context.read<SelectableCampaignCubit>().refetchWithFilter(query);
                context.read<UserCampaignCubit>().refetchWithFilter(query);
              },
              value: taskFilterMap.keys.first,
              filters: taskFilterMap,
              names: filterNames,
            );
          }
          return const SizedBox.shrink();
        }
    );
  }
}