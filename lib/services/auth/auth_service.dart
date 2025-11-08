import 'package:cuenta/model/auth/auth_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final _dio = Dio();
  static final _storage = FlutterSecureStorage();
  static final url = 'https://api.escuelajs.co/api/v1/auth/login';

  static Future<String?> getToken(String username, String password) async {
    try {
      username = 'john@mail.com';
      password = 'changeme';
      final response = await _dio.post(
        url,
        data: {'email': username, 'password': password},
      );
      if (response.statusCode != 201 && response.statusCode != 200) {
        return 'Respuesta inesperada del servidor.';
      }

      AuthModel res = AuthModel.formJson(response.data);
      if (res.accessToken == 'No token') {
        return 'No se recibió un token de acceso.';
      }
      await _storage.write(key: 'token', value: res.accessToken);

      return null;
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          return 'Usuario o contraseña incorrectos.';
        }
        return 'Error del servidor: ${e.response?.statusCode}';
      } else {
        return 'Error de red. Revisa tu conexión a internet.';
      }
    }
  }
}
