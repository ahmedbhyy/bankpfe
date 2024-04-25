import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../slides/slide_right.dart';

class ContainerListTile extends StatelessWidget {
  final Widget mypage;
  final String title;
  final String mysubtitle;
  final String myimage;
  const ContainerListTile({super.key, required this.mypage, required this.title, required this.mysubtitle, required this.myimage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          SlideRight(page: mypage),
        );
      },
      child: Container(
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
          title: Text(
            title
          ),
          titleTextStyle: GoogleFonts.mulish(
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          subtitle: Text(
            mysubtitle,
          ),
          trailing: Image.asset(
          myimage
          ),
        ),
      ),
    );
  }
}
