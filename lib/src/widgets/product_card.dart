import 'package:flutter/material.dart';
import 'package:projet_dac/src/models/datamodel.dart';
import 'package:go_router/go_router.dart';

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
              SizedBox(
                height: 100,
                child: Image.network(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 100,
                child: Image.network(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 100,
                child: Image.network(
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
