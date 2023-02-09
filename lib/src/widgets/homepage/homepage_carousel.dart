import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_slider/widget_slider.dart';

import '../../api/api.dart';
import '../../models/product_model.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({
    super.key,
  });

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  final controller =
      SliderController(duration: const Duration(milliseconds: 600));
  List<Product> products = [
    const Product(0, 'productName', 'productDescription', 0, 'productImg', 0),
  ];

  @override
  void initState() {
    _getTrending();
    super.initState();
  }

  _getTrending() async {
    try {
      var results = await Api.getTrending();
      setState(() {
        // lock = false;
        products = results;
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
        const SnackBar(content: Text('Unable to fetch Trending')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WidgetSlider(
      proximity: 0.2,
      fixedSize: 300,
      controller: controller,
      infiniteScroll: true,
      pageSnapping: true,
      itemCount: products.length,
      itemBuilder: (context, index, activeIndex) {
        return CupertinoButton(
          onPressed: () async => {
            await controller.moveTo?.call(index),
          },
          child: GestureDetector(
            onDoubleTap: () =>
                context.go('/product/${products[index].productId}'),
            child: Column(
              children: [
                Container(
                  width: 300,
                  height: 200,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(products[index].productImg),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade50,
                        offset: const Offset(0, 8),
                        spreadRadius: 5,
                        blurRadius: 10,
                      ),
                      BoxShadow(
                        color: Colors.grey.shade100,
                        offset: const Offset(0, 8),
                        spreadRadius: 5,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    products[index].productName,
                    style: GoogleFonts.varela(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    )),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final List<Color> kMixedColors = [
  const Color(0xFF00776B),
  const Color(0xFF038C81),
  const Color(0xFF269D8A),
];
