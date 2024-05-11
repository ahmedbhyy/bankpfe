import 'package:bankpfe/controllers/pay_controllers/donation_details_controller.dart';
import 'package:bankpfe/data/Model/donation_model.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/authwidgets/textfield_auth.dart';
import 'package:bankpfe/widgets/donations/dialog_donation.dart';
import 'package:bankpfe/widgets/donations/donation_detail_common_container.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class DonationDetails extends StatelessWidget {
  final DonationModel donationmodel;
  const DonationDetails({
    super.key,
    required this.donationmodel,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(DonationsDetailsControllerImp());
    return GetBuilder<DonationsDetailsControllerImp>(
      builder: (controller) => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.dialog(
              Form(
                key: controller.formStatedonation,
                child: Dialog(
                  backgroundColor: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          donationmodel.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff00aa86),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Description : ${donationmodel.description}",
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Choose your card",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff00aa86),
                                  fontSize: 17.0,
                                ),
                              ),
                              Icon(Icons.card_membership_outlined),
                            ],
                          ),
                        ),
                        const DonationDialog(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFieldAuth(
                            hint: "Amount",
                            readonly: false,
                            mysuffix: "TND",
                            mycontroller: controller.amount!,
                            myicon: const Icon(Icons.money,
                                color: Color(0xff00aa86)),
                            ispass: false,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Can't to be empty ";
                              } else if (!val.isNumericOnly) {
                                return "Please write an amount";
                              }
                              return null;
                            },
                            mytype: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: ButtonAuth(
                            mytitle: "Donate",
                            myfunction: () {
                              if (controller.formStatedonation.currentState!
                                  .validate()) {
                                controller.donateverify(donationmodel.title,
                                    controller.amount!.text);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
