import 'package:bankpfe/controllers/profil_controllers/edit_profil_controller.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/authwidgets/textfield_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:bankpfe/widgets/generalwidgets/common_loading_progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../widgets/generalwidgets/common_container_background.dart';
import '../../widgets/generalwidgets/common_row_appbar.dart';

class EditProfil extends StatelessWidget {
  const EditProfil({super.key});

  @override
  Widget build(BuildContext context) {
    EditProfilImp mycontroller = Get.put(EditProfilImp());
    return Form(
      key: mycontroller.formState,
      child: Scaffold(
        body: ContainerBackground(
          mywidget: SafeArea(
            child: GetBuilder<EditProfilImp>(
              builder: (controller) => ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 15.0),
                children: [
                  const AppBarCommon(title: "Edit Profil"),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 80.0,
                          backgroundImage: NetworkImage(controller.image),
                          backgroundColor: Colors.white,
                        ),
                        Positioned(
                          bottom: 5.0,
                          right: -10.0,
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) =>
                                    controller.bottomSheet(context)),
                              );
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                            iconSize: 25.0,
                            color: const Color.fromARGB(255, 1, 74, 45),
                          ),
                        )
                      ],
                    ),
                  ),
                  controller.isloading2
                      ? const CommonLoading()
                      : CommonContainerBills(
                          mywidget: Column(
                          children: [
                            ...List.generate(
                              controller.mylist.length,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextFieldAuth(
                                  hint: controller.mylist[index]["hint"],
                                  mytype: TextInputType.text,
                                  mycontroller: controller.mycontrollers[index],
                                  myicon: controller.mylist[index]["myicon"],
                                  ispass: false,
                                  readonly: controller.mylist[index]
                                      ["readonly"],
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Can't to be empty ";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: SizedBox(
                                height: 70.0,
                                child: IntlPhoneField(
                                  controller: controller.phone,
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  initialCountryCode: 'TN',
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Birthday date :",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 1, 130, 102),
                                  ),
                                ),
                                SizedBox(
                                  height: 100.0,
                                  child: ScrollDatePicker(
                                    selectedDate: controller.birthday.toDate(),
                                    locale: const Locale('en'),
                                    onDateTimeChanged: (DateTime value) {
                                      controller.birthday =
                                          Timestamp.fromDate(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30.0),
                            controller.isloading1
                                ? const CommonLoading()
                                : ButtonAuth(
                                    mytitle: "Save",
                                    myfunction: () {
                                      if (controller.formState.currentState!
                                          .validate()) {
                                        controller.saveUserData();
                                      }
                                    },
                                  ),
                            const SizedBox(height: 10.0),
                          ],
                        ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
