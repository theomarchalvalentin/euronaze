import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedHeading extends StatelessWidget {
  final String headingText;

  const FeaturedHeading({
    Key? key,
    required this.screenSize,
    required this.headingText,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize.height * 0.06,
        left: screenSize.width / 15,
        right: screenSize.width / 15,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            headingText,
            style: GoogleFonts.varela(
                textStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.normal,
              color: Color(0xFF263b5e),
            )),
          )
        ],
      ),
    );
  }
}

class FeaturedHeadingCentered extends StatelessWidget {
  final String headingText;

  const FeaturedHeadingCentered({
    Key? key,
    required this.screenSize,
    required this.headingText,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.06,
          left: screenSize.width / 15,
          right: screenSize.width / 15,
        ),
        child: Flexible(
          child: Text(
            headingText,
            style: GoogleFonts.varela(
                textStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.normal,
              color: Color(0xFF263b5e),
            )),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
