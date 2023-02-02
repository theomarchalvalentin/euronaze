import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_dac/src/widgets/searchbar.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({super.key}) : preferredSize = const Size.fromHeight(80.0);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 3, 140, 129),
      elevation: 0.0,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      leadingWidth: 200,
      leading: InkWell(
        onTap: () {
          Navigator.maybePop(context);
        },
        child: Row(children: [
          const SizedBox(width: 20),
          Image.asset(
            'assets/images/Euronext_logo.png',
            height: 60,
          ),
          const SizedBox(width: 10),
          Text("Euronaze",
              style: GoogleFonts.bebasNeue(
                textStyle: const TextStyle(
                    fontSize: 30,
                    letterSpacing: 1,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              )),
        ]),
      ),
      actions: <Widget>[
        IconButton(
          iconSize: 45,
          icon: const Icon(
            Icons.manage_accounts_outlined,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 45,
          icon: const Icon(
            Icons.download_outlined,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 45,
          icon: const Icon(
            Icons.search_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(SearchPage.routeName);
          },
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 45,
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
