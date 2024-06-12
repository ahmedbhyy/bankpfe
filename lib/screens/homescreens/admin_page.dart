import 'package:bankpfe/controllers/homecontroller/admin_page_controller.dart';
import 'package:bankpfe/screens/adminscreens/admin_donations.dart';
import 'package:bankpfe/screens/adminscreens/admin_reports.dart';
import 'package:bankpfe/screens/adminscreens/admin_user_details.dart';
import 'package:bankpfe/screens/adminscreens/send_notifications.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/admin_controller/admin_user_details_controller.dart';
import '../../functions/alert_exit.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminPageControllerImp());
    AdminUserDetailsControllerImp myusercontroller =
        Get.put(AdminUserDetailsControllerImp());
    return GetBuilder<AdminPageControllerImp>(
      builder: (controller) =>
          // ignore: deprecated_member_use
          WillPopScope(
        onWillPop: () async {
          return await alertexit();
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.to(() => const AdminDonations());
            },
            backgroundColor: const Color.fromARGB(255, 126, 164, 128),
            label: const Text(
              "Donations",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Welcome Admin",
                      style: GoogleFonts.mulish(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 1, 100, 78),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(() => const AdminReports());
                          },
                          icon: const Icon(
                            Icons.report_gmailerrorred,
                            color: Color.fromARGB(255, 104, 132, 105),
                          ),
                          iconSize: 28.0,
                        ),
                        IconButton(
                          onPressed: () {
                            Get.to(() => const AdminSendNotifications());
                          },
                          icon: const Icon(
                            Icons.notifications_active_outlined,
                            color: Color.fromARGB(255, 104, 132, 105),
                          ),
                          iconSize: 28.0,
                        ),
                      ],
                    )
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Search",
                    icon: Icon(Icons.search),
                  ),
                  controller: controller.searchcontroller,
                  onChanged: (val) {
                    controller.search = val;
                    controller.searchclient(val);
                  },
                ),
                controller.isloading
                    ? Center(
                        child: Lottie.asset(
                          "images/lotties/lottie_loading.json",
                          height: 50.0,
                        ),
                      )
                    : controller.users.isEmpty
                        ? Lottie.asset("images/lotties/lottie_empty.json")
                        : Column(
                            children: [
                              ...List.generate(
                                controller
                                    .searchclient(controller.search)
                                    .length,
                                (index) => CommonContainerBills(
                                  mywidget: ListTile(
                                    title: Text(
                                      controller
                                          .searchclient(
                                              controller.search)[index]
                                          .username,
                                      style: const TextStyle(fontSize: 20.0),
                                    ),
                                    onTap: () {
                                      Get.to(
                                        AdminUserDetails(
                                          myuser: controller.searchclient(
                                              controller.search)[index],
                                        ),
                                      );
                                      myusercontroller.fetchusercard(controller
                                          .searchclient(
                                              controller.search)[index]
                                          .userid);
                                    },
                                    subtitle: Text(controller
                                        .searchclient(controller.search)[index]
                                        .email),
                                    leading: const Icon(
                                      Icons.person_2_outlined,
                                      color: Color.fromARGB(255, 107, 149, 108),
                                    ),
                                    trailing: Lottie.asset(
                                        "images/lotties/lottie_arrow.json",
                                        height: 40.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                const SizedBox(
                  height: 20.0,
                ),
                ButtonAuth(
                  mytitle: "Sign Out",
                  myfunction: () {
                    controller.logout();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
