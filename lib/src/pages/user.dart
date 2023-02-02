import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import '../widgets/theappbar.dart';

import 'package:google_fonts/google_fonts.dart';

import '../widgets/homepage/GreetingText.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Container(
            //height: 1000,
            constraints: const BoxConstraints(maxWidth: 2000),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/trader_large.png',
                      fit: BoxFit.cover,
                      width: width,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: width * 0.05, left: width * 0.05),
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
                    ),
                  ],
                ),
                SizedBox(
                    //height: 400,
                    child: Container(
                  color: Color.fromARGB(255, 194, 204, 204),
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.05),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: width * 0.25,
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 217, 239, 240),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: <Widget>[
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Please, make sure your infomation are up to date :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Color.fromARGB(255, 0, 119, 107)),
                                ),
                              ),
                              SizedBox(height: 20),
                              const TextField(
                                decoration:
                                    InputDecoration(labelText: 'Username'),
                              ),
                              const TextField(
                                decoration: InputDecoration(labelText: 'Name'),
                              ),
                              const TextField(
                                decoration:
                                    InputDecoration(labelText: 'Password'),
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Save'),
                                style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                    backgroundColor:
                                        Color.fromARGB(255, 0, 119, 107)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 0.10 * width),
                      SizedBox(
                        width: width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            '"We value your privacy at the highest level, thus you can modify your informations at all time. Please make sure they are correct"',
                            style: GoogleFonts.varela(
                                textStyle: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
                Footer(
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
                    )),
              ],
            ),
          ),
        ));
  }
}
