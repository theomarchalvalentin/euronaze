import 'package:flutter/material.dart';
import 'src/pages/HomePage.dart';
import 'src/pages/product_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Web',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: {
          ProductScreenDetails.routeName: (_) => const ProductScreenDetails(),
        });
  }
}
