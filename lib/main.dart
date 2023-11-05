import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//Pages
import 'pages/home_page.dart';
import 'pages/add_productos_page.dart';
import 'pages/edit_productos_page.dart';
import 'pages/delete_productos_page.dart';
import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      initialRoute: '/login',
      routes: {
        '/': (context) => const Home(),
        '/login': (context) => LoginPage(),

        '/add': (context) => const AddProductsPage(),
        //'/edit': (context) => const EditProductsPage(),
        '/edit': (context) => EditProductsPage(),
        '/delete': (context) => DeleteProductsPage(),
      },
    );
  }
}
