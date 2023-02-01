import 'package:flutter/material.dart';
import 'src/pages/HomePage.dart';
import 'src/pages/product_details_screen.dart';
import 'package:projet_dac/src/pages/user.dart';
//import 'src/pages/homepage.dart';

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
        home: const User(),
        routes: {
          ProductScreenDetails.routeName: (_) => const ProductScreenDetails(),
        });
  }
}
