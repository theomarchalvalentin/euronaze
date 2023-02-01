import 'dart:html';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_dac/datamodel.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductScreenDetails extends StatelessWidget {
  static const routeName = '/product-details-screen';
  const ProductScreenDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
        appBar: AppBar(
          title: Text(product.productName),
        ),
        body: Flex(
            direction: MediaQuery.of(context).size.width >= 1000
                ? Axis.horizontal
                : Axis.vertical,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image.asset(product.productImg),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        product.productName,
                        style: GoogleFonts.varela(
                            textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w200,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF263b5e),
                        )),
                      ),
                      Text(
                        product.productDescription,
                        style: GoogleFonts.varela(
                            textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w200,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF263b5e),
                        )),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: const Text(
                            'Add to cart',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]));
  }
}
