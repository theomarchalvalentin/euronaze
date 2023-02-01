import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({
    Key? key,
    required this.screenSize,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Bonjour,',
            style: GoogleFonts.varela(
                textStyle: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            )),
          ),
          Text(
            'Théo',
            style: GoogleFonts.varela(
                textStyle: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            )),
          ),
        ],
      ),
    );
  }
}
