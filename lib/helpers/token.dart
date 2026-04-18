import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthNotifier extends ChangeNotifier {
  String? _token;

  String? get token => _token;
  final storage = FlutterSecureStorage();

  AuthNotifier() {
    loadToken();
  }

  Future<void> loadToken() async {
    _token = await storage.read(key: 'token');
    notifyListeners();
  }

  Future<void> login(String newToken) async {
    await storage.write(key: 'token', value: newToken);
    _token = newToken;
    notifyListeners();
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
    _token = null;
    notifyListeners();
  }
}
