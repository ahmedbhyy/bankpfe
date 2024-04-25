import 'package:bankpfe/controllers/profil_controllers/settings/language_controller.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LanguageControllerImp());
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              const AppBarCommon(title: "Languages"),
              Image.asset(
                "images/language.png",
                height: 200.0,
              ),
              GetBuilder<LanguageControllerImp>(
                builder: (controller) => CommonContainerBills(
                    mywidget: Column(
                  children: [
                    const Text(
                      "Choose Your Language",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 13, 98, 78),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    ...List.generate(
                      controller.languages.length,
                      (index) => SizedBox(
                        height: 70.0,
                        child: Card(
                          elevation: 5.0,
                          color: Colors.white,
                          margin: const EdgeInsets.all(10.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: InkWell(
                              onTap: () {
                                controller.updateColor(index);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.languages[index],
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: controller.isSelectedList[index]
                                          ? const Color.fromARGB(255, 1, 42, 43)
                                          : const Color.fromARGB(
                                              255, 99, 150, 151),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  AnimatedContainer(
                                    width: 20.0,
                                    decoration: BoxDecoration(
                                      color: controller.isSelectedList[index]
                                          ? Colors.grey
                                          : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    duration: const Duration(milliseconds: 300),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
