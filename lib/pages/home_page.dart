import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/firebase_service.dart'; // Importa tu servicio de Firebase aquí

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos Firebase'),
      ),
      body: FutureBuilder(
        future: getProductos(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final producto = snapshot.data?[index] as Producto;

                final isOnSale = producto.isOnSale;
                final price = producto.price;
                final priceOffer = producto.priceOffer;

                // Define un estilo para el precioOffer en amarillo
                TextStyle priceOfferTextStyle = TextStyle(
                  color: Colors.amber,
                );

                // Define un estilo para el precio en rojo con tachado
                TextStyle priceTextStyle = TextStyle(
                  decoration: isOnSale ? TextDecoration.lineThrough : null,
                );

                return ListTile(
                  title: Container(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      producto.name,
                    ),
                  ),
                  leading: Image.network(
                    producto.imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Descripción: ${producto.description}"),
                      SizedBox(
                          height:
                              8.0), // Agrega un espacio después de la descripción
                      Text(
                        "Precio: ${price.toStringAsFixed(2)}",
                        style: priceTextStyle,
                      ),
                      if (isOnSale)
                        Text(
                          "Precio de oferta: ${priceOffer.toStringAsFixed(2)}",
                          style: priceOfferTextStyle,
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          producto.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        onPressed: () {
                          // Aquí puedes agregar la lógica para marcar/desmarcar como favorito
                          // por ejemplo, actualizando el campo isFavorite en la base de datos.
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          final selectedProductDelete =
                              snapshot.data?[index] as Producto;
                          // Agregar lógica para eliminar el producto
                          Navigator.pushNamed(context, '/delete',
                              arguments: selectedProductDelete);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.update, color: Colors.blue),
                        onPressed: () {
                          final selectedProduct =
                              snapshot.data?[index] as Producto;
                          Navigator.pushNamed(
                            context,
                            '/edit',
                            arguments: selectedProduct,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No se encontraron datos en la base de datos.'),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        tooltip: 'Agregar producto',
        child: Icon(Icons.add),
      ),
    );
  }
}
