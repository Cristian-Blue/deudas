import 'package:cuenta/model/admin/producto_model.dart';
import 'package:dio/dio.dart';

class DeudaService {
  static final _dio = Dio();
  static final url = 'https://api.escuelajs.co/api/v1';

  static Future<String> saveDeuda(
    String monto,
    String description,
    String provider,
  ) async {
    try {
      final response = await _dio.post(
        '$url/products',
        data: {
          "title": "New Product temporal",
          "price": 10,
          "description": "A description",
          "categoryId": 24,
          "images": ["https://placehold.co/600x400"],
        },
      );
      if (response.statusCode != 201 && response.statusCode != 200) {
        return 'Respuesta inesperada del servidor.';
      }
      return 'Ingreado correctamente';
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 400) {
          return e.response?.data['message'];
        }
        return 'Error del servidor: ${e.response?.statusCode}';
      } else {
        return 'Error de red. Revisa tu conexión a internet.';
      }
    }
  }

  static Future<List<ProductoModel>> getDeudas() async {
    final response = await _dio.get('$url/products');
    List<ProductoModel> deudas = [];
    print("===============================");
    print(response.data);
    print("===============================");
    if (response.statusCode != 200) {
      return [];
    }
    for (final item in response.data) {
      deudas.add(ProductoModel.fromJson(item));
    }
    return deudas;
  }
}
