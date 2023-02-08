import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:footer/footer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:projet_dac/src/pages/login.dart';

import 'package:projet_dac/src/widgets/homepage/charthome.dart';
import 'package:projet_dac/src/widgets/theappbar.dart';

import '../api/api.dart';
import '../api/product_model.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import '../widgets/custom_footer.dart';
import '../widgets/product_card.dart';
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

  @override
  void initState() {
    super.initState();
    _getProduct();
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
              heightFactor: 1.2,
              child: BlurryContainer(
                blur: 5,
                elevation: 0,
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Container(
                        child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                                product.productImg,
                                fit: BoxFit.cover),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 90,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${product.productName}\n',
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade200),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Current price: ",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.005,
                                                  ),
                                                  Text(
                                                    "\$${product.price}",
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                padding:
                                                    const EdgeInsets.all(20),
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
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Text(lorem(paragraphs: 1, words: 40),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15.0)),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Container(
                                  decoration: BoxDecoration(),
                                  clipBehavior: Clip.antiAlias,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: LinePage()),
                            ],
                          )
                        ],
                      ),
                    ))),
              ),
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
