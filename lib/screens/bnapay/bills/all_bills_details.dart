import 'package:bankpfe/controllers/pay_controllers/bills_details_controller.dart';
import 'package:bankpfe/data/Model/bill_model.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_background.dart';
import 'package:bankpfe/widgets/generalwidgets/common_row_appbar.dart';
import 'package:bankpfe/widgets/generalwidgets/lotties.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/generalwidgets/common_container_bills.dart';

class BillsDetails extends StatelessWidget {
  final BillModel mybill;
  const BillsDetails({
    super.key,
    required this.mybill,
  });

  @override
  Widget build(BuildContext context) {
    AllBillsDetailsControllerImp controller =
        Get.put(AllBillsDetailsControllerImp());
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              AppBarCommon(title: mybill.title),
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
                          "My Bill",
                          style: GoogleFonts.mulish(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        mybill.ispayed
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
                            index == controller.userinfo.length - 1
                                ? Text(
                                    "${mybill.amount} TND",
                                    style: GoogleFonts.mulish(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff00aa86),
                                    ),
                                  )
                                : Text(
                                    index == controller.userinfo.length - 2
                                        ? mybill.adress
                                        : index ==
                                                controller.userinfo.length - 4
                                            ? mybill.date
                                                .toDate()
                                                .toString()
                                                .substring(0, 16)
                                            : index ==
                                                    controller.userinfo.length -
                                                        5
                                                ? mybill.code
                                                : index ==
                                                        controller.userinfo
                                                                .length -
                                                            6
                                                    ? mybill.title
                                                    : index ==
                                                            controller.userinfo
                                                                    .length -
                                                                3
                                                        ? mybill.type
                                                        : "",
                                    style: const TextStyle(
                                      fontSize: 15.0,
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
              !mybill.ispayed
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
