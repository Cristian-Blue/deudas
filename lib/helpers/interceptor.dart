import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dio = Dio();

class AuthInterceptor extends Interceptor {
  static final _storage = FlutterSecureStorage();
  static String? accesToken;

  AuthInterceptor() {
    _storage.read(key: 'token').then((value) {
      accesToken = value;
    });
  }

  @override
  void onRequest(
    RequestOptions requestOption,
    RequestInterceptorHandler requestInterceptorHandler,
  ) {
    requestOption.headers['Authorization'] = 'Bearer $accesToken';
    super.onRequest(requestOption, requestInterceptorHandler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler responseInterceptorHandler,
  ) {
    super.onResponse(response, responseInterceptorHandler);
  }

  @override
  void onError(
    DioException error,
    ErrorInterceptorHandler errorInterceptorHandler,
  ) {
    super.onError(error, errorInterceptorHandler);
  }
}
