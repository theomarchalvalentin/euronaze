import 'package:google_fonts/google_fonts.dart';
import 'package:projet_dac/src/widgets/custom_footer.dart';
import 'package:projet_dac/src/widgets/homepage/homepage_carousel.dart';
import 'package:projet_dac/src/widgets/homepage/charthome.dart';
import 'package:projet_dac/src/models/datamodel.dart';

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
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                      headingText: '🚀 Ils nous ont fait confiance :',
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
                                                " depuis le début de leur activité. Voici l'évolution de leur capital boosté par notre collaboration:"),
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
                                                      " de volatilité moyenne\n\n"),
                                              TextSpan(
                                                  text: "- β",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 30)),
                                              TextSpan(
                                                  text:
                                                      " à 1.5 : Valeur agressive\n"),
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
                  headingText: '🔥 Ce mois-ci, les investisseurs préfèrent : ',
                  screenSize: screenSize),
              CarouselSlider(),
              FeaturedHeading(
                  headingText: '🧸 C\'est le moment d\'acheter :',
                  screenSize: screenSize),
              CarouselSlider(),
              FeaturedHeading(
                  headingText: '😍 Ces catégories sont populaires :',
                  screenSize: screenSize),
              CarouselSlider(),
              const SizedBox(height: 30),
              const CustomFooter(),
            ],
          ),
        ]),
      ),
    );
  }
}
