import 'package:bankpfe/controllers/pay_controllers/donation_details_controller.dart';
import 'package:bankpfe/data/Model/account_model.dart';

import 'package:bankpfe/screens/bnapay/allbills/donation_pay.dart';
import 'package:bankpfe/data/Model/donation_model.dart';

import 'package:bankpfe/widgets/donations/donation_detail_common_container.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class DonationDetails extends StatelessWidget {
  final DonationModel donationmodel;
  final List<AccountModel> myaccount;

  const DonationDetails({
    super.key,
    required this.donationmodel,
    required this.myaccount,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(DonationsDetailsControllerImp());
    return GetBuilder<DonationsDetailsControllerImp>(
      builder: (controller) => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(
              () => DonationPay(
                myaccounts: myaccount,
                mydonation: donationmodel,
              ),
            );
          },
          backgroundColor: const Color(0xff00aa86),
          label: Row(
            children: [
              Image.asset(
                "images/donate.png",
                width: 40.0,
              ),
              Text(
                "Donate",
                style: GoogleFonts.mulish(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ContainerBackground(
          mywidget: SafeArea(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              children: [
                const AppBarCommon(title: "Donation Details"),
                Hero(
                  tag: donationmodel.donationimage,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                        imageUrl: donationmodel.donationimage,
                        height: 200.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                DonationDetailsContainer(
                  donationmodel.title,
                  donationmodel.givers,
                  donationmodel.currentamount,
                  donationmodel.totalamount,
                  donationmodel.orgonizedby,
                  donationmodel.orgonizedbydescription,
                  donationmodel.description,
                  donationmodel.place,
                  donationmodel.orgonizedbyimage,
                  donationmodel.orgonizedbylink,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
