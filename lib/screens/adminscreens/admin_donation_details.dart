import 'package:bankpfe/controllers/admin_controller/admin_donation_details_controller.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../data/Model/donation_model.dart';
import '../../widgets/generalwidgets/common_appbar.dart';

class AdminDonationsDetails extends StatelessWidget {
  final DonationModel mydonation;
  const AdminDonationsDetails({super.key, required this.mydonation});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminDonationsDetailsControllerImp());
    return GetBuilder<AdminDonationsDetailsControllerImp>(
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
              const CommonAppBar(
                title: "Donation",
                lottie: "images/lotties/lottie_onlinepayment.json",
              ),
              CachedNetworkImage(
                imageUrl: mydonation.donationimage,
                height: 200.0,
                width: 200.0,
                placeholder: (context, url) => Lottie.asset(
                  "images/lotties/lottie_loading.json",
                  height: 50.0,
                ),
              ),
              CommonContainerBills(
                mywidget: Column(
                  children: [
                    MyRow(
                      myobject: mydonation.title,
                      title: "Title",
                    ),
                    MyRow(
                      myobject: mydonation.description,
                      title: "Description",
                    ),
                    MyRow(
                      myobject: "${mydonation.totalamount} TND",
                      title: "Total Amount",
                    ),
                    MyRow(
                      myobject: "${mydonation.currentamount} TND",
                      title: "Current amount",
                    ),
                    MyRow(
                      myobject: mydonation.givers.toString(),
                      title: "Givers",
                    ),
                    MyRow(
                      myobject: mydonation.orgonizedby,
                      title: "Orgonizedby",
                    ),
                    MyRow(
                      myobject: mydonation.type,
                      title: "Type",
                    ),
                    MyRow(
                      myobject: "${mydonation.daysleft} days",
                      title: "Days left",
                    ),
                  ],
                ),
              ),
              ButtonAuth(
                mytitle: "Delete",
                myfunction: () {
                  controller.deletedontaion(mydonation.donationid);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyRow extends StatelessWidget {
  final String myobject;
  final String title;
  const MyRow({super.key, required this.myobject, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 73, 111, 75),
            ),
          ),
          Text(myobject),
        ],
      ),
    );
  }
}
