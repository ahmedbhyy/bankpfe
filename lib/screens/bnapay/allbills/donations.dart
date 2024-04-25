import 'package:bankpfe/controllers/pay_controllers/donation_controller.dart';
import 'package:bankpfe/screens/bnapay/allbills/donation_details.dart';
import 'package:bankpfe/slides/slide_right.dart';
import 'package:bankpfe/widgets/donations/card_donations.dart';
import 'package:bankpfe/widgets/generalwidgets/common_loading_progress.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class Donations extends StatelessWidget {
  const Donations({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DonationControllerImp());
    return GetBuilder<DonationControllerImp>(
      builder: (controller) => Scaffold(
        body: ContainerBackground(
          mywidget: SafeArea(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              children: [
                const AppBarCommon(title: "Donations"),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discover Compaign",
                        style: GoogleFonts.mulish(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Image.asset(
                        "images/donate1.png",
                        height: 40.0,
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        controller.categoriesdonation.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
                            vertical: 20.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              controller.updateColor(index);

                              controller.choosecategories(
                                controller.donationtitle,
                              );
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 22.0,
                                  backgroundColor:
                                      controller.isSelectedList[index]
                                          ? const Color(0xff00aa86)
                                          : const Color.fromARGB(
                                              134, 139, 136, 165),
                                  child: controller.categoriesdonation[index]
                                      ["myicon"],
                                ),
                                const SizedBox(height: 6.0),
                                Text(
                                  "${controller.categoriesdonation[index]["mytitle"]}",
                                  style: GoogleFonts.mulish(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 2, 106, 83),
                                  ),
                                ),
                                const SizedBox(height: 6.0),
                                controller.isSelectedList[index]
                                    ? AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        height: 5.0,
                                        width: 20.0,
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.donationtitle,
                        style: GoogleFonts.mulish(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Image.asset(
                        "images/donate.png",
                        height: 40.0,
                      )
                    ],
                  ),
                ),
                controller.isloading
                    ? const CommonLoading()
                    : controller
                            .choosecategories(controller.donationtitle)
                            .isEmpty
                        ? Lottie.asset(
                            "images/lotties/lottie_empty.json",
                            height: 200.0,
                          )
                        : GridView.count(
                            shrinkWrap: true,
                            childAspectRatio: 0.61,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            children: [
                              ...List.generate(
                                controller
                                    .choosecategories(controller.donationtitle)
                                    .length,
                                    
                                (index) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      SlideRight(
                                        page: DonationDetails(
                                          donationmodel:
                                              controller.choosecategories(
                                            controller.donationtitle,
                                          )[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: CardDonations(
                                    myimage: controller.choosecategories(
                                            controller.donationtitle,
                                          )[index].donationimage,
                                    mytitle: controller.choosecategories(
                                            controller.donationtitle,
                                          )[index].title,
                                    myamount: controller.choosecategories(
                                            controller.donationtitle,
                                          )[index].currentamount,
                                    mydays:
                                        controller.choosecategories(
                                            controller.donationtitle,
                                          )[index].daysleft,
                                    bywho:
                                        controller.choosecategories(
                                            controller.donationtitle,
                                          )[index].orgonizedby,
                                    estimateamount:
                                        controller.choosecategories(
                                            controller.donationtitle,
                                          )[index].totalamount,
                                  ),
                                ),
                              ),
                            ],
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
