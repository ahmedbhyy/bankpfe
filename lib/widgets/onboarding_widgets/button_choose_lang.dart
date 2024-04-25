import 'package:bankpfe/screens/splashscreens/onboarding.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../slides/slide_right.dart';

class ButtonChooseLang extends StatelessWidget {
  final Color mycolor;
  final String namelang;

  const ButtonChooseLang(
      {super.key,
      required this.mycolor,
      required this.namelang,
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mycolor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context).push(SlideRight(page: const OnBoarding()));
        },
        elevation: 5.0,
        child: Text(
          namelang,
          style: GoogleFonts.abel(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 47, 18, 194),
          ),
        ),
      ),
    );
  }
}
