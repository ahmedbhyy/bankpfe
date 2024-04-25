import 'package:bankpfe/controllers/profil_controllers/settings/help_controller.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/authwidgets/textfield_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:bankpfe/widgets/generalwidgets/common_loading_progress.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class HelpSettings extends StatelessWidget {
  const HelpSettings({super.key});

  @override
  Widget build(BuildContext context) {
    HelpControllerImp controller = Get.put(HelpControllerImp());

    return Form(
      key: controller.formStatereport,
      child: Scaffold(
        body: GetBuilder<HelpControllerImp>(
          builder: (controller) => ContainerBackground(
            mywidget: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 15.0),
                children: [
                  const AppBarCommon(title: "Report"),
                  const SizedBox(height: 20.0),
                  Image.asset("images/logobna.png", height: 150.0),
                  CommonContainerBills(
                    mywidget: Column(
                      children: [
                        const Text(
                          "Your feedback matters! This is your space to report any concerns, share feedback, or seek assistance with any aspect of our services. Whether it's a technical glitch, a suggestion for improvement, or an inquiry about your account, we're here to listen and help. Your input helps us continually enhance your banking experience. Don't hesitate to reach out - we're committed to addressing your needs promptly and effectively.",
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Color.fromARGB(255, 130, 121, 121),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10.0),
                        TextFieldAuth(
                          hint: "Your feedback",
                          readonly: false,
                          mytype: TextInputType.text,
                          mycontroller: controller.helpcontroller,
                          myicon: const Icon(Icons.report_gmailerrorred_sharp),
                          ispass: false,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Can't to be empty ";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30.0),
                        controller.isloading
                            ? const CommonLoading()
                            : ButtonAuth(
                                mytitle: "Send Report",
                                myfunction: () {
                                  if (controller.formStatereport.currentState!
                                      .validate()) {
                                    controller.sendreport();
                                  }
                                },
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
      ),
    );
  }
}
