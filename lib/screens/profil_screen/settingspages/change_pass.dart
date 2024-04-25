import 'package:bankpfe/controllers/profil_controllers/settings/change_pass_controller.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';

import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:bankpfe/widgets/generalwidgets/common_loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChangePassControllerImp());
    return GetBuilder<ChangePassControllerImp>(
      builder: (controller) => Form(
        key: controller.formStatechangepassword,
        child: Scaffold(
          body: ContainerBackground(
            mywidget: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 15.0),
                children: [
                  const AppBarCommon(title: "Change Password"),
                  Image.asset(
                    "images/editprofil.png",
                    filterQuality: FilterQuality.high,
                    height: 200.0,
                  ),
                  CommonContainerBills(
                    mywidget: Column(
                      children: [
                        const Text(
                          "To ensure the security of your account We'll send you an email with instructions on how to reset your password. Your safety and privacy are our top priorities, and this additional verification step helps us protect your account from unauthorized access. Thank you for your cooperation in maintaining the security of your personal information.",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color.fromARGB(255, 130, 121, 121),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30.0),
                        controller.isloading
                            ? const CommonLoading()
                            : ButtonAuth(
                                mytitle: "Send",
                                myfunction: () {
                                  if (controller
                                      .formStatechangepassword.currentState!
                                      .validate()) {
                                    controller.sendemail();
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
