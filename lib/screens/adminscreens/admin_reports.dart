import 'package:bankpfe/controllers/admin_controller/admin_reports_controller.dart';
import 'package:bankpfe/widgets/generalwidgets/common_appbar.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AdminReports extends StatelessWidget {
  const AdminReports({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminReportsControllerImp());
    return GetBuilder<AdminReportsControllerImp>(
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
                const EdgeInsets.symmetric(horizontal: 11.0, vertical: 20.0),
            children: [
              const CommonAppBar(
                title: "Clients Reports",
                lottie: "images/lotties/lottie_onlinepayment.json",
              ),
              controller.isloading
                  ? Center(
                      child: Lottie.asset(
                        "images/lotties/lottie_loading.json",
                        height: 50.0,
                      ),
                    )
                  : controller.myreports.isEmpty
                      ? Lottie.asset(
                          "images/lotties/lottie_empty.json",
                        )
                      : Column(
                          children: [
                            ...List.generate(
                              controller.myreports.length,
                              (index) => CommonContainerBills(
                                mywidget: ListTile(
                                  title: Text(
                                      controller.myreports[index].useremail),
                                  subtitle: Text(
                                      "Description: ${controller.myreports[index].repport}\ndate: ${controller.myreports[index].reportdate.toDate()}"),
                                  leading: const Icon(
                                    Icons.person_2_outlined,
                                    color: Color.fromARGB(255, 109, 163, 111),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
            ],
          ),
        ),
      ),
    );
  }
}
