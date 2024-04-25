import 'package:bankpfe/controllers/pay_controllers/electric_controller.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_background.dart';
import 'package:bankpfe/widgets/generalwidgets/common_row_appbar.dart';
import 'package:bankpfe/widgets/generalwidgets/lotties.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/generalwidgets/common_container_bills.dart';

class ElectricBill extends StatelessWidget {
  final String title;
  final bool isPayed;
  const ElectricBill({super.key, required this.title, required this.isPayed});

  @override
  Widget build(BuildContext context) {
    ElectricControllerImp controller = Get.put(ElectricControllerImp());
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              AppBarCommon(title: title),
              const MyLottie(
                mylottie: "images/lotties/lottie_electric.json",
                lottieheight: 200.0,
                isrepeated: false,
              ),
              CommonContainerBills(
                mywidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All the Bills",
                          style: GoogleFonts.mulish(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        isPayed
                            ? Text(
                                "Status: Payed",
                                style: GoogleFonts.mulish(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 5, 116, 66),
                                ),
                              )
                            : Text(
                                "Status: UnPayed",
                                style: GoogleFonts.mulish(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 224, 5, 5),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ...List.generate(
                      controller.userinfo.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            index == controller.userinfo.length - 1
                                ? Text(
                                    controller.userinfo[index],
                                    style: GoogleFonts.mulish(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  )
                                : Text(
                                    controller.userinfo[index],
                                    style: GoogleFonts.mulish(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                            index == controller.userinfo.length - 3 ||
                                    index == controller.userinfo.length - 2
                                ? const Text(
                                    "470.000 TND",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 60, 4, 214),
                                    ),
                                  )
                                : index == controller.userinfo.length - 1
                                    ? const Text(
                                        "480.000 TND",
                                        style: TextStyle(
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      )
                                    : const Text(
                                        "aaa",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              !isPayed
                  ? ButtonAuth(
                      mytitle: "Pay",
                      myfunction: () {
                        controller.payelectric();
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
