import 'package:bankpfe/controllers/pay_controllers/donation_pay_controller.dart';
import 'package:bankpfe/data/Model/card_model.dart';
import 'package:bankpfe/data/Model/donation_model.dart';
import 'package:bankpfe/screens/cardscreens/card_details.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/authwidgets/textfield_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_background.dart';
import 'package:bankpfe/widgets/generalwidgets/common_row_appbar.dart';

import 'package:bankpfe/widgets/homewidget/cards_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:u_credit_card/u_credit_card.dart';

class DonationPay extends StatelessWidget {
  final List<CardModel> mycardList;

  final DonationModel mydonation;

  const DonationPay(
      {super.key,
      required this.mycardList,
   
      required this.mydonation});

  @override
  Widget build(BuildContext context) {
    Get.put(DonationsPayControllerImp());
    return GetBuilder<DonationsPayControllerImp>(
      builder: (controller) => Form(
        key: controller.formStatedonation,
        child: Scaffold(
          body: ContainerBackground(
            mywidget: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
              children: [
                const AppBarCommon(title: "Donate"),
                Text(
                  "Select a card",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 10.0),
                Swiper(
                  itemCount: mycardList.length,
                  loop: true,
                  duration: 1200,
                  itemHeight: 200,
                  itemWidth: 300,
                  onIndexChanged: (value) {
                    controller.updateindexz(value);
                  },
                  scrollDirection: Axis.horizontal,
                  layout: SwiperLayout.STACK,
                  itemBuilder: (context, index) {
                    return CardsHome(
                      mypage: CardDetails(
                        myCard: mycardList[index],
                        username: controller.username??"Member",
                      ),
                      cardtype: CardType.credit,
                      cardholder:  controller.username ?? "Member",
                      cardnumber: mycardList[index].cardNumber,
                      backgroundimage: mycardList[index].background,
                    );
                  },
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Available balance :  ${mycardList[controller.z].balance.toString().length >= 5 ? mycardList[controller.z].balance.toString().substring(0, 5) : mycardList[controller.z].balance.toString()} TND",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    fontSize: 15.0,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                TextFieldAuth(
                  hint: "Amount",
                  mycontroller: controller.amount!,
                  mysuffix: "TND",
                  myicon: const Icon(Icons.money),
                  ispass: false,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't to be empty ";
                    }
                    return null;
                  },
                  mytype: TextInputType.number,
                  readonly: false,
                ),
                TextFieldAuth(
                  hint: "Description",
                  mycontroller: controller.desc!,
                  myicon: const Icon(Icons.description_outlined),
                  ispass: false,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't to be empty ";
                    }
                    return null;
                  },
                  mytype: TextInputType.text,
                  readonly: false,
                ),
                const SizedBox(height: 20.0),
                ButtonAuth(
                  mytitle: "Donate",
                  myfunction: () {
                    if (controller.formStatedonation.currentState!.validate() &&
                        double.parse(controller.amount!.text) <
                            mycardList[controller.z].balance) {
                      controller.donateverify(
                        mydonation.title,
                        controller.desc!.text,
                        double.parse(controller.amount!.text),
                        mycardList[controller.z].id,
                        mycardList[controller.z].balance,
                        mydonation.id,
                        mydonation.currentamount,
                        mydonation.givers,
                        mydonation.totalamount,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
