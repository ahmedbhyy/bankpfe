import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bankpfe/controllers/homecontroller/notifications_controller.dart';
import 'package:bankpfe/widgets/generalwidgets/common_loading_progress.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/generalwidgets/common_container_background.dart';
import '../../widgets/generalwidgets/common_row_appbar.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationsControllerImp());
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              const AppBarCommon(title: "Notifications"),
              Image.asset(
                "images/notifications.png",
              ),
              GetBuilder<NotificationsControllerImp>(
                builder: (controller) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  padding: const EdgeInsets.all(5.0),
                  height: MediaQuery.of(context).size.height / 2.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: controller.isloading
                      ? const CommonLoading()
                      : controller.userData.isEmpty
                          ? Lottie.asset("images/lotties/lottie_empty.json",
                              height: 50.0)
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.userData.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                        controller.userData[index]["title"]),
                                    titleTextStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: Color.fromARGB(255, 94, 161, 216),
                                    ),
                                    subtitle: Text(controller.userData[index]
                                        ["description"]),
                                    onTap: () {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.question,
                                        animType: AnimType.rightSlide,
                                        title: 'Confirme Delete',
                                        btnOkText: "Confirm",
                                        desc:
                                            'Are you sure to delete this notification',
                                        descTextStyle:
                                            const TextStyle(fontSize: 18),
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () async {
                                          controller.deleteusernotifications(
                                              controller.userData[index]['id'],
                                              index);
                                        },
                                      ).show();
                                    },
                                    leading: const Icon(
                                      Icons.notifications_active_outlined,
                                      color: Color.fromARGB(255, 13, 135, 94),
                                    ),
                                    trailing: Text(
                                      " ${controller.userData[index]["date"].toDate().toString().substring(0, 10)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(118, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                  index < controller.userData.length - 1
                                      ? const Divider(
                                          color: Colors.grey,
                                          thickness: 1.0,
                                          indent: 20.0,
                                          endIndent: 20.0,
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
      ),
    );
  }
}
