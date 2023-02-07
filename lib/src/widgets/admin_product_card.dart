import 'package:flutter/material.dart';
import 'package:projet_dac/src/models/datamodel.dart';
import 'package:go_router/go_router.dart';

class AdminProductCard extends StatelessWidget {
  final Product product;

  const AdminProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    int id = product.productId;
    return GestureDetector(
      onTap: () => context.go('/modifyproduct/$id'),
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
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
