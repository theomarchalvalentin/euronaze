import 'package:flutter/material.dart';

const Color textcolor = Color.fromARGB(255, 4, 138, 129);
const Color boxcolor = Color.fromARGB(52, 8, 246, 246);

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: textcolor),
          borderRadius: const BorderRadius.all(Radius.circular(15.0))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: SizedBox(
          width: screenSize.width / 3,
          height: 50,
          child: Row(
            children: [
              Container(
                width: 5 / 6 * screenSize.width / 3,
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'GOOGL, Tesla, pétrole, ...',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w200,
                        color: textcolor),
                  ),
                ),
              ),
              const Expanded(child: Icon(Icons.search, color: textcolor)),
            ],
          ),
        ),
      ),
    );
  }
}
