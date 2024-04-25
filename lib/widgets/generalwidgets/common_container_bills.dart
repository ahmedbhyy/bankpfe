import 'package:flutter/material.dart';

class CommonContainerBills extends StatelessWidget {
  final Widget mywidget;
  const CommonContainerBills({super.key, required this.mywidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 15.0,
      ),
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 15.0,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: mywidget,
    );
  }
}
