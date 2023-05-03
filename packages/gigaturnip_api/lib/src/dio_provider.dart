import 'package:dio/dio.dart';
import 'package:authentication_repository/authentication_repository.dart';

class DioProvider {
  static Dio instance(AuthenticationRepository authenticationRepository) {
    final dio = Dio();

    dio.interceptors.add(ApiInterceptor(authenticationRepository));

    return dio;
  }
}

class ApiInterceptor extends Interceptor {
  final AuthenticationRepository _authenticationRepository;

  ApiInterceptor(this._authenticationRepository);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = await _authenticationRepository.token;

    options.headers['Authorization'] = 'JWT $accessToken';

    options.contentType ??= Headers.jsonContentType;

    if (!options.path.endsWith('/')) {
      options.path = '${options.path}/';
    }

    return handler.next(options);
  }
}
