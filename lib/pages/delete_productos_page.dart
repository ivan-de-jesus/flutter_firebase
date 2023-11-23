import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/firebase_service.dart'; // Importa tu servicio de Firebase aquí
import 'package:local_auth/local_auth.dart'; // Importa el paquete de autenticación local aquí

class DeleteProductsPage extends StatelessWidget {
  Future<void> _biometrico(Function deleteProducto) async {
    final LocalAuthentication _localAuthentication = LocalAuthentication();

    while (true) {
      try {
        bool authenticated = await _localAuthentication.authenticate(
          localizedReason: 'Escanea tu huella para acceder',
        );

        if (authenticated) {
          // El usuario se autenticó correctamente
          // Aquí puedes realizar acciones adicionales después de la autenticación
          deleteProducto(); // Llama a la función deleteProducto después de la autenticación
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
    // Recibe los argumentos enviados desde la página anterior
    final Producto? selectedProduct =
        ModalRoute.of(context)?.settings.arguments as Producto?;

    if (selectedProduct == null) {
      // Manejar el caso en el que los argumentos son nulos
      return Scaffold(
        appBar: AppBar(
          title: Text('Eliminar Producto'),
        ),
        body: Center(
          child: Text(
              'No se proporcionaron argumentos válidos para eliminar el producto.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar Producto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ID del Producto: ${selectedProduct.id}'),
            Text('Nombre del Producto: ${selectedProduct.name}'),
            // Agrega campos de edición u otros elementos para modificar el producto
            Text('¿Estás seguro de que deseas eliminar este producto?'),
            ElevatedButton(
              onPressed: () async {
                // Implementa la lógica para eliminar el producto aquí
                // Puedes usar una función en tu servicio de Firebase
                // para eliminar el producto de la base de datos
                // Luego, puedes regresar a la página anterior o a la página de inicio
                await _biometrico(() async {
                  await deleteProducto(selectedProduct.id);
                  Navigator.pop(context);
                  await Navigator.pushNamed(context, '/');
                });
              },
              child: Text('Eliminar Producto'),
            ),
          ],
        ),
      ),
    );
  }
}
