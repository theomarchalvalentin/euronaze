import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_dac/src/models/datamodel.dart';

import '../pages/product_details_screen.dart';

class SearchPage extends StatefulWidget {
  final List<Product> products = dummyProducts;
  static const routeName = '/search';
  SearchPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = widget.products;
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = widget.products
          .where((product) =>
              product.productName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 140, 129),
        elevation: 0.0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        leadingWidth: 200,
        leading: InkWell(
          onTap: () {
            Navigator.maybePop(context);
          },
          child: Row(children: [
            const SizedBox(width: 20),
            Image.asset(
              'assets/images/Euronext_logo.png',
              height: 60,
            ),
            const SizedBox(width: 10),
            Text("Euronaze",
                style: GoogleFonts.bebasNeue(
                  textStyle: const TextStyle(
                      fontSize: 30,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                )),
          ]),
        ),
        title: TextField(
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search products',
            hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => _searchController.clear(),
            ),
          ),
          onChanged: (value) => _filterProducts(value),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: _filteredProducts.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: _filteredProducts[index],
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(ProductScreenDetails.routeName, arguments: product),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 100,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Image.network(
                    product.productImg,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      product.productName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
