import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Footer(
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
        ));
  }
}
