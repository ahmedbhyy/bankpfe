import 'package:bankpfe/controllers/profil_controllers/profil_controller.dart';
import 'package:bankpfe/widgets/generalwidgets/common_row_appbar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/generalwidgets/common_container_listtile.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilControllerImp controller = Get.put(ProfilControllerImp());
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
        children: [
          const AppBarCommon(title: "My Profil"),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: MediaQuery.of(context).size.width / 4.0),
            child: CircleAvatar(
              radius: 80.0,
              backgroundImage: NetworkImage(controller.imageFile),
              backgroundColor: Colors.white,
            ),
          ),
          ...List.generate(
            controller.categoriesprofil.length,
            (index) => ContainerListTile(
              mypage: controller.categoriespages[index],
              ispayed: true,
              title: controller.categoriesprofil[index],
              mysubtitle: controller.categoriesprofildescription[index],
              myimage: "images/${controller.categoriesprofilimages[index]}.png",
            ),
          ),
          InkWell(
            onTap: () {
              controller.logout();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "images/lotties/lottie_logout.json",
                  height: 50.0,
                  repeat: false,
                ),
                Text(
                  'Log Out',
                  style: GoogleFonts.mulish(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 1, 100, 78),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
