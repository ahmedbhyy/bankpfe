import 'package:bankpfe/controllers/start_controller.dart';
import 'package:bankpfe/functions/alert_exit.dart';
//import 'package:bankpfe/functions/alert_exit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StartControllerImp());
    return GetBuilder<StartControllerImp>(
      // ignore: deprecated_member_use
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          return await  alertexit();
        },
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background.jpg"),
                fit: BoxFit.fill,
                filterQuality: FilterQuality.medium,
              ),
            ),
            child: controller.listpage.elementAt(controller.selectedIndex),
          ),
          extendBody: true,
          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  color: Colors.black.withOpacity(.2),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      iconColor: Color.fromARGB(255, 5, 132, 104),
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.card_membership,
                      iconColor: Color.fromARGB(255, 5, 132, 104),
                      text: 'Card',
                    ),
                    GButton(
                      icon: Icons.payments_outlined,
                      iconColor: Color.fromARGB(255, 5, 132, 104),
                      text: 'Pay',
                    ),
                    GButton(
                      icon: Icons.person_2_outlined,
                      iconColor: Color.fromARGB(255, 5, 132, 104),
                      text: 'User',
                    ),
                  ],
                  selectedIndex: controller.selectedIndex,
                  onTabChange: (index) {
                    controller.generatewindow(index);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
