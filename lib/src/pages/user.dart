import 'package:flutter/material.dart';
import '../widgets/theappbar.dart';

import 'package:google_fonts/google_fonts.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 500,
                child: Stack(
                  children: <Widget>[
                    Transform.scale(
                      scale: 1.2,
                      child: Image.asset('assets/images/trader_large.png'),
                    ),
                    Center(
                      widthFactor: 1.8,
                      heightFactor: 4,
                      child: Text(
                        "Your informations are safe, \n here",
                        style: GoogleFonts.varela(
                            textStyle: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 1000,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 500,
                        child: Container(
                            color: Color.fromARGB(33, 33, 33, 33),
                            child: Text("hello")),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
