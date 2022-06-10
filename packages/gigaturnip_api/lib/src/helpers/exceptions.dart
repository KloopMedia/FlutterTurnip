import 'package:dio/dio.dart';

class GigaTurnipApiRequestException implements Exception {
  final String message;
  final int? code;
  final DioErrorType type;

  const GigaTurnipApiRequestException({required this.message, required this.type, this.code});

  factory GigaTurnipApiRequestException.fromDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return GigaTurnipApiRequestException(
          message: 'Connection timeout',
          type: error.type,
        );
      case DioErrorType.response:
        final response = error.response;
        if (response != null) {
          return _getExceptionFromCode(response.statusCode);
        } else {
          return GigaTurnipApiRequestException(
            message:
                'Something happened in setting up or sending the request that triggered an Error',
            type: error.type,
          );
        }
      case DioErrorType.cancel:
        return GigaTurnipApiRequestException(
          message: 'Request cancelled',
          type: error.type,
        );
      default:
        return GigaTurnipApiRequestException(
          message: 'Some other error',
          type: error.type,
        );
    }
  }

  static GigaTurnipApiRequestException _getExceptionFromCode(int? code) {
    switch (code) {
      case 400:
        return GigaTurnipApiRequestException(
          message: 'Bad request',
          type: DioErrorType.response,
          code: code,
        );
      case 401:
        return GigaTurnipApiRequestException(
          message: 'Unauthorized',
          type: DioErrorType.response,
          code: code,
        );
      case 403:
        return GigaTurnipApiRequestException(
          message: 'Forbidden',
          type: DioErrorType.response,
          code: code,
        );
      case 404:
        return GigaTurnipApiRequestException(
          message: 'Not found',
          type: DioErrorType.response,
          code: code,
        );
      case 500:
        return GigaTurnipApiRequestException(
          message: 'Internal Server Error',
          type: DioErrorType.response,
          code: code,
        );
      default:
        return GigaTurnipApiRequestException(
            message: 'Generic response error', type: DioErrorType.response, code: code);
    }
  }
}