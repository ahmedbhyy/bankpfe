import 'package:bankpfe/controllers/pay_controllers/pay_billnumber_controller.dart';

import 'package:bankpfe/data/Model/card_model.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:u_credit_card/u_credit_card.dart';

import '../../../widgets/authwidgets/textfield_auth.dart';
import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

import '../../../widgets/homewidget/cards_home.dart';
import '../../cardscreens/card_details.dart';

class PayBillwithNumber extends StatelessWidget {
  final List<CardModel> myCard;

  const PayBillwithNumber({super.key, required this.myCard});

  @override
  Widget build(BuildContext context) {
    Get.put(PayBillnumberControllerImp());
    return GetBuilder<PayBillnumberControllerImp>(
      builder: (controller) => Form(
        key: controller.formState,
        child: Scaffold(
          body: ContainerBackground(
            mywidget: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 15.0),
                children: [
                  const AppBarCommon(title: "Pay Your bill"),
                  const SizedBox(height: 20.0),
                  Text(
                    "Select a card",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Swiper(
                    itemCount: myCard.length,
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
                          myCard: myCard[index],
                          username: controller.username ?? "Member",
                        ),
                        cardtype: CardType.credit,
                        cardholder: controller.username ?? "Member",
                        cardnumber: myCard[index].cardNumber,
                        backgroundimage: myCard[index].background,
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Available balance :  ${myCard[controller.z].balance.toString().length >= 5 ? myCard[controller.z].balance.toString().substring(0, 5) : myCard[controller.z].balance.toString()} TND",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFieldAuth(
                                hint: "Bill Type",
                                readonly: true,
                                mycontroller: controller.billtype!,
                                mytype: TextInputType.text,
                                myicon: const Icon(Icons.description),
                                ispass: false,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Can't to be empty ";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            PopupMenuButton<SampleItem>(
                              initialValue: controller.selectedItem,
                              onSelected: (SampleItem item) {
                                String billtype;
                                switch (item) {
                                  case SampleItem.itemone:
                                    billtype = "Water Bill";
                                    break;
                                  case SampleItem.itemTwo:
                                    billtype = "Electric Bill";
                                    break;
                                  case SampleItem.itemThree:
                                    billtype = "Internet Bill";
                                    break;
                                  default:
                                    billtype = "Electric Bill";
                                    break;
                                }
                                controller.billtype!.text = billtype;
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<SampleItem>>[
                                ...List.generate(
                                  controller.sampleitemlisty.length,
                                  (index) => PopupMenuItem<SampleItem>(
                                    value: controller.sampleitemlisty[index],
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.description,
                                          color: Color(0xff00aa86),
                                        ),
                                        Text(controller.names[index]),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        TextFieldAuth(
                          hint: "Bill Number",
                          readonly: false,
                          mycontroller: controller.billnumber!,
                          mytype: TextInputType.text,
                          myicon: const Icon(Icons.numbers),
                          ispass: false,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Can't to be empty ";
                            }
                            return null;
                          },
                        ),
                        TextFieldAuth(
                          hint: "Bill amount",
                          mysuffix: "TND",
                          readonly: false,
                          mytype: TextInputType.number,
                          mycontroller: controller.billamount!,
                          myicon: const Icon(Icons.money),
                          ispass: false,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Can't to be empty ";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30.0),
                        ButtonAuth(
                          mytitle: "Confirm",
                          myfunction: () {
                            if (controller.formState.currentState!.validate()) {
                              controller.paybill(
                                myCard[controller.z].id,
                                double.parse(controller.billamount!.text),
                                myCard[controller.z].balance,
                                controller.billtype!.text,
                                controller.billnumber!.text,
                              );
                            }
                          },
                        ),
                      ],
                    ),
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
