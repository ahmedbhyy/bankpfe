import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';

import 'package:flutter/material.dart';

import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              const AppBarCommon(title: "Privacy"),
              const SizedBox(height: 20.0),
              Image.asset("images/logobna.png", height: 180.0),
              const CommonContainerBills(
                  mywidget: Column(
                children: [
                  Text(
                    "At BNA Bank, we take your privacy and security seriously. Our mobile banking application is designed to ensure the confidentiality and protection of your personal information. We employ industry-standard encryption techniques to safeguard your data during transmission and storage. Rest assured that we do not share your information with third parties without your consent, and we continuously monitor our systems to detect and prevent any unauthorized access. Your trust is paramount to us, and we remain committed to maintaining the highest standards of privacy and security in all aspects of our services.",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color.fromARGB(255, 130, 121, 121),
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
