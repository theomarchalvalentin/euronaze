import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../api/api.dart';

class AdminAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  AdminAppBar({super.key}) : preferredSize = const Size.fromHeight(80.0);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 3, 140, 129),
      elevation: 0.0,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      leadingWidth: 250,
      leading: InkWell(
        onTap: () {
          context.go('/adminadd');
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
            Icons.add_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            context.go('/addproduct');
          },
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 45,
          icon: const Icon(
            Icons.edit_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            context.go('/modifyproduct/1');
          },
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 45,
          icon: const Icon(
            Icons.create_new_folder_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            context.go('/search');
          },
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 45,
          icon: const Icon(
            Icons.logout_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            try {
              Api.logout();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error during Logout')),
              );
            }
            context.go('/');
          },
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
