import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:uuid/uuid.dart';

import 'package:flutter_firebase/services/firebase_service.dart'; // Importa tu servicio de Firebase aquí

class AddProductsPage extends StatefulWidget {
  const AddProductsPage({Key? key}) : super(key: key);

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController offerPriceController = TextEditingController();

  Future<String> generateRandomImageUrl() async {
    final random = Random();
    final apiUrl =
        Uri.parse('https://fakestoreapi.com/products/${random.nextInt(20)}');

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final imageUrl = jsonResponse['image'];
        return imageUrl;
      } else {
        print(
            'Error al obtener el JSON. Código de estado: ${response.statusCode}');
        return 'URL no disponible';
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
      return 'Error en la solicitud HTTP';
    }
  }

  Future<void> _addProduct() async {
    String productName = '';
    String productDescription = '';
    double productPrice = 0.0;
    double productOffer = 0.0;
    bool isOnSale = false;
    bool isProductFavorite = false;

    final imageUrl = await generateRandomImageUrl();

    final context = this.context;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Agregar un nuevo producto'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      productName = value;
                    },
                    decoration:
                        InputDecoration(labelText: 'Nombre del producto'),
                  ),
                  TextField(
                    onChanged: (value) {
                      productPrice = double.tryParse(value) ?? 0.0;
                    },
                    decoration:
                        InputDecoration(labelText: 'Precio del producto'),
                  ),
                  TextField(
                    onChanged: (value) {
                      productDescription = value;
                    },
                    decoration:
                        InputDecoration(labelText: 'Descripción del producto'),
                  ),
                  Row(
                    children: [
                      Text('¿Está en oferta?'),
                      Checkbox(
                        value: isOnSale,
                        onChanged: (value) {
                          setState(() {
                            isOnSale = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  if (isOnSale)
                    TextField(
                      controller: offerPriceController,
                      onChanged: (value) {
                        productOffer = double.tryParse(value) ?? 0.0;
                      },
                      decoration:
                          InputDecoration(labelText: 'Precio de oferta'),
                    ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Agregar'),
                  onPressed: () async {
                    final imageUrl = await generateRandomImageUrl();
                    _addProductToDatabase(
                      productName,
                      productDescription,
                      productPrice,
                      productOffer,
                      isOnSale,
                      imageUrl,
                      isProductFavorite,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _addProductToDatabase(
      String name,
      String description,
      double price,
      double offerPrice,
      bool isOnSale,
      String imageUrl,
      bool isProductFavorite) {
    // Genera un ID único
    final productId = Uuid().v4();
    final productName = name;
    final productDescription = description;
    final productPrice = price;
    final productOffer = offerPrice;
    final isProductOnSale = isOnSale;
    final productImageUrl = imageUrl;
    final isFavorite = isProductFavorite; // Usar el valor proporcionado

    // Llama a la función para agregar el producto a la base de datos
    addProducto({
      'id': productId, // Agrega el ID generado
      'name': productName,
      'description': productDescription,
      'price': productPrice,
      'priceOffer': productOffer,
      'isOnSale': isProductOnSale,
      'imageUrl': productImageUrl,
      'isFavorite': isFavorite, // Usar el valor proporcionado
    });

    // Cierra el diálogo
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Producto'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _addProduct,
          child: Text('Agregar Producto'),
        ),
      ),
    );
  }
}
