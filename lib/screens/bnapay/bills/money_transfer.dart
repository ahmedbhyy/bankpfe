import 'package:bankpfe/controllers/pay_controllers/money_transfer_controller.dart';
import 'package:bankpfe/data/Model/card_model.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/authwidgets/textfield_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../../widgets/generalwidgets/common_row_appbar.dart';
import '../../../widgets/homewidget/cards_home.dart';
import '../../cardscreens/card_details.dart';

class MoneyTransfer extends StatelessWidget {
  final List<CardModel> mycardList;
  final String username;
  const MoneyTransfer({
    super.key,
    required this.mycardList, required this.username,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(MoneyTransferControllerImp());
    return GetBuilder<MoneyTransferControllerImp>(
      builder: (controller) => Form(
        key: controller.formStatemoneytransfer,
        child: Scaffold(
          body: ContainerBackground(
            mywidget: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 15.0),
                children: [
                  const AppBarCommon(title: "Send Money"),
                  const SizedBox(height: 10.0),
                  Text(
                    "Select a card",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Swiper(
                    itemCount: controller.cardsdetails.length,
                    loop: true,
                    duration: 1200,
                    itemHeight: 200,
                    itemWidth: 300,
                    onIndexChanged: (value) {
                      controller.updateindex(value);
                    },
                    scrollDirection: Axis.horizontal,
                    layout: SwiperLayout.STACK,
                    itemBuilder: (context, index) {
                      return CardsHome(
                        mypage: CardDetails(
                          myCard: mycardList[index],
                          username: username,
                        ),
                        cardtype: CardType.credit,
                        cardholder: username,
                        cardnumber: mycardList[index].cardNumber,
                        backgroundimage: mycardList[index].background,
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Available balance :  ${mycardList[controller.i].balance} TND",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                          controller.choices.length,
                          (index) => InkWell(
                            onTap: () {
                              controller.updateColor(index);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.all(10.0),
                              width: 120.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: controller.isSelectedList[index]
                                    ? const Color.fromARGB(255, 2, 131, 103)
                                    : const Color.fromARGB(255, 203, 195, 195),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  controller.choices[index]["myicon"],
                                  const SizedBox(height: 7.0),
                                  Text(
                                    controller.choices[index]["mytitle"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        TextFieldAuth(
                          hint: "Card number",
                          readonly: false,
                          mytype: TextInputType.number,
                          mycontroller: controller.cardnumber,
                          myicon: const Icon(Icons.card_membership_outlined),
                          ispass: false,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Can't to be empty ";
                            } else if (val.length != 16) {
                              return "Can't to be higher than 16 caracter";
                            }
                            return null;
                          },
                        ),
                        TextFieldAuth(
                          hint: "Amount",
                          mysuffix: "TND",
                          readonly: false,
                          mytype: TextInputType.number,
                          mycontroller: controller.cardnumber,
                          myicon: const Icon(Icons.money),
                          ispass: false,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Can't to be empty ";
                            }
                            return null;
                          },
                        ),
                        TextFieldAuth(
                          hint: "Content",
                          readonly: false,
                          mycontroller: controller.cardnumber,
                          mytype: TextInputType.text,
                          myicon: const Icon(Icons.description_outlined),
                          ispass: false,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Can't to be empty ";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  ButtonAuth(
                    mytitle: "Send",
                    myfunction: () {
                      if (controller.formStatemoneytransfer.currentState!
                          .validate()) {
                        controller.verifyuser();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
