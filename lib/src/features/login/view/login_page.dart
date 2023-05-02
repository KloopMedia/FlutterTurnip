import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'KG');

  // void getPhoneNumber(String phoneNumber) async {
  //   PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');
  //
  //   setState(() {
  //     this.number = number;
  //   });
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final subtitleTextStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: theme.neutral30,
    );
    final selectorTextStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: theme.neutral40,
    );
    final hintStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: theme.neutral80,
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
      child: Divider(
          thickness: 1.5,
          color: const Color(0xFF0E222F).withOpacity(0.1)
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListTile(
          minVerticalPadding: 15.0,
          contentPadding: const EdgeInsets.all(0.0),
          title: Text(
            'Добро пожаловать!',
            style: titleTextStyle,
          ),
          subtitle: Text(
            'Авторизуйтесь или зарегистрируйтесь, чтобы продолжить',
            style: subtitleTextStyle,
          ),
        ),
        Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                      color: theme.neutral95,
                    ),
                    child: Stack(
                      children: [
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {},
                          onInputValidated: (bool value) {},
                          onSaved: (PhoneNumber number) {},
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            trailingSpace: false,
                            leadingPadding: 40.0,
                          ),
                          selectorTextStyle: selectorTextStyle,
                          initialValue: number,
                          textFieldController: controller,
                          maxLength: 11,
                          inputDecoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 13.0),
                            border: InputBorder.none,
                            hintText: 'xxx-xxx-xxx',
                            hintStyle: hintStyle,
                          ),
                          spaceBetweenSelectorAndTextField: 0.0,
                          textStyle: selectorTextStyle,
                          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                        ),
                        Positioned(
                          left: 8,
                          top: 12,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 24.0,
                            color: theme.neutral30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                children: [
                  divider,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Text(
                      'или',
                      style: dividerTextStyle,
                    ),
                  ),
                  divider,
                ],
              ),
            ),
            _GoogleLoginButton(),
            const SizedBox(height: 15),
            _AppleLoginButton(),
          ],
        ),
        Column(
          children: [
            SignUpButton(onPressed: null),
            const SizedBox(height: 20),
            SignInButton(onPressed: null),
          ],
        ),
      ],
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: theme.neutral30,
    );

    return
      SizedBox(
        width: double.infinity,
        height: 52.0,
        child: ElevatedButton(
          onPressed: () => context.read<LoginBloc>().add(const TryToLogin(AuthProvider.google)),
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            side: BorderSide(
              color: const Color(0xFF0E222F).withOpacity(0.2),
            ),
            backgroundColor: theme.onPrimary,
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/icon/google_icon.png',
                height: 24.0,
              ),
              Expanded(
                child: Text(
                  context.loc.sign_in_with_google,
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ),
      );
  }
}

class _AppleLoginButton extends StatelessWidget {
  const _AppleLoginButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: theme.neutral30,
    );

    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side:  BorderSide(
            color: const Color(0xFF0E222F).withOpacity(0.2),
          ),
          backgroundColor: theme.onPrimary,
        ),
        onPressed: () => context.read<LoginBloc>().add(const TryToLogin(AuthProvider.google)),
        child: Row(
          children: [
            Image.asset(
              'assets/icon/face_id_icon.png',
              height: 24.0,
            ),
            Expanded(
              child: Text(
                context.loc.sign_in_with_apple,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
