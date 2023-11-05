import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(), // Define LoginPage como la página de inicio
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Nombre de usuario'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    final String username = usernameController.text;
    final String password = passwordController.text;

    // Simulación de usuario y contraseña predefinidos
    if (username == 'usuario' && password == 'contrasena') {
      // Redirige directamente a la página de inicio (lista de productos) después del inicio de sesión exitoso
      Navigator.pushReplacementNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Usuario o contraseña incorrectos'),
      ));
    }
  }
}

class HomePage extends StatelessWidget {
  final String username;

  HomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, $username'),
      ),
      body: Center(
        child: Text(
            'Has iniciado sesión exitosamente y estás en la lista de productos.'),
      ),
    );
  }
}
