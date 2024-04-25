import 'package:bankpfe/controllers/card_controller/cards_screen_controller.dart';
import 'package:bankpfe/screens/cardscreens/card_details.dart';

import 'package:bankpfe/widgets/authwidgets/button_auth.dart';

import 'package:bankpfe/widgets/generalwidgets/common_row_appbar.dart';
import 'package:bankpfe/widgets/homewidget/cards_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                child: CardsHome(
                  mypage: CardDetails(
                    myCard: controller.usercards[index],
                    username: "Ahmed bhy",
                  ),
                  cardtype: CardType.credit,
                  cardholder: "Ahmed bhy",
                  cardnumber: controller.usercards[index].cardNumber,
                  backgroundimage: controller.usercards[index].background,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ButtonAuth(
              mytitle: "Add card",
              myfunction: () {
                controller.addacard();
              },
            ),
            const SizedBox(height: 20.0),
            controller.isloading ? const CommonLoading() : Container()
          ],
        ),
      ),
    );
  }
}
