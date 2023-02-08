import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    int id = product.productId;
    return GestureDetector(
      onTap: () => context.go('/product/$id'),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  height: 100,
                  product.productImg,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
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
                ),
              ),
              const SizedBox(
                width: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OwnedProductCard extends StatelessWidget {
  final Product product;

  const OwnedProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    int id = product.productId;
    return GestureDetector(
      onTap: () => context.go('/product/$id'),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                  product.productImg,
                ),
              ),
              const Spacer(),
              CategoryTag(product.categoryId),
              const Spacer(),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FittedBox(
                        child: Text(
                          product.productName,
                          style: GoogleFonts.varela(
                              textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF263b5e),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FittedBox(
                        child: Text(
                          "\$${product.price}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 40),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BasketProductCard extends StatelessWidget {
  final Product product;

  const BasketProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    int id = product.productId;
    return GestureDetector(
      onTap: () => context.go('/product/$id'),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                  product.productImg,
                ),
              ),
              const Spacer(),
              CategoryTag(product.categoryId),
              const Spacer(),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FittedBox(
                        child: Text(
                          product.productName,
                          style: GoogleFonts.varela(
                              textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF263b5e),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FittedBox(
                        child: Text(
                          "\$${product.price}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () => {},
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget CategoryTag(int categoryId) {
  var color = const Color(0xFFFFFFFF).withOpacity(0.6);
  var cat = 'None';
  switch (categoryId) {
    case 1:
      cat = 'Stocks';
      color = const Color(0xffffdfba).withOpacity(0.6);
      break;
    case 2:
      cat = 'FX';
      color = const Color(0xffffffba).withOpacity(0.6);

      break;
    case 3:
      cat = 'Fixed Income';
      color = const Color(0xffbaffc9).withOpacity(0.6);

      break;
    case 4:
      cat = 'Indexes';
      color = const Color(0xffbae1ff).withOpacity(0.6);

      break;
  }
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: color,
    ),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        cat,
        style: GoogleFonts.varela(
            textStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          color: Color(0xFF263b5e),
        )),
      ),
    ),
  );
}
