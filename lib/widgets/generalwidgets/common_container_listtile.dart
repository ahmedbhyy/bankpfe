import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../slides/slide_right.dart';

class ContainerListTile extends StatelessWidget {
  final Widget mypage;
  final bool ispayed;
  final String title;
  final String mysubtitle;
  final String myimage;
  final void Function()? myfunction;
  const ContainerListTile(
      {super.key,
      required this.mypage,
      required this.title,
      required this.mysubtitle,
      required this.myimage,
      this.myfunction,
      required this.ispayed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          SlideRight(page: mypage),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 70, 63, 63),
                  blurRadius: 4.0,
                )
              ],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
            ),
            alignment: Alignment.center,
            child: ListTile(
              title: Text(title),
              titleTextStyle: GoogleFonts.mulish(
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              subtitle: Text(
                mysubtitle,
              ),
              trailing: ispayed
                  ? Lottie.asset(
                      "images/lotties/lottie_arrow.json",
                      height: 35.0,
                      repeat: false,
                    )
                  : Container(
                      width: 65.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: const Color(0xff00aa86),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: MaterialButton(
                        onPressed: myfunction,
                        elevation: 5.0,
                        child: const Text(
                          "Pay",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          Positioned(
            right: 1.0,
            top: -10.0,
            child: Image.asset(
              myimage,
              height: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}
