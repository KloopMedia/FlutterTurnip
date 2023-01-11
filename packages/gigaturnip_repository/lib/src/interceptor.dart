import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final AuthenticationRepository _authenticationRepository;

  ApiInterceptor(this._authenticationRepository);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = await _authenticationRepository.token;

    options.headers['Authorization'] = 'JWT $accessToken';

    return handler.next(options);
  }
}
