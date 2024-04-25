import 'package:bankpfe/controllers/profil_controllers/settings/contact_bna_controller.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class ContactBna extends StatelessWidget {
  const ContactBna({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ContactBnaControllerImp());
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: GetBuilder<ContactBnaControllerImp>(
            builder: (controller) => ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              children: [
                const AppBarCommon(title: "Contact BNA"),
                SizedBox(
                  height: 250.0,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Stack(
                      children: [
                        ClipRRect(
                          key: UniqueKey(),
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            "images/${controller.bnaimages[controller.currectindex]}.jpg",
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: MediaQuery.of(context).size.width / 2.5,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height / 6.0,
                          right: MediaQuery.of(context).size.width / 2.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(
                                controller.bnaimages.length,
                                (index) => AnimatedContainer(
                                  margin: const EdgeInsets.only(right: 5.0),
                                  duration: const Duration(milliseconds: 900),
                                  width:
                                      controller.currectindex == index ? 20 : 5,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    shape: BoxShape.circle,
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
                CommonContainerBills(
                  mywidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "We're here to assist you in any way we can. Reach out to us via Facebook, Instagram, email, or phone to connect with our dedicated customer support team. Whether you have questions about your account, need help with our services, or want to provide feedback, we're ready to assist you. ",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Color.fromARGB(255, 130, 121, 121),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            controller.lottiesbna.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: InkWell(
                                onTap: () async {
                                  index == 3
                                      ? await controller
                                          .callphone(controller.bnaurl[3])
                                      : await controller.launchurl(
                                          Uri.parse(
                                            controller.bnaurl[index],
                                          ),
                                        );
                                },
                                child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor:
                                      const Color.fromARGB(255, 211, 209, 203),
                                  child: Lottie.asset(
                                      "images/lotties/${controller.lottiesbna[index]}.json"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
