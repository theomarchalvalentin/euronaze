import 'package:flutter/material.dart';
import 'package:projet_dac/src/pages/user.dart';
import 'package:projet_dac/src/widgets/searchbar.dart';
import 'package:projet_dac/src/pages/home_page.dart';
import 'src/pages/product_details_screen.dart';
import 'package:projet_dac/src/pages/login.dart';

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
        home: const LoginPage(),
        routes: {
          LoginPage.routeName: (_) => const LoginPage(),
          HomePage.routeName: (_) => const HomePage(),
          UserPage.routeName: (_) => const UserPage(),
          ProductScreenDetails.routeName: (_) => const ProductScreenDetails(),
          SearchPage.routeName: (_) => SearchPage(),
        });
  }
}
