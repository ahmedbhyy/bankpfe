import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bankpfe/controllers/homecontroller/home_controller.dart';
import 'package:bankpfe/screens/homescreens/alltransactions.dart';
import 'package:bankpfe/screens/homescreens/notifications.dart';
import 'package:bankpfe/screens/homescreens/transaction_details.dart';
import 'package:bankpfe/screens/profil_screen/edit_profil.dart';
import 'package:bankpfe/slides/slide_right.dart';

import 'package:bankpfe/slides/slide_top.dart';
import 'package:bankpfe/slides/slide_topright.dart';
import 'package:bankpfe/widgets/generalwidgets/common_loading_progress.dart';

import 'package:bankpfe/widgets/homewidget/cards_home.dart';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../cardscreens/card_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
      builder: (controller) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 20.0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          SlideTop(
                            page: const EditProfil(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 22.0,
                        backgroundImage: NetworkImage(controller.imagefile),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome Back",
                        ),
                        const SizedBox(height: 3.0),
                        AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                              controller.username,
                              textStyle: GoogleFonts.mulish(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 1, 100, 78),
                              ),
                              colors: controller.colorizeColors,
                            ),
                          ],
                          isRepeatingAnimation: true,
                          totalRepeatCount: 100,
                          pause: const Duration(milliseconds: 50),
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    IconButton(
                      iconSize: 28.0,
                      onPressed: () {
                        Navigator.of(context).push(
                          SlideTopRight(
                            page: const Notifications(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.notifications_active_outlined,
                      ),
                    ),
                    Positioned(
                      bottom: 25.0,
                      left: 25.0,
                      child: CircleAvatar(
                        radius: 9.0,
                        backgroundColor:
                            const Color.fromARGB(255, 68, 188, 132),
                        child: Text(
                          "${controller.notificationslist.length}",
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Account",
                    style: GoogleFonts.mulish(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(SlideRight(page: const EditProfil()));
                    },
                    child: const Text(
                      'View Profil',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            controller.isloading
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 70),
                    child: CommonLoading(),
                  )
                : controller.usercards.isEmpty
                    ? Lottie.asset("images/lotties/lottie_empty.json",
                        height: 100.0)
                    : Column(
                        children: [
                          Swiper(
                            itemCount: controller.usercards.length,
                            loop: true,
                            duration: 1200,
                            itemHeight: 200,
                            itemWidth: 300,
                            onIndexChanged: (value) {
                              controller.updateindex(value);
                            },
                            scrollDirection: Axis.horizontal,
                            layout: SwiperLayout.STACK,
                            itemBuilder: (context, index) => CardsHome(
                              mypage: CardDetails(
                                myCard: controller.usercards[index],
                                username: controller.username,
                              ),
                              cardtype: CardType.credit,
                              cardholder: controller.username,
                              cardnumber:
                                  controller.usercards[index].cardNumber,
                              backgroundimage:
                                  controller.usercards[index].background,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Available balance : ",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.mulish(
                                    fontSize: 15.0,
                                    color:
                                        const Color.fromARGB(255, 2, 108, 62)),
                              ),
                              Text(
                                "${controller.usercards[controller.i].balance.toString().substring(0, 6)} TND",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.mulish(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 67, 56, 56),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Transaction",
                    style: GoogleFonts.mulish(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        SlideRight(
                          page: const AllTransactions(),
                        ),
                      );
                    },
                    child: const Text(
                      "View All",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 50.0,
                child: ListView.builder(
                  itemCount: controller.categories.length,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      controller.updateColor(index);
                      controller.transactioncategorie =
                          controller.categories[index];
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 80.0,
                      margin: const EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xff00aa86), width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                        color: controller.isSelectedList[index]
                            ? const Color.fromARGB(255, 165, 190, 179)
                            : Colors.transparent,
                      ),
                      child: Text(
                        controller.categories[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: controller.isSelectedList[index]
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              padding: const EdgeInsets.all(5.0),
              height: MediaQuery.of(context).size.height / 3.3,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15.0,
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: controller.isloading
                  ? const CommonLoading()
                  : controller
                          .choosecategories(controller.transactioncategorie)
                          .isEmpty
                      ? Lottie.asset(
                          "images/lotties/lottie_empty.json",
                          height: 100.0,
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller
                              .choosecategories(controller.transactioncategorie)
                              .length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              ListTile(
                                title: Text(controller
                                    .choosecategories(
                                        controller.transactioncategorie)[index]
                                    .title),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller
                                          .choosecategories(controller
                                              .transactioncategorie)[index]
                                          .date
                                          .toDate()
                                          .toString()
                                          .substring(0, 16),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Row(
                                      children: [
                                        controller
                                                        .choosecategories(
                                                            controller
                                                                .transactioncategorie)[
                                                            index]
                                                        .type ==
                                                    "Transfer" ||
                                                controller
                                                        .choosecategories(
                                                            controller
                                                                .transactioncategorie)[
                                                            index]
                                                        .type ==
                                                    "Retrait"
                                            ? const Icon(
                                                Icons.remove_circle_outline,
                                                size: 15.0,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.add_circle_outline,
                                                size: 15.0,
                                                color: Colors.green,
                                              ),
                                        const SizedBox(width: 5.0),
                                        Text(
                                          "${controller.choosecategories(controller.transactioncategorie)[index].amount} TND",
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: (controller
                                                            .choosecategories(
                                                                controller
                                                                    .transactioncategorie)[
                                                                index]
                                                            .type ==
                                                        "Retrait" ||
                                                    controller
                                                            .choosecategories(
                                                                controller
                                                                    .transactioncategorie)[
                                                                index]
                                                            .type ==
                                                        "Transfer")
                                                ? Colors.red
                                                : Colors.green,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    SlideRight(
                                      page: TransactionDetails(
                                          mymodel: controller.choosecategories(
                                                  controller
                                                      .transactioncategorie)[
                                              index]),
                                    ),
                                  );
                                },
                                trailing: Lottie.asset(
                                  "images/lotties/lottie_arrow.json",
                                  height: 30.0,
                                ),
                                leading: Lottie.asset(
                                  controller
                                      .choosecategories(controller
                                          .transactioncategorie)[index]
                                      .lottie,
                                  width: 35.0,
                                ),
                              ),
                              index <
                                      controller
                                              .choosecategories(controller
                                                  .transactioncategorie)
                                              .length -
                                          1
                                  ? const Divider(
                                      color: Colors.grey,
                                      thickness: 1.0,
                                      indent: 20.0,
                                      endIndent: 20.0,
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
