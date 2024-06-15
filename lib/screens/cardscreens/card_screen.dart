import 'package:bankpfe/controllers/card_controller/cards_screen_controller.dart';
import 'package:bankpfe/screens/cardscreens/card_details.dart';

import 'package:bankpfe/widgets/generalwidgets/common_row_appbar.dart';
import 'package:bankpfe/widgets/homewidget/cards_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../widgets/generalwidgets/common_loading_progress.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CardsScreenControllerImp());
    return GetBuilder<CardsScreenControllerImp>(
      builder: (controller) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          children: [
            const AppBarCommon(title: "Cards"),
            const SizedBox(height: 20.0),
            ...List.generate(
              controller.usercards.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 20.0,
                ),
                child: Column(
                  children: [
                    CardsHome(
                      mypage: CardDetails(
                        myCard: controller.usercards[index],
                        username: controller.username,
                      ),
                      cardtype: CardType.credit,
                      cardholder: controller.username,
                      cardnumber: controller.usercards[index].cardNumber,
                      backgroundimage: controller.usercards[index].background,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Available balance : ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 15.0,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          "${controller.usercards[index].balance.toString().length >= 5 ? controller.usercards[index].balance.toString().substring(0, 5) : controller.usercards[index].balance.toString()} TND",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            controller.isloading
                ? const CommonLoading()
                : controller.usercards.isEmpty
                    ? Lottie.asset("images/lotties/lottie_empty.json",
                        height: 300.0)
                    : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
