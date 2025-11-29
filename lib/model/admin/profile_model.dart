import 'package:cuenta/model/admin/producto_model.dart';

class ProfileModel {
  int id;
  String email;
  String password;
  String name;
  String role;
  String avatar;

  ProfileModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: _parseId(json["id"]),
    email: json["email"] ?? 'Not email',
    password: json["password"] ?? 'Not password',
    name: json["name"] ?? 'Not name',
    role: json["role"] ?? 'Not role',
    avatar: json["avatar"] ?? 'Not avatar',
  );

  static int _parseId(dynamic value) {
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }
}
