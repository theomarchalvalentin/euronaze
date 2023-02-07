import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_dac/src/pages/admin_modify.dart';
import 'package:projet_dac/src/pages/CartPage.dart';
import 'package:projet_dac/src/pages/admin_search.dart';
import 'package:projet_dac/src/pages/library.dart';
import 'package:projet_dac/src/pages/user.dart';
//import 'package:projet_dac/src/widgets/searchbar.dart';
import 'package:projet_dac/src/pages/home_page.dart';
import 'src/pages/product_details_screen.dart';
import 'package:projet_dac/src/pages/login.dart';

import 'package:projet_dac/src/pages/admin_add.dart';
import 'package:projet_dac/src/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Web',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/user',
      builder: (context, state) => const UserPage(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: '/library',
      builder: (context, state) => const LibraryPage(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartPage(),
    ),
    //
    GoRoute(
        path: '/product/:productId',
        builder: (context, state) =>
            ProductScreenDetails(productId: state.params['productId']!)),
    GoRoute(
      path: '/searchtomodify',
      builder: (context, state) => const AdminSearch(),
    ),
    GoRoute(
      path: '/addproduct',
      builder: (context, state) => const AdminAdd(),
    ),
    GoRoute(
        path: '/modifyproduct/:productId',
        builder: (context, state) =>
            AdminModify(productId: state.params['productId']!)),
  ],
);
