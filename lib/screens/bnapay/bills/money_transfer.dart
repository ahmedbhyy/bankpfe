import 'package:bankpfe/controllers/pay_controllers/money_transfer_controller.dart';
import 'package:bankpfe/data/Model/account_model.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/authwidgets/textfield_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_background.dart';
import 'package:bankpfe/widgets/generalwidgets/common_loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:u_credit_card/u_credit_card.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';
import '../../../widgets/homewidget/cards_home.dart';
import '../../cardscreens/card_details.dart';

class MoneyTransfer extends StatelessWidget {
  final List<AccountModel> mycardList;

  const MoneyTransfer({
    super.key,
    required this.mycardList,
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
                          myCard: mycardList[index].accountcard,
                          username: controller.username ?? "Member",
                          datecreation: mycardList[index].creationdate,
                        ),
                        cardtype: CardType.credit,
                        cardholder: controller.username ?? "Member",
                        cardnumber: mycardList[index].accountcard.cardNumber,
                        backgroundimage:
                            mycardList[index].accountcard.background,
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Available balance :  ${mycardList[controller.i].accountcard.balance.toString().length >= 5 ? mycardList[controller.i].accountcard.balance.toString().substring(0, 5) : mycardList[controller.i].accountcard.balance.toString()} TND",
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
                                hint: "RIB",
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
                                                    hint: "RIB",
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
                                                      } else if (val.length !=
                                                          23) {
                                                        return "can't be higher or lower than 23";
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
                                                        controller.numbers.add(
                                                            controller
                                                                .cardaddnumber
                                                                .text);
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
                                  } else if (val.length != 23) {
                                    return "Can't to be higher than 23 caracter";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            PopupMenuButton<String>(
                              initialValue: controller.selectedItem,
                              onSelected: (String item) {
                                controller.updatevalue(item);
                              },
                              itemBuilder: (BuildContext context) {
                                return controller.names.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Icon(
                                          Icons.category_outlined,
                                          color: Colors.grey,
                                        ),
                                        Text(item),
                                      ],
                                    ),
                                  );
                                }).toList();
                              },
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
                        controller.isloading
                            ? const CommonLoading()
                            : ButtonAuth(
                                mytitle: "Send",
                                myfunction: () {
                                  if (controller
                                          .formStatemoneytransfer.currentState!
                                          .validate() &&
                                      double.parse(controller.amount.text) <
                                          mycardList[controller.i]
                                              .accountcard
                                              .balance) {
                                    controller.verifyuser(
                                      double.parse(controller.amount.text),
                                      controller.cardnumber.text,
                                      mycardList[controller.i].id,
                                      mycardList[controller.i]
                                          .accountcard
                                          .balance,
                                      mycardList[controller.i].accountcard.rib,
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
