import 'package:flutter/material.dart';

class ContainerSettings extends StatelessWidget {
  final Widget mywidget;
  final String mytext;
  final Icon myicon;
  const ContainerSettings(
      {super.key, required this.mywidget, required this.mytext, required this.myicon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color.fromARGB(255, 239, 232, 232),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
             myicon,
              const SizedBox(width: 10.0),
              Text(
                mytext,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Color.fromARGB(255, 46, 68, 79),
                ),
              ),
            ],
          ),
          mywidget,
        ],
      ),
    );
  }
}
