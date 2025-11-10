import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dio = Dio();

class AuthInterceptor extends Interceptor {
  static final _storage = FlutterSecureStorage();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String token = await _storage.read(key: 'token') ?? '';
    options.headers['Authorization'] = 'Bearer $token';
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String mensajeError = 'Ocurrió un error inesperado.';

    if (err.type == DioExceptionType.connectionTimeout) {
      mensajeError = 'Tiempo de conexión agotado.';
    } else if (err.type == DioExceptionType.receiveTimeout) {
      mensajeError = 'Tiempo de respuesta agotado.';
    } else if (err.type == DioExceptionType.badResponse) {
      final statusCode = err.response?.statusCode;
      if (statusCode == 400) {
        mensajeError = 'Petición incorrecta.';
      } else if (statusCode == 401) {
        mensajeError = 'No autorizado. Inicia sesión nuevamente.';
      } else if (statusCode == 404) {
        mensajeError = 'Recurso no encontrado.';
      } else if (statusCode == 500) {
        mensajeError = 'Error del servidor. Intenta más tarde.';
      }
    } else if (err.type == DioExceptionType.unknown) {
      mensajeError = 'No hay conexión a internet o el servidor no responde.';
    }
    return handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: mensajeError,
      ),
    );
  }
}
