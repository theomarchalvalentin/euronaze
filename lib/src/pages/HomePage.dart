import 'dart:html';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_dac/src/widgets/HomePageCarousel.dart';
import 'package:projet_dac/src/widgets/homepage/charthome.dart';
import 'package:projet_dac/datamodel.dart';

import '../widgets/homepage/GreetingText.dart';
import '../widgets/homepage/HomeSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:projet_dac/src/widgets/homepage/FeaturedHeadings.dart';
import 'package:projet_dac/src/widgets/homepage/FeaturedTiles.dart';

import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

const List list = [
  "Flutter",
  "React",
  "Ionic",
  "Xamarin",
];

/// The Widget that configures your application.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(children: [
          SizedBox(
            width: screenSize.width,
            height: screenSize.height * 0.45,
            child:
                Image.asset('assets/images/quotes.png.png', fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Column(
                children: [
                  GreetingText(screenSize: screenSize),
                  SizedBox(height: screenSize.height / 3.5),
                  FeaturedHeadingCentered(
                      screenSize: screenSize,
                      headingText: 'De quoi avez-vous besoin aujourd\'hui?'),
                  const SizedBox(height: 50),
                  HomeSearchBar(screenSize: screenSize),
                  FeaturedHeading(
                      headingText: '???? Ils nous ont fait confiance :',
                      screenSize: screenSize),
                  const SizedBox(height: 50),
                ],
              ),
              Material(
                color: const Color(0xffd9eff0),
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        SizedBox(
                            width: screenSize.width * 0.45,
                            child: const LineChartSample2()),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(70.0),
                            child: Column(
                              children: [
                                RichText(
                                  textAlign: TextAlign.right,
                                  text: const TextSpan(
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w200,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF263b5e),
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "Nous sommes partenaires d'"),
                                        TextSpan(
                                            text: "Alameda Research & co.",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                            )),
                                        TextSpan(
                                            text:
                                                " depuis le d??but de leur activit??. Voici l'??volution de leur capital boost?? par notre collaboration:"),
                                      ]),
                                ),
                                const SizedBox(height: 30),
                                Column(children: [
                                  Material(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white54,
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      child: RichText(
                                        textAlign: TextAlign.right,
                                        text: const TextSpan(
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w200,
                                              fontStyle: FontStyle.normal,
                                              color: Color(0xFF263b5e),
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: "- +20%",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 30)),
                                              TextSpan(
                                                  text:
                                                      " de retour par rapport au mois dernier\n\n"),
                                              TextSpan(
                                                  text: "- 5%",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 30)),
                                              TextSpan(
                                                  text:
                                                      " de volatilit?? moyenne\n\n"),
                                              TextSpan(
                                                  text: "- ??",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 30)),
                                              TextSpan(
                                                  text:
                                                      " ?? 1.5 : Valeur agressive\n"),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ]),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(50.0),
                                    child: Text(
                                      "This stock is great. I like this stock. This stock is the best stock ever. This stock is great. I like this stock. This stock is the best stock ever. This stock is great. I like this stock. This stock is the best stock ever.",
                                      style: GoogleFonts.varela(
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              FeaturedHeading(
                  headingText: '???? Ce mois-ci, les investisseurs pr??f??rent : ',
                  screenSize: screenSize),
              CarouselSlider(
                products: dummyProducts,
              ),
              FeaturedHeading(
                  headingText: '???? C\'est le moment d\'acheter :',
                  screenSize: screenSize),
              CarouselSlider(
                products: dummyProducts,
              ),
              FeaturedHeading(
                  headingText: '???? Ces cat??gories sont populaires :',
                  screenSize: screenSize),
              CarouselSlider(
                products: dummyProducts,
              ),
              const SizedBox(height: 30),
              Footer(
                  backgroundColor: const Color(0xffd9eff0),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Projet d??veloppement d\'applications communicantes',
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
                        'Tous droits r??serv??s',
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
        ]),
      ),
    );
  }
}
