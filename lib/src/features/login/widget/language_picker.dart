import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';

class SupportedLocale {
  final String name;
  final String code;

  const SupportedLocale(this.name, this.code);
}

class LanguagePicker extends StatefulWidget {
  final String? errorMessage;
  final bool isLocaleSelected;

  const LanguagePicker({
    super.key,
    this.errorMessage,
    required this.isLocaleSelected,
  });

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  late final theme = Theme.of(context).colorScheme;
  late final supportedLocales = _getSupportedLocales();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDropdownContainer(
          context: context,
          supportedLocales: supportedLocales,
          theme: theme,
        ),
        const SizedBox(height: 10),
        _buildErrorMessage(theme),
      ],
    );
  }

  /// Returns the list of supported locales.
  List<SupportedLocale> _getSupportedLocales() {
    return const [
      SupportedLocale('Кыргыз тили', 'ky'),
      SupportedLocale('English', 'en'),
      SupportedLocale('Русский', 'ru'),
    ];
  }

  /// Builds the dropdown container.
  Widget _buildDropdownContainer({
    required BuildContext context,
    required List<SupportedLocale> supportedLocales,
    required ColorScheme theme,
  }) {
    final borderRadius = BorderRadius.circular(24);
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: theme.neutral30,
    );
    final currentLocaleCode =
        context.read<LocalizationBloc>().state.locale.languageCode.split('_').first;
    final dropdownValue = widget.isLocaleSelected ? currentLocaleCode : null;

    return Container(
      width: 247,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: Shadows.elevation3,
        border: widget.errorMessage != null ? Border.all(color: theme.error) : null,
      ),
      child: DropdownButtonFormField<String>(
        padding: const EdgeInsets.only(left: 15, right: 15),
        style: textStyle,
        borderRadius: borderRadius,
        dropdownColor: Colors.white,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        hint: Row(
          children: [
            Icon(Icons.language, color: theme.primary),
            SizedBox(width: 5),
            Text(context.loc.choose_language),
          ],
        ),
        icon: Icon(Icons.keyboard_arrow_down, color: theme.neutral30),
        isDense: true,
        value: dropdownValue,
        onChanged: (locale) => _onLocaleChanged(context, locale),
        items: _buildDropdownItems(),
        selectedItemBuilder: (context) => _buildSelectedItems(),
      ),
    );
  }

  /// Builds the dropdown items.
  List<DropdownMenuItem<String>> _buildDropdownItems() {
    return supportedLocales.map((locale) {
      return DropdownMenuItem<String>(
        value: locale.code,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(locale.name),
        ),
      );
    }).toList();
  }

  List<Widget> _buildSelectedItems() {
    return supportedLocales.map((locale) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.language, color: theme.primary),
          const SizedBox(width: 8),
          Text(locale.name),
        ],
      );
    }).toList();
  }

  /// Handles the locale change.
  void _onLocaleChanged(BuildContext context, String? locale) {
    if (locale != null) {
      context.read<LocalizationBloc>().add(ChangeLocale(Locale(locale)));
    }
  }

  /// Builds the error message text.
  Widget _buildErrorMessage(ColorScheme theme) {
    if (widget.errorMessage == null || widget.errorMessage!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Text(
      widget.errorMessage!,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: theme.error,
      ),
    );
  }
}
