import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyLottie extends StatelessWidget {
  final String mylottie;
  final double lottieheight;
  final bool isrepeated;
  const MyLottie(
      {super.key, required this.mylottie, required this.lottieheight, required this.isrepeated});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      mylottie,
      height: lottieheight,
      repeat: isrepeated,
    );
  }
}
