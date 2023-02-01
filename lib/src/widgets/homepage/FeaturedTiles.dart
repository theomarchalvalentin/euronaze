import 'package:flutter/material.dart';
import 'responsive.dart';

class FeaturedTiles extends StatelessWidget {
  const FeaturedTiles({
    Key? key,
    required this.screenSize,
    required this.assetsImages,
    required this.assetsNames,
  }) : super(key: key);

  final Size screenSize;
  final List<String> assetsImages;
  final List<String> assetsNames;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return Padding(
        padding: EdgeInsets.only(top: screenSize.height / 50),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 100),
              ...Iterable<int>.generate(assetsNames.length).map(
                (int pageIndex) => Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: SizedBox(
                            height: screenSize.width / 2.5,
                            width: screenSize.width / 1.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset(
                                assetsImages[pageIndex],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenSize.height / 70,
                          ),
                          child: Text(
                            assetsNames[pageIndex],
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.06,
          left: screenSize.width / 15,
          right: screenSize.width / 15,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...Iterable<int>.generate(assetsImages.length).map(
                (int pageIndex) => Column(
                  children: [
                    SizedBox(
                      height: screenSize.width / 6,
                      width: screenSize.width / 3.8,
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  assetsImages[pageIndex],
                                  // fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 550,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenSize.height / 70,
                      ),
                      child: Text(
                        assetsNames[pageIndex],
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

final List<String> bullAssetsImages = [
  'assets/images/teslajpg.jpg',
  'assets/images/Dogecoin_logo.jpg',
  'assets/images/isharespng.png',
  'assets/images/euronaze.png',
];

final List<String> bullAssetsNames = [
  'Tesla',
  'Dogecoin',
  'iShares',
  'Euronaze',
];

final List<String> bearAssetsImages = [
  'assets/images/ftx.jpg',
  'assets/images/creditsuisse.png',
  'assets/images/pfizer.png',
  'assets/images/renault.jpg',
];

final List<String> bearAssetsNames = [
  'FTX Token',
  'Crédit Suisse',
  'Pfizer',
  'Renault',
];
