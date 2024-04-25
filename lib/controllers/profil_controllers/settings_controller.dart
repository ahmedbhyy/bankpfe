import 'package:bankpfe/screens/profil_screen/settingspages/change_pass.dart';
import 'package:bankpfe/screens/profil_screen/settingspages/contact_bna.dart';
import 'package:bankpfe/screens/profil_screen/settingspages/help.dart';
import 'package:bankpfe/screens/profil_screen/settingspages/language.dart';
import 'package:bankpfe/screens/profil_screen/settingspages/privacy.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

abstract class SettingsControllerProfil extends GetxController {
  updateswitcher(bool switcher);
}

class SettingsControllerProfilImp extends SettingsControllerProfil {
  bool notification = true;

  List<String> settingsprofil = [
    "Change Password",
    "Language",
    "Privacy",
    "Report",
    "Contact BNA",
  ];

  List<Icon> myicons = [
    const Icon(Icons.key_rounded),
    const Icon(Icons.language),
    const Icon(Icons.privacy_tip_outlined),
    const Icon(Icons.report),
    const Icon(Icons.contact_phone_outlined),
  ];

  List<Widget> mywidgets = [
    const ChangePassword(),
    const Language(),
    const Privacy(),
    const HelpSettings(),
    const ContactBna(),
  ];

  @override
  updateswitcher(switcher) {
    notification = switcher;
    update();
  }
}
