import 'package:bankpfe/controllers/homecontroller/transaction_details_controller.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/generalwidgets/common_container_background.dart';
import '../../widgets/generalwidgets/common_row_appbar.dart';

class TransactionDetails extends StatelessWidget {
  final String mytype;
  final String mylottie;
  final String mytitle;

  const TransactionDetails(
      {super.key, required this.mytype, required this.mylottie, required this.mytitle});

  @override
  Widget build(BuildContext context) {
    Get.put(TransactionDetailsControllerImp());
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              AppBarCommon(title: mytype),
              Image.asset(
                "images/transfer.png",
              ),
              GetBuilder<TransactionDetailsControllerImp>(
                builder: (controller) => CommonContainerBills(
                  mywidget: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            mytitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 1, 79, 62),
                            ),
                          ),
                          Lottie.asset(mylottie, height: 35.0),
                        ],
                      ),
                      ...List.generate(
                        controller.transactioninfo.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              index == controller.transactioninfo.length - 1
                                  ? Text(
                                      controller.transactioninfo[index],
                                      style: GoogleFonts.mulish(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(
                                      controller.transactioninfo[index],
                                      style: GoogleFonts.mulish(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                              index == controller.transactioninfo.length - 1
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
                                        fontSize: 14.0,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
