import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/firebase_service.dart';

class EditProductsPage extends StatefulWidget {
  const EditProductsPage({Key? key}) : super(key: key);

  @override
  _EditProductsPageState createState() => _EditProductsPageState();
}

class _EditProductsPageState extends State<EditProductsPage> {
  String productName = '';
  String productDescription = '';
  double productPrice = 0.0;
  double productOffer = 0.0;
  bool isOnSale = false;
  bool isProductFavorite = false;
  String imageUrl = "";

  bool tempIsOnSale = false;
  bool tempIsProductFavorite = false;

  @override
  Widget build(BuildContext context) {
    // Recupera el objeto Producto enviado como argumento
    final selectedProduct =
        ModalRoute.of(context)!.settings.arguments as Producto;

    print('ID del Producto en la página de edición: ${selectedProduct.id}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Producto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ID del Producto: ${selectedProduct.id}'),
            Text('Nombre del Producto: ${selectedProduct.name}'),
            // Agrega campos de edición u otros elementos para modificar el producto
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Inicializa las variables con los valores actuales de selectedProduct
          productName = selectedProduct.name;
          productDescription = selectedProduct.description;
          productPrice = selectedProduct.price;
          productOffer = selectedProduct.priceOffer;
          tempIsOnSale = selectedProduct.isOnSale;
          tempIsProductFavorite = selectedProduct.isFavorite;
          imageUrl = selectedProduct.imageUrl;

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Editar Producto'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: TextEditingController(text: productName),
                      onChanged: (value) {
                        setState(() {
                          productName = value;
                        });
                      },
                      decoration:
                          InputDecoration(labelText: 'Nombre del producto'),
                    ),
                    TextField(
                      controller:
                          TextEditingController(text: productPrice.toString()),
                      onChanged: (value) {
                        setState(() {
                          productPrice = double.tryParse(value) ?? 0.0;
                        });
                      },
                      decoration:
                          InputDecoration(labelText: 'Precio del producto'),
                    ),
                    TextField(
                      controller:
                          TextEditingController(text: productDescription),
                      onChanged: (value) {
                        setState(() {
                          productDescription = value;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Descripción del producto'),
                    ),
                    Row(
                      children: [
                        Text('¿Está en oferta?'),
                        Checkbox(
                          value: tempIsOnSale,
                          onChanged: (value) {
                            setState(() {
                              tempIsOnSale = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                    if (tempIsOnSale)
                      TextField(
                        controller: TextEditingController(
                            text: productOffer.toString()),
                        onChanged: (value) {
                          setState(() {
                            productOffer = double.tryParse(value) ?? 0.0;
                          });
                        },
                        decoration:
                            InputDecoration(labelText: 'Precio de oferta'),
                      ),
                    Row(
                      children: [
                        Text('¿Es tu favorito?'),
                        Checkbox(
                          value: tempIsProductFavorite,
                          onChanged: (value) {
                            setState(() {
                              tempIsProductFavorite = value ?? false;
                            });
                          },
                        ),
                      ],
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
                    child: Text('Guardar'),
                    onPressed: () async {
                      // Crea un nuevo objeto Producto con los datos del formulario
                      final updatedProduct = Producto(
                        id: selectedProduct.id,
                        name: productName,
                        description: productDescription,
                        price: productPrice,
                        priceOffer: productOffer,
                        isOnSale: tempIsOnSale,
                        imageUrl: imageUrl,
                        isFavorite: tempIsProductFavorite,
                      );

                      Map<String, dynamic> productoData = {
                        'name': updatedProduct.name,
                        'description': updatedProduct.description,
                        'price': updatedProduct.price,
                        'isOnSale': updatedProduct.isOnSale,
                        'priceOffer': updatedProduct.priceOffer,
                        'imageUrl': updatedProduct.imageUrl,
                        'isFavorite': updatedProduct.isFavorite,
                      };

                      await updateProducto(selectedProduct.id, productoData);

                      Navigator.of(context).pop();
                      await Navigator.pushNamed(context, '/');
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
