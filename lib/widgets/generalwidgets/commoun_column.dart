import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonColumnCategories extends StatelessWidget {
  final String categorie;
  final bool isactive;
  final Widget myicon;
  final void Function() onPressed;
  const CommonColumnCategories(
      {super.key,
      required this.categorie,
      required this.isactive,
      required this.onPressed,
      required this.myicon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: isactive
                  ? const Color(0xff00aa86)
                  : const Color.fromARGB(255, 195, 187, 187),
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: myicon,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            categorie,
            style: GoogleFonts.abel(
              fontSize: 17.0,
              fontWeight: isactive ? FontWeight.bold : FontWeight.normal,
              color: isactive
                  ? const Color.fromARGB(255, 1, 3, 16)
                  : const Color.fromARGB(255, 107, 102, 102),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: 2.0,
            margin: const EdgeInsets.only(top: 5.0),
            width: isactive ? 20.0 : 6.0,
            decoration: BoxDecoration(
              color: isactive
                  ? const Color(0xff00aa86)
                  : const Color.fromARGB(255, 195, 187, 187),
            ),
          )
        ],
      ),
    );
  }
}
