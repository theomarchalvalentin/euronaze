import 'package:flutter/material.dart';
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
            height: 1000,
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
                    height: 400,
                    child: Row(
                      children: [
                        Container(
                          width: 500,
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(33, 33, 33, 33),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: <Widget>[
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Please, make sure your infomation are up to date",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
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
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
