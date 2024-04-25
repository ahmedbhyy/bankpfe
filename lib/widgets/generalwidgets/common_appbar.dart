import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final String lottie;
  const CommonAppBar({super.key, required this.title, required this.lottie});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 27,
          color: Color.fromARGB(255, 3, 69, 54),
        ),
      ),
      title: DefaultTextStyle(
        style: GoogleFonts.mulish(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(title),
          ],
          isRepeatingAnimation: false,
          displayFullTextOnTap: true,
        ),
      ),
      actions: [
        Lottie.asset(lottie),
      ],
    );
  }
}
