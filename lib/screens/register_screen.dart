import 'package:flutter/material.dart';
import '../models/user.dart'; // Импорт модели User
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final user = User( // Используйте класс User
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      final success = await AuthService.register(user);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Регистрация успешна!")),
        );
        Navigator.pop(context); // Вернуться на предыдущий экран
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Пользователь с таким email уже существует")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Регистрация"),
        backgroundColor: Colors.deepPurple, // Цвет фона AppBar
      ),
      body: Container(
        color: Colors.lightBlue[50], // Цвет фона экрана
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Имя пользователя",
                  labelStyle: TextStyle(color: Colors.deepPurple), // Цвет текста метки
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple), // Цвет подчеркивания
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Введите имя пользователя";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.deepPurple), // Цвет текста метки
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple), // Цвет подчеркивания
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return "Введите корректный email";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Пароль",
                  labelStyle: TextStyle(color: Colors.deepPurple), // Цвет текста метки
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple), // Цвет подчеркивания
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Введите пароль";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Цвет кнопки
                ),
                child: Text("Зарегистрироваться", style: TextStyle(color: Colors.white)), // Цвет текста кнопки
              ),
            ],
          ),
        ),
      ),
    );
  }
}