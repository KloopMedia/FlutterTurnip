part of 'localization_bloc.dart';

class LocalizationState  extends Equatable {
  final Locale locale;
  final bool firstLogin;

  const LocalizationState ({
    required this.locale,
    required this.firstLogin,
  });

  @override
  List<Object?> get props => [locale, firstLogin];
}
