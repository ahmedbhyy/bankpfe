import 'package:bankpfe/controllers/profil_controllers/settings_controller.dart';
import 'package:bankpfe/slides/slide_right.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:bankpfe/widgets/generalwidgets/container_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/generalwidgets/common_container_background.dart';
import '../../widgets/generalwidgets/common_row_appbar.dart';

class SettingsProfil extends StatelessWidget {
  const SettingsProfil({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsControllerProfilImp());
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              const AppBarCommon(title: "Settings"),
              const SizedBox(height: 20.0),
              Image.asset(
                "images/settings.png",
                filterQuality: FilterQuality.high,
                height: 200.0,
              ),
              GetBuilder<SettingsControllerProfilImp>(
                builder: (controller) => CommonContainerBills(
                  mywidget: Column(
                    children: [
                      ContainerSettings(
                        mywidget: Switch(
                          value: controller.notification,
                          onChanged: (bool value) {
                            controller.updateswitcher(value);
                          },
                        ),
                        myicon: controller.notification
                            ? const Icon(Icons.notifications_active_outlined)
                            : const Icon(Icons.notifications_none_outlined),
                        mytext: "Notifications",
                      ),
                      ...List.generate(
                        controller.settingsprofil.length,
                        (index) => InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              SlideRight(
                                page: controller.mywidgets[index],
                              ),
                            );
                          },
                          child: ContainerSettings(
                            mywidget: Lottie.asset(
                              "images/lotties/lottie_arrow.json",
                              height: 40.0,
                            ),
                            mytext: controller.settingsprofil[index],
                            myicon: controller.myicons[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
