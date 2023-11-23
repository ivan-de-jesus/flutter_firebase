import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart'; // Importa el paquete de autenticación local aquí

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

  Future<void> _biometrico(BuildContext context) async {
    final LocalAuthentication _localAuthentication = LocalAuthentication();

    while (true) {
      try {
        bool authenticated = await _localAuthentication.authenticate(
          localizedReason: 'Escanea tu huella para acceder',
        );

        if (authenticated) {
          // El usuario se autenticó correctamente
          // Aquí puedes realizar acciones adicionales después de la autenticación
          _loginWithBiometrics(
              context); // Llama a la función _loginWithBiometrics después de la autenticación
          print('Autenticación exitosa');
          break; // Sal del bucle si la autenticación es exitosa
        } else {
          // El usuario no se autenticó correctamente
          print('Autenticación fallida');
        }
      } catch (e) {
        // Manejar errores de autenticación aquí
        print('Error de autenticación: $e');
      }
    }
  }

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
            TextButton(
              onPressed: () {
                _biometrico(
                    context); // Inicia la autenticación biométrica cuando se presiona el botón
              },
              child: Text('Iniciar sesión con huella'),
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

  void _loginWithBiometrics(BuildContext context) {
    // Simulación de inicio de sesión exitoso con autenticación biométrica
    // Redirige directamente a la página de inicio (lista de productos) después del inicio de sesión exitoso
    Navigator.pushReplacementNamed(context, '/');
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
