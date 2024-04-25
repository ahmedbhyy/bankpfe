import 'package:bankpfe/widgets/onboarding_widgets/button_choose_lang.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ChooseLang extends StatelessWidget {
  const ChooseLang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          children: [
            Lottie.asset("images/lotties/lottie_lang.json"),
            const SizedBox(height: 30.0),
            Text(
              "Choose a Language",
              textAlign: TextAlign.center,
              style: GoogleFonts.aladin(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: const Color.fromARGB(255, 4, 154, 82),
              ),
            ),
            const SizedBox(height: 30.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonChooseLang(
                  mycolor: Color.fromARGB(255, 177, 150, 250),
                  namelang: "Frensh",
                ),
                SizedBox(width: 30.0),
                ButtonChooseLang(
                  mycolor: Color.fromARGB(255, 229, 141, 134),
                  namelang: "English",
                ),
              ],
            ),
            const SizedBox(height: 50.0),
            Image.asset(
              "images/bna.png",
              height: 70.0,
            )
          ],
        ),
      ),
    );
  }
}
