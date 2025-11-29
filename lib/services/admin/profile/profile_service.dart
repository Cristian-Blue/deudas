import 'package:cuenta/helpers/interceptor.dart';
import 'package:cuenta/model/admin/profile_model.dart';
import 'package:dio/dio.dart';

class ProfileService {
  static final _dio = Dio()..interceptors.add(AuthInterceptor());
  static final url = 'https://api.escuelajs.co/api/v1';

  Future<ProfileModel> getProfile() async {
    final response = await _dio.get('$url/auth/profile');
    if (response.statusCode != 200) {
      return ProfileModel.fromJson({});
    }
    return ProfileModel.fromJson(response.data);
  }
}
