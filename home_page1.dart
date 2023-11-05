import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

//Servicios
//import 'package:flutter_firebase/services/firebase_service.dart';

class Product {
  String name;
  String description;
  double price;
  bool isOnSale;
  bool isFavorite;
  String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.isOnSale,
    this.isFavorite = false,
    required this.imageUrl,
  });
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _products = data.take(3).map((data) {
          return Product(
            name: data['title'],
            description: data['description'],
            price: data['price'].toDouble(),
            isOnSale: false,
            imageUrl: data['image'], // Asegúrate de incluir la URL de la imagen
          );
        }).toList();
      });
    }
  }

  void _deleteProduct(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar Producto'),
          content: Text('¿Estás seguro de que deseas eliminar este producto?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                setState(() {
                  _products.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleFavorite(int index) {
    setState(() {
      _products[index].isFavorite = !_products[index].isFavorite;
    });
  }

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
        return 'URL no disponible'; // En lugar de retornar nulo, puedes devolver un valor predeterminado
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
      return 'Error en la solicitud HTTP'; // En lugar de retornar nulo, puedes devolver un valor predeterminado
    }
  }

  void _updateProduct(int index) {
    String updatedName = _products[index].name;
    String updatedDescription = _products[index].description;
    double updatedProductPrice = _products[index].price;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Actualizar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  updatedName = value;
                },
                controller: TextEditingController(text: _products[index].name),
                decoration:
                    InputDecoration(labelText: 'Nuevo nombre del producto'),
              ),
              TextField(
                onChanged: (value) {
                  double? parsedValue = double.tryParse(value);
                  if (parsedValue != null) {
                    updatedProductPrice = parsedValue;
                  }
                },
                controller: TextEditingController(
                    text: _products[index].price.toString()),
                decoration:
                    InputDecoration(labelText: 'Nuevo precio del producto'),
              ),
              TextField(
                onChanged: (value) {
                  updatedDescription = value;
                },
                controller:
                    TextEditingController(text: _products[index].description),
                decoration: InputDecoration(
                    labelText: 'Nueva descripción del producto'),
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
              child: Text('Actualizar'),
              onPressed: () {
                setState(() {
                  _products[index].name = updatedName;
                  _products[index].description = updatedDescription;
                  _products[index].price = updatedProductPrice;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos Firebase'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_products[index].name),
            leading: Image.network(
              _products[index].imageUrl,
              width: 100, // Ancho deseado en píxeles
              height:
                  100, // Alto deseado en píxeles// Asegúrate de que esta propiedad corresponda a la URL de la imagen en tus datos.
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    _products[index].isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  onPressed: () {
                    _toggleFavorite(index);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _deleteProduct(index);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.update,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    _updateProduct(index);
                  },
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                    height: 8), // Agrega un espacio en blanco de 8 píxeles
                Text('Descripción: ${_products[index].description}'),
                const SizedBox(
                    height: 8), // Agrega un espacio en blanco de 8 píxeles
                Text('Precio: ${_products[index].price.toStringAsFixed(2)}'),
                if (_products[index].isOnSale)
                  Text(
                    'En oferta: ${_products[index].price.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 190, 173, 15)),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        tooltip: 'Agregar producto',
        child: Icon(Icons.add),
      ),
    );
  }
}
