import 'package:bankpfe/controllers/admin_controller/admin_addcard_controller.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/authwidgets/textfield_auth.dart';
import '../../widgets/generalwidgets/common_appbar.dart';

class AddaCardForUser extends StatelessWidget {
  final String userid;
  final String usertoken;
  final List<String> myrib;
  final List<String> cardnumbers;
  final List<String> relatedaccounts;
  const AddaCardForUser(
      {super.key,
      required this.userid,
      required this.usertoken,
      required this.myrib,
      required this.cardnumbers,
      required this.relatedaccounts});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminAddcardControllerImp());
    return GetBuilder<AdminAddcardControllerImp>(
      builder: (controller) => Form(
        key: controller.formStatecard,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background.jpg"),
                fit: BoxFit.fill,
                filterQuality: FilterQuality.medium,
              ),
            ),
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 11.0, vertical: 10.0),
              children: [
                const CommonAppBar(
                  title: "Add an Account",
                  lottie: "images/lotties/lottie_onlinepayment.json",
                ),
                Lottie.asset(
                  "images/lotties/lottie_onboadring3.json",
                  height: 100.0,
                  repeat: false,
                ),
                TextFieldAuth(
                  hint: "Account Number",
                  mycontroller: controller.accountnumber!,
                  myicon: const Icon(Icons.numbers),
                  ispass: false,
                  mysuffixicon: GestureDetector(
                    child: IconButton(
                        onPressed: () {
                          controller.accountnumber!.text = controller
                              .generateUniqueRelatedAccount(relatedaccounts);
                        },
                        icon: const Icon(Icons.edit)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't to be empty ";
                    } else if (val.length != 13) {
                      return "can't be higher or lower than 13!";
                    }
                    return null;
                  },
                  mytype: TextInputType.text,
                  readonly: true,
                ),
                TextFieldAuth(
                  hint: "CIN",
                  mycontroller: controller.cin!,
                  myicon: const Icon(Icons.numbers),
                  ispass: false,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't to be empty ";
                    } else if (val.length != 8) {
                      return "can't be higher or lower than 8";
                    }
                    return null;
                  },
                  mytype: TextInputType.number,
                  readonly: false,
                ),
                TextFieldAuth(
                  hint: "Card Number",
                  mycontroller: controller.cardnumber!,
                  myicon: const Icon(Icons.numbers),
                  ispass: false,
                  mysuffixicon: GestureDetector(
                    child: IconButton(
                        onPressed: () {
                          controller.cardnumber!.text =
                              controller.generateUniqueCardNumber(cardnumbers);
                        },
                        icon: const Icon(Icons.edit)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't to be empty ";
                    }
                    return null;
                  },
                  mytype: TextInputType.number,
                  readonly: true,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFieldAuth(
                        hint: "Card Type",
                        mycontroller: controller.cardtype!,
                        myicon: const Icon(Icons.type_specimen),
                        ispass: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Can't to be empty ";
                          }
                          return null;
                        },
                        mytype: TextInputType.text,
                        readonly: true,
                      ),
                    ),
                    PopupMenuButton<SampleItem>(
                      initialValue: controller.selectedItem,
                      onSelected: (SampleItem item) {
                        String cardtype;
                        switch (item) {
                          case SampleItem.itemone:
                            cardtype = "EPARGNE";
                            break;
                          case SampleItem.itemTwo:
                            cardtype = "INFINITE";
                            break;

                          default:
                            cardtype = "INFINITE";
                            break;
                        }
                        controller.cardtype!.text = cardtype;
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
                                  Icons.card_membership_rounded,
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
                  hint: "RIB",
                  mycontroller: controller.rib!,
                  myicon: const Icon(Icons.numbers),
                  ispass: false,
                  mysuffixicon: GestureDetector(
                    child: IconButton(
                        onPressed: () {
                          controller.rib!.text =
                              controller.generateUniqueRIB(myrib);
                        },
                        icon: const Icon(Icons.edit)),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't to be empty ";
                    } else if (val.length != 23) {
                      return "can't be less or higher than 23!";
                    } else if (myrib.contains(val)) {
                      return "This rib is used, please try again.";
                    }
                    return null;
                  },
                  mytype: TextInputType.text,
                  readonly: true,
                ),
                TextFieldAuth(
                  hint: "Balance",
                  mycontroller: controller.balance!,
                  myicon: const Icon(Icons.money),
                  ispass: false,
                  mysuffix: "TND",
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't to be empty ";
                    } else if (!val.isNum) {
                      return "should be a number!";
                    }
                    return null;
                  },
                  mytype: TextInputType.number,
                  readonly: false,
                ),
                const SizedBox(height: 20.0),
                controller.isloading
                    ? const CommonLoading()
                    : ButtonAuth(
                        mytitle: "Add Account",
                        myfunction: () {
                          if (controller.formStatecard.currentState!
                              .validate()) {
                            controller.addacard(userid, usertoken);
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
