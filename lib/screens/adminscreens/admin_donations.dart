import 'package:bankpfe/controllers/admin_controller/admin_donation_controller.dart';
import 'package:bankpfe/screens/adminscreens/add_donation.dart';
import 'package:bankpfe/screens/adminscreens/admin_donation_details.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/generalwidgets/common_appbar.dart';

class AdminDonations extends StatelessWidget {
  const AdminDonations({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminDonationsControllerImp());
    return GetBuilder<AdminDonationsControllerImp>(
      builder: (controller) => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => const AddDonation());
          },
          backgroundColor: const Color.fromARGB(255, 126, 164, 128),
          label: const Text(
            "Add a donation",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                title: "Donations",
                lottie: "images/lotties/lottie_onlinepayment.json",
              ),
              controller.isloading
                  ? Lottie.asset("images/lotties/lottie_loading.json",
                      height: 50.0)
                  : controller.mydonations.isEmpty
                      ? Lottie.asset("images/lotties/lottie_empty.json")
                      : Column(
                          children: [
                            ...List.generate(
                              controller.mydonations.length,
                              (index) => CommonContainerBills(
                                mywidget: ListTile(
                                  title:
                                      Text(controller.mydonations[index].title),
                                  subtitle: Text(controller
                                      .mydonations[index].description),
                                  trailing: Text(
                                    "${controller.mydonations[index].totalamount} TND",
                                  ),
                                  onTap: () {
                                    Get.to(
                                      () => AdminDonationsDetails(
                                        mydonation:
                                            controller.mydonations[index],
                                      ),
                                    );
                                  },
                                  leading: CachedNetworkImage(
                                    imageUrl: controller
                                        .mydonations[index].donationimage,
                                    height: 60.0,
                                    width: 60.0,
                                    placeholder: (context, url) => Lottie.asset(
                                      "images/lotties/lottie_loading.json",
                                      height: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
