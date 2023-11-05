import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Producto {
  final String id; // El campo 'id' ahora es opcional
  final String name;
  final String description;
  final double price;
  final double priceOffer;
  final bool isOnSale;
  final String imageUrl;
  final bool isFavorite;

  Producto({
    required this.name,
    required this.description,
    required this.price,
    required this.priceOffer,
    required this.isOnSale,
    required this.imageUrl,
    required this.isFavorite,
    this.id =
        '', // El campo 'id' es opcional y se inicializa como una cadena vacía
  });
}

//Leer Base de datos
Future<List<Producto>> getProductos() async {
  List<Producto> productos = [];
  CollectionReference collectionReferenceProductos = db.collection('Productos');

  QuerySnapshot queryProductos = await collectionReferenceProductos.get();
  queryProductos.docs.forEach((documento) {
    final data = documento.data();
    if (data != null) {
      Map<String, dynamic> productData = data as Map<String, dynamic>;
      Producto producto = Producto(
        id: documento
            .id, // Asigna el ID del documento como parte del objeto Producto
        name: productData['name'],
        description: productData['description'],
        price: productData['price'].toDouble(),
        priceOffer: productData['priceOffer'].toDouble(),
        isOnSale: productData['isOnSale'],
        imageUrl: productData['imageUrl'],
        isFavorite: productData['isFavorite'],
      );
      productos.add(producto);
    }
  });

  return productos;
}

//Guardar
Future<void> addProducto(Map<String, dynamic> productData) async {
  await db.collection('Productos').add(productData);
}

//Actualizar
Future<void> updateProducto(
    String productId, Map<String, dynamic> productData) async {
  await db.collection('Productos').doc(productId).update(productData);
}

Future<Producto?> getProductoById(String productId) async {
  try {
    DocumentSnapshot document =
        await db.collection('Productos').doc(productId).get();
    if (document.exists) {
      final data = document.data();
      if (data != null) {
        Map<String, dynamic> productData = data as Map<String, dynamic>;
        return Producto(
          name: productData['name'],
          description: productData['description'],
          price: productData['price'].toDouble(),
          priceOffer: productData['priceOffer'].toDouble(),
          isOnSale: productData['isOnSale'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        );
      }
    }
  } catch (e) {
    print('Error al obtener el producto por ID: $e');
  }
  return null;
}

//eliminar
// Elimina una colección completa en Firestore
Future<void> deleteProducto(String uid) async {
  await db.collection('Productos').doc(uid).delete();
}
