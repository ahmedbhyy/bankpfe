import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarCommon extends StatelessWidget {
  final String title;

  const AppBarCommon({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Navigator.of(context).canPop()
                ? IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  )
                : Container(),
            Text(
              title,
              style: GoogleFonts.mulish(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
        Image.asset(
          "images/bna.png",
          width: 75.0,
        ),
      ],
    );
  }
}
