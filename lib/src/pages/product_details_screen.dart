import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import 'package:projet_dac/src/widgets/theappbar.dart';

import '../api/api.dart';
import '../api/product_model.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import '../widgets/custom_footer.dart';
import 'chart.dart';

class ProductScreenDetails extends StatefulWidget {
  static const routeName = '/product';
  const ProductScreenDetails({super.key, required this.productId});
  final int productId;

  final bool isOwned = false;
  final bool isInBasket = false;

  @override
  State<ProductScreenDetails> createState() => _ProductScreenDetailsState();
}

class _ProductScreenDetailsState extends State<ProductScreenDetails> {
  late Product product = Product(
      0,
      "productName",
      lorem(paragraphs: 4, words: 200),
      0,
      "assets/images/productnotfound.png",
      0);
  late List<double> data = [1.0, 2.0];
  @override
  void initState() {
    super.initState();
    _getProduct();
    _getData();
  }

  _getProduct() async {
    try {
      var result = await Api.getProduct(widget.productId);
      setState(() {
        // lock = false;
        product = result;
      });
    } on NoTokenExeption {
      setState(() {
        // lock = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No token found, please log again')),
      );
    } catch (e) {
      setState(() {
        // lock = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to fetch Product')),
      );
    }
  }

  _getData() async {
    try {
      List<double> result = await Api.getData(widget.productId);
      setState(() {
        // lock = false;
        data = result;
      });
    } on NoTokenExeption {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No token found, please log again')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to fetch Product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawerScrimColor: const Color((0xff038C81)),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Center(
              heightFactor: 1.15,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(product.productImg),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '${product.productName}\n',
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade200),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Current price: ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                          ),
                                          Text(
                                            "\$${product.price}",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black,
                                        ),
                                        padding: const EdgeInsets.all(20),
                                        child: const Text(
                                          'Buy now',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black),
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Details',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Text(lorem(paragraphs: 1, words: 40),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15.0)),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              clipBehavior: Clip.antiAlias,
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: LinePage(data: data),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }
}

Widget BuyButton(bool isOwned, bool isInBasket) {
  if (!isInBasket) {
    if (!isOwned) {
      return Center(
        child: TextButton(
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: const Text(
              '🛒 Add to cart',
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ),
        ),
      );
    }
    return const Center(
      child: Text(
        'Vous possédez déjà ce produit',
        style: TextStyle(color: Colors.black, fontSize: 20.0),
      ),
    );
  }
  return const Center(
      child: Text(
    'Ce produit est déja dans votre panier',
    style: TextStyle(color: Colors.black, fontSize: 20.0),
  ));
}
