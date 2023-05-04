import 'package:authentication_repository/authentication_repository.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/login/widget/login_provider_button.dart';
import 'package:gigaturnip/src/theme/index.dart';
import '../../../widgets/button/sign_in_button.dart';
import '../../../widgets/button/sign_up_button.dart';
import '../bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: const SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(24.0),
            child: RegistrationPage(),
          ),
        ),
      ),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final subtitleTextStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: theme.neutral30,
    );
    final dividerTextStyle = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF0E222F).withOpacity(0.6),
    );
    final titleTextStyle = TextStyle(
      fontSize: 25.sp,
      fontWeight: FontWeight.w500,
      color: theme.neutral30,
    );
    final divider = Expanded(
      child: Divider(thickness: 1.5, color: const Color(0xFF0E222F).withOpacity(0.1)),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListTile(
          minVerticalPadding: 15.0,
          contentPadding: const EdgeInsets.all(0.0),
          title: Text(
            context.loc.welcome,
            style: titleTextStyle,
          ),
          subtitle: Text(
            context.loc.sign_in_or_sign_up,
            style: subtitleTextStyle,
          ),
        ),
        const PhoneNumberField(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: [
              divider,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Text(
                  context.loc.or,
                  style: dividerTextStyle,
                ),
              ),
              divider,
            ],
          ),
        ),
        const LoginProviderButtons(),
        const Spacer(),
        Column(
          children: const [
            SignUpButton(onPressed: null),
            SizedBox(height: 20.0),
            SignInButton(onPressed: null),
          ],
        ),
      ],
    );
  }
}

class LoginProviderButtons extends StatelessWidget {
  const LoginProviderButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
    );

    return Column(
      children: [
        LoginProviderButton(
          color: Colors.white,
          onPressed: () => context.read<LoginBloc>().add(const TryToLogin(AuthProvider.google)),
          icon: Image.asset('assets/icon/google_icon.png', height: 24.0),
          child: Text(
            context.loc.continue_with_google,
            style: textStyle.copyWith(
              fontFamily: 'Roboto',
              color: Colors.black.withOpacity(0.54),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        LoginProviderButton(
          color: Colors.black,
          onPressed: () => context.read<LoginBloc>().add(const TryToLogin(AuthProvider.google)),
          icon: Image.asset('assets/icon/apple_icon.png', height: 24.0),
          child: Text(
            context.loc.continue_with_apple,
            style: textStyle.copyWith(
              fontFamily: 'SF Pro Display',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({Key? key}) : super(key: key);

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  String? selectedCode = '+996';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final textStyle = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);
    final selectorTextStyle = textStyle.copyWith(color: theme.neutral40);
    final titleStyle = textStyle.copyWith(color: theme.neutral30, fontWeight: FontWeight.w500);
    final boxDecoration = BoxDecoration(
      color: theme.neutral95,
      borderRadius: BorderRadius.circular(15),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.loc.enter_phone_number,
          style: titleStyle,
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 54,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              margin: const EdgeInsets.only(right: 8),
              decoration: boxDecoration,
              child: CountryCodePicker(
                onChanged: (code) {
                  setState(() {
                    selectedCode = code.dialCode;
                  });
                },
                initialSelection: selectedCode,
                favorite: const ['KG'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: true,
                hideMainText: true,
                flagDecoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.zero,
                builder: (code) {
                  return Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5), // Image border
                        child: Image.asset(
                          code!.flagUri!,
                          package: 'country_code_picker',
                          height: 24,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.keyboard_arrow_down)
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: CupertinoTextField(
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(selectedCode ?? "", style: selectorTextStyle),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17.5),
                decoration: boxDecoration,
                style: selectorTextStyle,
                placeholder: 'xxx-xxx-xxx',
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
