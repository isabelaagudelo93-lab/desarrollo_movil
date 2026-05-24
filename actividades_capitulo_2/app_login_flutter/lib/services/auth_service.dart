 import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _usersKey = 'registered_users';
  static const String _loggedUserKey = 'logged_user';

  static String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey);
      List<Map<String, dynamic>> users = [];

      if (usersJson != null) {
        final List<dynamic> decoded = jsonDecode(usersJson);
        users = decoded.cast<Map<String, dynamic>>();
      }

      final emailExists = users.any(
        (u) => u['email'].toString().toLowerCase() == email.toLowerCase(),
      );

      if (emailExists) {
        return {
          'success': false,
          'message': 'Ya existe una cuenta con este correo.',
        };
      }

      final newUser = UserModel(
        name: name,
        email: email.toLowerCase(),
        password: _hashPassword(password),
      );

      users.add(newUser.toMap());
      await prefs.setString(_usersKey, jsonEncode(users));

      return {
        'success': true,
        'message': '¡Cuenta creada exitosamente!',
        'user': newUser,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error al registrar: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey);

      if (usersJson == null) {
        return {
          'success': false,
          'message': 'No hay usuarios registrados.',
        };
      }

      final List<dynamic> decoded = jsonDecode(usersJson);
      final List<Map<String, dynamic>> users =
          decoded.cast<Map<String, dynamic>>();

      final hashedPassword = _hashPassword(password);

      final userMap = users.firstWhere(
        (u) =>
            u['email'].toString().toLowerCase() == email.toLowerCase() &&
            u['password'] == hashedPassword,
        orElse: () => {},
      );

      if (userMap.isEmpty) {
        return {
          'success': false,
          'message': 'Correo o contraseña incorrectos.',
        };
      }

      final user = UserModel.fromMap(userMap);
      await prefs.setString(_loggedUserKey, jsonEncode(userMap));

      return {
        'success': true,
        'message': '¡Bienvenido, ${user.name}!',
        'user': user,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error al iniciar sesión: ${e.toString()}',
      };
    }
  }

  Future<UserModel?> getLoggedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_loggedUserKey);
      if (userJson == null) return null;
      final map = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromMap(map);
    } catch (_) {
      return null;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedUserKey);
  }

  Future<bool> isLoggedIn() async {
    final user = await getLoggedUser();
    return user != null;
  }
}
