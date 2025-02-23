import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  // Ключи для SharedPreferences
  static const String _keyUsers = 'users';

  // Регистрация нового пользователя
  static Future<bool> register(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(_keyUsers) ?? [];

    // Проверка, существует ли пользователь с таким email
    if (users.any((u) => u.contains(user.email))) {
      return false; // Пользователь уже существует
    }

    // Сохраняем пользователя
    users.add('${user.username}|${user.email}|${user.password}');
    await prefs.setStringList(_keyUsers, users);
    return true;
  }

  // Вход пользователя
  static Future<User?> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(_keyUsers) ?? [];

    for (var u in users) {
      final parts = u.split('|');
      if (parts[1] == email && parts[2] == password) {
        return User(username: parts[0], email: parts[1], password: parts[2]);
      }
    }
    return null; // Пользователь не найден
  }
}