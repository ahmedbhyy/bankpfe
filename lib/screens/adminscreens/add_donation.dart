import 'package:bankpfe/controllers/admin_controller/admin_add_donation_controller.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/authwidgets/textfield_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/generalwidgets/common_appbar.dart';

class AddDonation extends StatelessWidget {
  const AddDonation({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminDonationsAddControllerImp());
    return GetBuilder<AdminDonationsAddControllerImp>(
      builder: (controller) => Form(
        key: controller.donationkey,
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
                  const EdgeInsets.symmetric(horizontal: 11.0, vertical: 5.0),
              children: [
                const CommonAppBar(
                  title: "Add Donation",
                  lottie: "images/lotties/lottie_onlinepayment.json",
                ),
                TextFieldAuth(
                  hint: "Title",
                  mycontroller: controller.title!,
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
                  hint: "Description",
                  mycontroller: controller.description!,
                  myicon: const Icon(Icons.description),
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
                  hint: "Place",
                  mycontroller: controller.place!,
                  myicon: const Icon(Icons.place_outlined),
                  ispass: false,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't be empty";
                    }
                    const pattern = r'^https:\/\/(www\.)?google\.com\/maps\/';
                    final regExp = RegExp(pattern);

                    if (!regExp.hasMatch(val)) {
                      return 'Please enter a valid Google Maps link';
                    }
                    return null;
                  },
                  mytype: TextInputType.text,
                  readonly: false,
                ),
                TextFieldAuth(
                  hint: "Orgonized By",
                  mycontroller: controller.orgonizedby!,
                  myicon: const Icon(Icons.description),
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
                  hint: "Orgonized by link",
                  mycontroller: controller.orgonizedbylink!,
                  myicon: const Icon(Icons.link),
                  ispass: false,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't be empty";
                    }
                    const pattern = r'^(http|https):\/\/[^\s$.?#].[^\s]*$';
                    final regExp = RegExp(pattern);

                    if (!regExp.hasMatch(val)) {
                      return 'Please enter a valid URL';
                    }
                    return null;
                  },
                  mytype: TextInputType.text,
                  readonly: false,
                ),
                TextFieldAuth(
                  hint: "Orgonized by image link",
                  mycontroller: controller.orgonizedbyimage!,
                  myicon: const Icon(Icons.image),
                  ispass: false,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't be empty";
                    }
                    const pattern =
                        r'^(http|https):\/\/[^\s$.?#].[^\s]*\.(jpg|jpeg|png|gif|bmp|webp)$';
                    final regExp = RegExp(pattern);

                    if (!regExp.hasMatch(val)) {
                      return 'Please enter a valid image URL';
                    }
                    return null;
                  },
                  mytype: TextInputType.text,
                  readonly: false,
                ),
                TextFieldAuth(
                  hint: "Orgonized By description",
                  mycontroller: controller.orgonizedbydescription!,
                  myicon: const Icon(Icons.description),
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
                  hint: "Total Amount",
                  mycontroller: controller.totalamount!,
                  myicon: const Icon(Icons.money),
                  ispass: false,
                  mysuffix: "TND",
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't to be empty ";
                    } else if (!val.isNumericOnly) {
                      return "must be a number";
                    }
                    return null;
                  },
                  mytype: TextInputType.number,
                  readonly: false,
                ),
                TextFieldAuth(
                  hint: "Donation image link",
                  mycontroller: controller.donationimage!,
                  myicon: const Icon(Icons.image),
                  ispass: false,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't be empty";
                    }
                    const pattern =
                        r'^(http|https):\/\/[^\s$.?#].[^\s]*\.(jpg|jpeg|png|gif|bmp|webp)$';
                    final regExp = RegExp(pattern);

                    if (!regExp.hasMatch(val)) {
                      return 'Please enter a valid image URL';
                    }
                    return null;
                  },
                  mytype: TextInputType.text,
                  readonly: false,
                ),
                TextFieldAuth(
                  hint: "Days",
                  mycontroller: controller.days!,
                  myicon: const Icon(Icons.description),
                  ispass: false,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Can't to be empty";
                    } else if (!val.isNumericOnly) {
                      return "must be a number!";
                    }
                    return null;
                  },
                  mytype: TextInputType.number,
                  readonly: false,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFieldAuth(
                        hint: "Type",
                        mycontroller: controller.type!,
                        myicon: const Icon(Icons.type_specimen),
                        ispass: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Can't to be empty";
                          }
                          return null;
                        },
                        mytype: TextInputType.text,
                        readonly: true,
                      ),
                    ),
                    PopupMenuButton<SampleItem>(
                      initialValue: controller.selectedItem,
                      onSelected: (SampleItem item) {
                        String cardtype;
                        switch (item) {
                          case SampleItem.itemone:
                            cardtype = "Disasters";
                            break;
                          case SampleItem.itemTwo:
                            cardtype = "Palestine";
                            break;
                          case SampleItem.itemThree:
                            cardtype = "Health";
                            break;
                          case SampleItem.itemFour:
                            cardtype = "Education";
                            break;
                          default:
                            cardtype = "Education";
                            break;
                        }
                        controller.type!.text = cardtype;
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<SampleItem>>[
                        ...List.generate(
                          controller.sampleitemlisty.length,
                          (index) => PopupMenuItem<SampleItem>(
                            value: controller.sampleitemlisty[index],
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.card_membership_rounded,
                                  color: Color(0xff00aa86),
                                ),
                                Text(controller.names[index]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ButtonAuth(
                  mytitle: "Add",
                  myfunction: () {
                    controller.adddonation();
                  },
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
