import 'package:bankpfe/controllers/pay_controllers/pay_controller.dart';

import 'package:bankpfe/widgets/generalwidgets/common_container_listtile.dart';
import 'package:bankpfe/widgets/generalwidgets/common_row_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsControllerImp controller = Get.put(SettingsControllerImp());
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        children: [
          const AppBarCommon(title: "Pay with BNA"),
          const SizedBox(height: 20.0),
          ...List.generate(
            controller.categories.length,
            (index) => ContainerListTile(
              mypage: controller.pagespay[index],
              title: controller.categories[index],
              ispayed: true,
              mysubtitle: index == controller.categories.length - 1
                  ? "Donate and save lifes with BNA"
                  : index == controller.categories.length - 2
                      ? "Send money with BNA App"
                      : "Pay ${controller.categories[index]} for this month",
              myimage: "images/${controller.imagescateg[index]}.png",
            ),
          ),
        ],
      ),
    );
  }
}
