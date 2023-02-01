import 'dart:html';
import 'package:flutter/rendering.dart';
import 'package:footer/footer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_dac/datamodel.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:projet_dac/src/widgets/homepage/charthome.dart';
import 'package:projet_dac/src/widgets/theappbar.dart';

class ProductScreenDetails extends StatelessWidget {
  static const routeName = '/product-details-screen';
  const ProductScreenDetails({super.key});
  @override
  Widget build(BuildContext context) {
    final sizeOfScreen = MediaQuery.of(context).size;

    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    // return Scaffold(
    //     extendBodyBehindAppBar: true,
    //     backgroundColor: Colors.white,
    //     appBar: AppBar(
    //       backgroundColor: const Color(0xff00776B),
    //       title: Text(product.productName),
    //     ),
    //     body: SingleChildScrollView(
    //       child: Column(children: [
    //         SizedBox(
    //           height: sizeOfScreen.height * 0.45,
    //           // width: sizeOfScreen.width * 0.3,
    //           child: Image.asset(
    //             product.productImg,
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(80.0),
    //           child: Container(
    //             decoration: const BoxDecoration(
    //                 color: Color(0xffD9EFF0),
    //                 borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(15.0),
    //                     topRight: Radius.circular(15.0))),
    //             child: Column(
    //               children: [
    //                 Text(
    //                   product.productName,
    //                   style: GoogleFonts.varela(
    //                       textStyle: const TextStyle(
    //                     fontSize: 35,
    //                     fontWeight: FontWeight.w200,
    //                     fontStyle: FontStyle.normal,
    //                     color: Color(0xFF263b5e),
    //                   )),
    //                 ),
    //                 SizedBox(height: sizeOfScreen.height / 5),
    //                 Text(
    //                   product.productDescription,
    //                   style: GoogleFonts.varela(
    //                       textStyle: const TextStyle(
    //                     fontSize: 25,
    //                     fontWeight: FontWeight.w400,
    //                     fontStyle: FontStyle.normal,
    //                     color: Color(0xFF263b5e),
    //                   )),
    //                 ),
    //                 TextButton(
    // onPressed: () {},
    // child: Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     color: Colors.green,
    //   ),
    //   padding: const EdgeInsets.symmetric(
    //       vertical: 5, horizontal: 10),
    //   child: const Text(
    //     'Add to cart',
    //     style: TextStyle(color: Colors.white, fontSize: 13.0),
    //   ),
    // ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ]),
    //     ));

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawerScrimColor: const Color((0xff038C81)),
      appBar: CustomAppBar(),
      body: ListView(
        children: <Widget>[
          Container(
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
                        SizedBox(height: 80),
                        const Divider(
                          color: Color(0xFF263b5e),
                        ),
                        SizedBox(height: 80),
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
                                            LineChartSample2(),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: 150,
                          child: TextButton(
                            onPressed: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade100,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: const Text(
                                '🛒 Add to cart',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                              ),
                            ),
                          ),
                        )
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
