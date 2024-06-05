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
    required this.mycardList,
    required this.username,
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
                    itemCount: mycardList.length,
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
                    "Available balance :  ${mycardList[controller.i].balance.toString().length >= 5 ? mycardList[controller.i].balance.toString().substring(0, 5) : mycardList[controller.i].balance.toString()} TND",
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFieldAuth(
                                hint: "Card number",
                                readonly: false,
                                mysuffixicon: GestureDetector(
                                  child:
                                      const Icon(Icons.person_add_alt_outlined),
                                  onTap: () {
                                    Get.dialog(
                                      Form(
                                        key: controller.formStateaddcard,
                                        child: Dialog(
                                          backgroundColor: Colors.white,
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Center(
                                                  child: Text(
                                                    "Add a Card",
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color(0xff00aa86),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.grey,
                                                  thickness: 1,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0),
                                                  child: TextFieldAuth(
                                                    hint: "Card Number",
                                                    readonly: false,
                                                    mysuffix: "",
                                                    mycontroller: controller
                                                        .cardaddnumber,
                                                    myicon: const Icon(
                                                        Icons.numbers,
                                                        color:
                                                            Color(0xff00aa86)),
                                                    ispass: false,
                                                    validator: (val) {
                                                      if (val == null ||
                                                          val.isEmpty) {
                                                        return "Can't to be empty ";
                                                      }
                                                      return null;
                                                    },
                                                    mytype:
                                                        TextInputType.number,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0),
                                                  child: TextFieldAuth(
                                                    hint: "Card Holder name",
                                                    readonly: false,
                                                    mysuffix: "",
                                                    mycontroller: controller
                                                        .cardaddholder,
                                                    myicon: const Icon(
                                                        Icons.person_2_outlined,
                                                        color:
                                                            Color(0xff00aa86)),
                                                    ispass: false,
                                                    validator: (val) {
                                                      if (val == null ||
                                                          val.isEmpty) {
                                                        return "Can't to be empty ";
                                                      }
                                                      return null;
                                                    },
                                                    mytype: TextInputType.text,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 20.0),
                                                  child: ButtonAuth(
                                                    mytitle: "Add",
                                                    myfunction: () {
                                                      if (controller
                                                          .formStateaddcard
                                                          .currentState!
                                                          .validate()) {
                                                        Get.back();
                                                        Get.rawSnackbar(
                                                            title: "Success",
                                                            message:
                                                                "You have added a new Card",
                                                            backgroundColor:
                                                                Colors.green);
                                                        controller.names.add(
                                                            controller
                                                                .cardaddholder
                                                                .text);
                                                        controller
                                                                .sampleitemlisty
                                                                .contains(
                                                                    SampleItem
                                                                        .itemFour)
                                                            ? controller
                                                                .sampleitemlisty
                                                                .add(SampleItem
                                                                    .itemFive)
                                                            : controller
                                                                .sampleitemlisty
                                                                .add(SampleItem
                                                                    .itemFour);
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                mytype: TextInputType.number,
                                mycontroller: controller.cardnumber,
                                myicon:
                                    const Icon(Icons.card_membership_outlined),
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
                            ),
                            PopupMenuButton<SampleItem>(
                              initialValue: controller.selectedItem,
                              onSelected: (SampleItem item) {
                                String cardNumber;
                                switch (item) {
                                  case SampleItem.itemone:
                                    cardNumber = "1234 5678 9012 3456";
                                    break;
                                  case SampleItem.itemTwo:
                                    cardNumber = "9876 5432 1098 7654";
                                    break;
                                  case SampleItem.itemThree:
                                    cardNumber = "2468 1357 8024 6913";
                                    break;
                                  case SampleItem.itemFour:
                                    cardNumber = controller.cardaddnumber.text;
                                    break;
                                  default:
                                    cardNumber = "2468 1357 8024 6913";
                                    break;
                                }
                                controller.cardnumber.text = cardNumber;
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
                                          Icons.person_2_outlined,
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
                          hint: "Amount",
                          mysuffix: "TND",
                          readonly: false,
                          mytype: TextInputType.number,
                          mycontroller: controller.amount,
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
                          mycontroller: controller.content,
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
                        const SizedBox(height: 30.0),
                        ButtonAuth(
                          mytitle: "Send",
                          myfunction: () {
                            if (controller.formStatemoneytransfer.currentState!
                                    .validate() &&
                                double.parse(controller.amount.text) <
                                    mycardList[0].balance) {
                              controller.verifyuser(
                                double.parse(controller.amount.text),
                                controller.cardnumber.text,
                                mycardList[0].id,
                                mycardList[0].balance,
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
