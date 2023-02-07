import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:projet_dac/src/widgets/custom_footer.dart';
import 'package:projet_dac/src/widgets/homepage/homepage_carousel.dart';
import 'package:projet_dac/src/widgets/homepage/charthome.dart';
import 'package:projet_dac/src/models/datamodel.dart';
import 'package:projet_dac/src/widgets/searchbar.dart';

import '../widgets/homepage/greeting_text.dart';
import '../widgets/homepage/home_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:projet_dac/src/widgets/homepage/featured_headings.dart';

import 'package:projet_dac/src/widgets/theappbar.dart';

const List list = [
  "Flutter",
  "React",
  "Ionic",
  "Xamarin",
];

/// The Widget that configures your application.
class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});
  static const routeName = '/home';
  @override
  State<StatefulWidget> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final ScrollController _scrollController = ScrollController();

  _scrollListener() {
    setState(() {});
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(),
      //extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Image.asset(
                    'assets/images/background.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: screenSize.height * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: screenSize.width * 0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Market Data,\nmade simple.',
                                      style: GoogleFonts.varela(
                                          textStyle: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF263b5e),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'We provide you with a curated list of all the best market data and indicators to help you kickstart your business.',
                                      style: GoogleFonts.varela(
                                          textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w200,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF263b5e),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: TextButton(
                                      onPressed: () {
                                        context.go('/search');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: const Text(
                                          '  🚀 Découvrir nos produits  ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Container(
                              height: screenSize.height * 0.4,
                              child: Lottie.asset('assets/images/lottie.json',
                                  fit: BoxFit.scaleDown),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    BlurryContainer(
                      blur: 5,
                      elevation: 0,
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Text(
                        '😍 This week\'s highlights: ',
                        style: GoogleFonts.varela(
                            textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF263b5e),
                        )),
                      ),
                    ),
                    CarouselSlider(
                      products: dummyProducts,
                    ),
                  ],
                ),
              ],
            ),
            CustomFooter(),
          ],
        ),
      ),
    );
  }
}
