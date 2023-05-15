import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/features/login/widget/login_panel.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../bloc/login_bloc.dart';
import 'otp_verification.dart';

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
    final theme = Theme.of(context).colorScheme;
    final radius = const Radius.circular(15);

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailed) {
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return Dialog(
              //       child: Text(state.errorMessage),
              //     );
              //   },
              // );
            }
          },
          builder: (context, state) {
            if (state is OTPCodeSend) {
              return VerificationPage(
                onConfirm: (smsCode) {
                  context.read<LoginBloc>().add(ConfirmOTP(smsCode, state.verificationId));
                },
              );
            }
            if (context.isSmall) {
              return const LoginPanel(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 69),
              );
            } else {
              return Row(
                children: [
                  Container(
                    width: context.isMedium ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: theme.primary,
                      borderRadius: BorderRadius.only(topRight: radius, bottomRight: radius),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey,
                                ),
                                alignment: Alignment.center,
                                width: 70,
                                height: 70,
                                child: const Text('Logo'),
                              ),
                              const SizedBox(height: 80),
                              Text(
                                'Присоединяйтесь к сообществу проактивных людей!',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Здесь люди объединяются и решают общественно значимые проблемы вместе',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Image.asset('assets/images/people.png'),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Flexible(
                          child: LoginPanel(
                            padding: EdgeInsets.all(20),
                            constraints: BoxConstraints(maxWidth: 500, maxHeight: 500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
