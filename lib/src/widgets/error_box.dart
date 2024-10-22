import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class NetworkErrorBox extends StatelessWidget {
  final Exception error;
  final String? buttonText;
  final VoidCallback? onPressed;

  const NetworkErrorBox(this.error, {super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    final String errorCode;
    if (error is DioException) {
      errorCode = (error as DioException).response?.statusCode?.toString() ?? "";
    } else {
      errorCode = "Error";
    }

    final String errorMessage;
    if (error is DioException) {
      errorMessage = switch ((error as DioException).type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout =>
          'Connection timeout',
        DioExceptionType.badCertificate => 'Bad certificate',
        DioExceptionType.badResponse => 'Bad response',
        DioExceptionType.cancel => 'Canceled',
        DioExceptionType.connectionError => 'Connection error',
        DioExceptionType.unknown => 'Unknown error',
      };
    } else {
      errorMessage = 'Unknown error';
    }

    final colorScheme = Theme.of(context).colorScheme;

    return ErrorBox(
      header: errorCode,
      message: errorMessage,
      button: onPressed != null && buttonText != null
          ? SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary),
                onPressed: onPressed,
                child: Text(
                  buttonText!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}

class ErrorBox extends StatelessWidget {
  final String header;
  final String message;
  final Widget? button;

  const ErrorBox({super.key, required this.header, required this.message, required this.button});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.primary, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            header,
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 100,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          Text(
            message,
            style: TextStyle(
              color: colorScheme.neutral30,
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          if (button != null) const SizedBox(height: 15),
          if (button != null) button!,
        ],
      ),
    );
  }
}
