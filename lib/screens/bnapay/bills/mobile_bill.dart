import 'package:bankpfe/controllers/pay_controllers/mobile_controller.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/generalwidgets/common_container_bills.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class MobileBill extends StatelessWidget {
  final String title;
  const MobileBill({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    MobileControllerImp controller = Get.put(MobileControllerImp());
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              AppBarCommon(title: title),
              Image.asset(
                "images/mobile1.png",
                height: 200.0,
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
                        Text(
                          "Payed",
                          style: GoogleFonts.mulish(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 9, 179, 102),
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
            ],
          ),
        ),
      ),
    );
  }
}
