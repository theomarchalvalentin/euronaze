import 'package:footer/footer.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

import 'package:projet_dac/src/widgets/homepage/charthome.dart';
import 'package:projet_dac/src/widgets/theappbar.dart';

import '../api/api.dart';
import '../api/product_model.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

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
        const SnackBar(content: Text('Unable to fetch Library')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawerScrimColor: const Color((0xff038C81)),
      appBar: CustomAppBar(),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 300,
            child: Image.asset(
              product.productImg,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.productName,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "\$${product.price}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Divider(
                          color: Color(0xFF263b5e),
                        ),
                        const SizedBox(height: 80),
                        Row(
                          children: [
                            Flexible(
                              child: Text(product.productDescription,
                                  style: GoogleFonts.varela(
                                      textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF263b5e),
                                  ))),
                            ),
                            const SizedBox(width: 100),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey.shade100),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Text("Aperçu des données:",
                                                  style: GoogleFonts.varela(
                                                      textStyle:
                                                          const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w200,
                                                    fontStyle: FontStyle.normal,
                                                    color: Color(0xFF263b5e),
                                                  ))),
                                            ),
                                            const LineChartSample2(),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BuyButton(widget.isOwned, widget.isInBasket),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Footer(
              backgroundColor: const Color(0xffd9eff0),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Projet développement d\'applications communicantes',
                    style: GoogleFonts.varela(
                        textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.normal,
                      color: Color(0xFF263b5e),
                    )),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'ENSIMAG 3A IF I2MF',
                    style: GoogleFonts.varela(
                        textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.normal,
                      color: Color(0xFF263b5e),
                    )),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Promotion 2023',
                    style: GoogleFonts.varela(
                        textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.normal,
                      color: Color(0xFF263b5e),
                    )),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Tous droits réservés',
                    style: GoogleFonts.varela(
                        textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.normal,
                      color: Color(0xFF263b5e),
                    )),
                    textAlign: TextAlign.center,
                  )
                ],
              )),
        ],
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
