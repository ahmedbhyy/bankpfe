import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CardDonations extends StatelessWidget {
  final String myimage;
  final String mytitle;
  final double myamount;
  final double estimateamount;
  final int mydays;
  final String bywho;
  const CardDonations(
      {super.key,
      required this.myimage,
      required this.mytitle,
      required this.myamount,
      required this.mydays,
      required this.bywho,
      required this.estimateamount});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Hero(
              tag: myimage,
              child: CachedNetworkImage(
                imageUrl: myimage,
                height: 110,
                width: 250.0,
                fit: BoxFit.fill,
                placeholder: (context, url) => Lottie.asset(
                  "images/lotties/lottie_loading2.json",
                  height: 100.0,
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 5.0,
              left: 5.0,
              top: 5.0,
            ),
            child: Row(
              children: [
                const Text(
                  "By",
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color.fromARGB(255, 237, 0, 0),
                  ),
                ),
                Text(
                  " $bywho",
                  style: GoogleFonts.mulish(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 3, 98, 32),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              top: 5.0,
              left: 10.0,
            ),
            child: SizedBox(
              height: 50.0,
              child: Text(
                mytitle,
                style: GoogleFonts.mulish(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
          SliderTheme(
            data: const SliderThemeData(
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
            ),
            child: Slider(
              value: myamount,
              max: estimateamount,
              activeColor: const Color(0xff00aa86),
              onChanged: (double value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
              left: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$myamount TND",
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 105, 100, 100),
                  ),
                ),
                Text(
                  " $mydays days left",
                  style: GoogleFonts.mulish(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 154, 146, 146),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 9.0,
          ),
          Center(
            child: Container(
              height: 20,
              alignment: Alignment.center,
              width: 100,
              decoration: BoxDecoration(
                color: const Color(0xff00aa86),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                "Donate",
                style: GoogleFonts.mulish(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 242, 230, 230),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
