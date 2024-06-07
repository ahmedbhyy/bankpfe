import 'package:bankpfe/controllers/admin_controller/admin_send_token_notification_controller.dart';

import 'package:bankpfe/functions/sendnotification_token.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/authwidgets/textfield_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminSendTokenNotifications extends StatelessWidget {
  final String usertoken;
  const AdminSendTokenNotifications({super.key, required this.usertoken});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminSendNotifitokenControllerImp());
    return GetBuilder<AdminSendNotifitokenControllerImp>(
      builder: (controller) => Form(
        key: controller.formStatenotification,
        child: Scaffold(
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
                  title: "Send Notifications",
                  lottie: "images/lotties/lottie_onlinepayment.json",
                ),
                Image.asset(
                  "images/notifications.png",
                ),
                TextFieldAuth(
                  hint: "Notification Title",
                  mycontroller: controller.notificationtitle!,
                  myicon: const Icon(Icons.title),
                  ispass: false,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't to be empty ";
                    }
                    return null;
                  },
                  mytype: TextInputType.text,
                  readonly: false,
                ),
                TextFieldAuth(
                  hint: "Notification Description",
                  mycontroller: controller.notificationdescription!,
                  myicon: const Icon(Icons.description_outlined),
                  ispass: false,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't to be empty ";
                    }
                    return null;
                  },
                  mytype: TextInputType.text,
                  readonly: false,
                ),
                const SizedBox(height: 40.0),
                ButtonAuth(
                  mytitle: "Send",
                  myfunction: () async {
                    if (controller.formStatenotification.currentState!
                        .validate()) {
                      await sendNotificationToken(
                        controller.notificationtitle!.text,
                        controller.notificationdescription!.text,
                        usertoken,
                      );
                      Get.back();
                      Get.rawSnackbar(
                        title: "Success",
                        message:
                            "We have send this notification to this BNA client",
                        backgroundColor: Colors.green,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
