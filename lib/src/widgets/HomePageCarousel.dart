import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_dac/src/pages/product_details_screen.dart';
import 'package:projet_dac/src/widgets/homepage/HomeSearchBar.dart';
import 'package:projet_dac/datamodel.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:widget_slider/widget_slider.dart';

class CarouselSlider extends StatelessWidget {
  CarouselSlider({
    Key? key,
    required this.products,
  }) : super(key: key);
  final List<Product> products;
  final controller =
      SliderController(duration: const Duration(milliseconds: 600));

  @override
  Widget build(BuildContext context) {
    return WidgetSlider(
      fixedSize: 300,
      controller: controller,
      infiniteScroll: true,
      pageSnapping: true,
      itemCount: listCategories.length,
      itemBuilder: (context, index, activeIndex) {
        return CupertinoButton(
          onPressed: () async => {
            await controller.moveTo?.call(index),
          },
          child: GestureDetector(
            onDoubleTap: () => Navigator.of(context).pushNamed(
                ProductScreenDetails.routeName,
                arguments: products[index]),
            child: Column(
              children: [
                Container(
                  width: 600,
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
