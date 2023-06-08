import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../../bloc/bloc.dart';
import '../../../../features/campaign/bloc/country_bloc/country_cubit.dart';

class CountryFilterField extends StatelessWidget {
  CountryFilterField({Key? key}) : super(key: key);
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<CountryCubit, RemoteDataState<Country>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<Country> && state.data.isNotEmpty) {
          final data = state.data;
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
                value: dropdownValue ?? 'Выберите',
                onChanged: (value) {},
                items: data
                    .map((value) => DropdownMenuItem<String>(
                      value: value.name,
                      child: Text(value.name)))
                    .toList(),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      }
    );
  }
}