import 'package:dio/dio.dart';

enum ErrorTypes {
  response,
  timeout,
  cancel,
  other
}

class GigaTurnipApiRequestException implements Exception {
  final String message;
  final int? code;
  final ErrorTypes type;

  const GigaTurnipApiRequestException({required this.message, required this.type, this.code});

  factory GigaTurnipApiRequestException.fromDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return const GigaTurnipApiRequestException(
          message: 'Connection timeout',
          type: ErrorTypes.cancel,
        );
      case DioErrorType.response:
        final response = error.response;
        if (response != null) {
          return _getExceptionFromCode(response.statusCode);
        } else {
          return const GigaTurnipApiRequestException(
            message:
                'Something happened in setting up or sending the request that triggered an Error',
            type: ErrorTypes.response,
          );
        }
      case DioErrorType.cancel:
        return const GigaTurnipApiRequestException(
          message: 'Request cancelled',
          type: ErrorTypes.cancel,
        );
      default:
        return const GigaTurnipApiRequestException(
          message: 'Some other error',
          type: ErrorTypes.other,
        );
    }
  }

  static GigaTurnipApiRequestException _getExceptionFromCode(int? code) {
    var message = 'Generic response error';
    switch (code) {
      case 400:
        message = 'Bad request';
        break;
      case 401:
        message = 'Unauthorized';
        break;
      case 403:
        message = 'Forbidden';
        break;
      case 404:
        message = 'Not found';
        break;
      case 500:
        message = 'Internal Server Error';
        break;
    }
    return GigaTurnipApiRequestException(
      message: message,
      type: ErrorTypes.response,
      code: code,
    );
  }
}