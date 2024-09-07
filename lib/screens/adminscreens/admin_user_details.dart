import 'package:bankpfe/controllers/admin_controller/admin_user_details_controller.dart';
import 'package:bankpfe/data/Model/user_model.dart';
import 'package:bankpfe/screens/adminscreens/addcard_foruser.dart';
import 'package:bankpfe/screens/adminscreens/send_specefic_notification.dart';

import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_appbar.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:bankpfe/widgets/generalwidgets/commoun_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AdminUserDetails extends StatelessWidget {
  final UserModel myuser;
  const AdminUserDetails({super.key, required this.myuser});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminUserDetailsControllerImp());
    return GetBuilder<AdminUserDetailsControllerImp>(
      builder: (controller) => Scaffold(
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
              CommonAppBar(
                title: myuser.username,
                lottie: "images/lotties/lottie_bill.json",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    controller.categories.length,
                    (index) => CommonColumnCategories(
                      categorie: controller.categories[index],
                      isactive: controller.isSelectedList[index],
                      onPressed: () => controller.updateColor(index),
                      myicon: controller.myicons[index],
                    ),
                  ),
                ],
              ),
              controller.categoriesname == "Information"
                  ? Column(
                      children: [
                        CommonContainerBills(
                          mywidget: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Email",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        color:
                                            Color.fromARGB(255, 80, 103, 81)),
                                  ),
                                  Text(myuser.email)
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Username",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        color:
                                            Color.fromARGB(255, 80, 103, 81)),
                                  ),
                                  Text(myuser.username)
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Userid",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        color:
                                            Color.fromARGB(255, 80, 103, 81)),
                                  ),
                                  Text(myuser.userid)
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "CIN",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        color:
                                            Color.fromARGB(255, 80, 103, 81)),
                                  ),
                                  Text(myuser.cin)
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Phone",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        color:
                                            Color.fromARGB(255, 80, 103, 81)),
                                  ),
                                  Text(myuser.phone)
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Birthday Date",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        color:
                                            Color.fromARGB(255, 80, 103, 81)),
                                  ),
                                  Text(
                                    myuser.birthdaydate
                                        .toDate()
                                        .toString()
                                        .substring(0, 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ButtonAuth(
                          mytitle: "Send Notification",
                          myfunction: () {
                            Get.to(
                              () => AdminSendTokenNotifications(
                                  usertoken: myuser.token),
                            );
                          },
                        ),
                      ],
                    )
                  : controller.categoriesname == "Accounts"
                      ? controller.usercards.isEmpty
                          ? Column(children: [
                              Lottie.asset("images/lotties/lottie_empty.json"),
                              ButtonAuth(
                                mytitle: "Add an account",
                                myfunction: () {
                                  Get.to(
                                    () => AddaCardForUser(
                                      userid: myuser.userid,
                                      usertoken: myuser.token,
                                      myrib: controller.ribs,
                                      cardnumbers: controller.cardnumbers,
                                      relatedaccounts:
                                          controller.relatedaccountsnumbers,
                                    ),
                                  );
                                },
                              ),
                            ])
                          : controller.isloading
                              ? Lottie.asset(
                                  "images/lotties/lottie_loading.json",
                                  height: 50.0,
                                )
                              : Column(
                                  children: [
                                    ...List.generate(
                                      controller.usercards.length,
                                      (index) => Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          CommonContainerBills(
                                            mywidget: Column(
                                              children: [
                                                Text(
                                                  "Account ${index + 1}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Account N°",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              80,
                                                              103,
                                                              81)),
                                                    ),
                                                    Text(controller
                                                        .usercards[index]
                                                        .accountnumber)
                                                  ],
                                                ),
                                                const SizedBox(height: 10.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Creation Date",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              80,
                                                              103,
                                                              81)),
                                                    ),
                                                    Text(controller
                                                        .usercards[index]
                                                        .creationdate
                                                        .toDate()
                                                        .toString()
                                                        .substring(0, 10))
                                                  ],
                                                ),
                                                const SizedBox(height: 10.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Card Type",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              80,
                                                              103,
                                                              81)),
                                                    ),
                                                    Text(controller
                                                        .usercards[index]
                                                        .accountcard
                                                        .cardtype)
                                                  ],
                                                ),
                                                const SizedBox(height: 10.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Card Number",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              80,
                                                              103,
                                                              81)),
                                                    ),
                                                    Text(controller
                                                        .usercards[index]
                                                        .accountcard
                                                        .cardNumber)
                                                  ],
                                                ),
                                                const SizedBox(height: 10.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Related Account",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              80,
                                                              103,
                                                              81)),
                                                    ),
                                                    Text(controller
                                                        .usercards[index]
                                                        .accountcard
                                                        .relatedaccount)
                                                  ],
                                                ),
                                                const SizedBox(height: 10.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "RIB",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              80,
                                                              103,
                                                              81)),
                                                    ),
                                                    Text(controller
                                                        .usercards[index]
                                                        .accountcard
                                                        .rib)
                                                  ],
                                                ),
                                                const SizedBox(height: 10.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Balance",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              80,
                                                              103,
                                                              81)),
                                                    ),
                                                    Text(
                                                        "${controller.usercards[index].accountcard.balance.toString()} TND"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 2.0,
                                            top: -8.0,
                                            child: IconButton(
                                              onPressed: () {
                                                Get.dialog(
                                                  Dialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Are u sure to delete this Account ?",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 20.0),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              TextButton.icon(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .cancel),
                                                                label: const Text(
                                                                    "Cancel"),
                                                              ),
                                                              TextButton.icon(
                                                                onPressed: () {
                                                                  if (controller
                                                                          .usercards[
                                                                              index]
                                                                          .accountcard
                                                                          .balance <=
                                                                      0.0) {
                                                                    controller.deleteaccount(
                                                                        controller
                                                                            .usercards[
                                                                                index]
                                                                            .id,
                                                                        myuser
                                                                            .userid);
                                                                  } else {
                                                                    Get.rawSnackbar(
                                                                        backgroundColor: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            255,
                                                                            0,
                                                                            0),
                                                                        title:
                                                                            "Error",
                                                                        message:
                                                                            "can't be removed because the balance is not egale 0 !");
                                                                  }
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                                label: const Text(
                                                                    "Delete"),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 238, 99, 89),
                                              ),
                                              iconSize: 30.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    ButtonAuth(
                                      mytitle: "Add an Account",
                                      myfunction: () {
                                        Get.to(
                                          () => AddaCardForUser(
                                            userid: myuser.userid,
                                            usertoken: myuser.token,
                                            myrib: controller.ribs,
                                            cardnumbers: controller.cardnumbers,
                                            relatedaccounts: controller
                                                .relatedaccountsnumbers,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                      : controller.categoriesname == "Bills"
                          ? controller.userbills.isEmpty
                              ? Lottie.asset("images/lotties/lottie_empty.json")
                              : controller.isloading
                                  ? Lottie.asset(
                                      "images/lotties/lottie_loading.json",
                                      height: 50.0,
                                    )
                                  : CommonContainerBills(
                                      mywidget: Column(
                                        children: [
                                          ...List.generate(
                                            controller.userbills.length,
                                            (index) => Column(
                                              children: [
                                                ListTile(
                                                  title: Text(controller
                                                      .userbills[index].title),
                                                  subtitle: Text(
                                                    "${controller.userbills[index].amount.toString()} TND\nCode: ${controller.userbills[index].code}\nDate: ${controller.userbills[index].date.toDate().toString().substring(0, 10)}",
                                                  ),
                                                  leading: Image.asset(
                                                    "images/${controller.userbills[index].image}.png",
                                                    height: 50.0,
                                                  ),
                                                ),
                                                controller.userbills.length -
                                                            1 ==
                                                        index
                                                    ? Container()
                                                    : const Divider(
                                                        height: 2.0,
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                          : controller.categoriesname == "Transactions"
                              ? controller.usertransaction.isEmpty
                                  ? Lottie.asset(
                                      "images/lotties/lottie_empty.json")
                                  : controller.isloading
                                      ? Lottie.asset(
                                          "images/lotties/lottie_loading.json",
                                          height: 50.0,
                                        )
                                      : CommonContainerBills(
                                          mywidget: Column(
                                            children: [
                                              ...List.generate(
                                                controller
                                                    .usertransaction.length,
                                                (index) => Column(
                                                  children: [
                                                    ListTile(
                                                      title: Text(controller
                                                          .usertransaction[
                                                              index]
                                                          .title),
                                                      subtitle: Text(
                                                        "Amount: ${controller.usertransaction[index].amount.toString()} TND\nCard id: ${controller.usertransaction[index].cardid}\nDate: ${controller.usertransaction[index].date.toDate().toString().substring(0, 10)}\nInternal:${controller.usertransaction[index].internal}",
                                                      ),
                                                      leading: Lottie.asset(
                                                        controller
                                                            .usertransaction[
                                                                index]
                                                            .lottie,
                                                        height: 30.0,
                                                      ),
                                                    ),
                                                    controller.usertransaction
                                                                    .length -
                                                                1 ==
                                                            index
                                                        ? Container()
                                                        : const Divider(
                                                            height: 2.0,
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                              : const Center(
                                  child: Text("Error , Please try again!")),
            ],
          ),
        ),
      ),
    );
  }
}
