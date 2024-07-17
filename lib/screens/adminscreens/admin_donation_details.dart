import 'package:bankpfe/controllers/admin_controller/admin_donation_details_controller.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../data/Model/donation_model.dart';
import '../../widgets/generalwidgets/common_appbar.dart';

class AdminDonationsDetails extends StatelessWidget {
  final DonationModel mydonation;
  const AdminDonationsDetails({super.key, required this.mydonation});

  @override
  Widget build(BuildContext context) {
    AdminDonationsDetailsControllerImp mycontroller =
        Get.put(AdminDonationsDetailsControllerImp());
    return GetBuilder<AdminDonationsDetailsControllerImp>(
      builder: (controller) => Scaffold(
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
                title: "Donation",
                lottie: "images/lotties/lottie_onlinepayment.json",
              ),
              InkWell(
                onTap: () {
                  returndialog("Change The Image (Url)", TextInputType.text,
                      () {
                    controller.editdonation(mydonation.id, "donationimage",
                        mycontroller.editcontroller!.text);
                  }, mycontroller.editcontroller!);
                },
                child: CachedNetworkImage(
                  imageUrl: mydonation.donationimage,
                  height: 200.0,
                  width: 200.0,
                  placeholder: (context, url) => Lottie.asset(
                    "images/lotties/lottie_loading.json",
                    height: 50.0,
                  ),
                ),
              ),
              CommonContainerBills(
                mywidget: Column(
                  children: [
                    MyRow(
                        myobject: mydonation.title,
                        title: "Title",
                        onTap: () {
                          returndialog("Modify The Title", TextInputType.text,
                              () {
                            controller.editdonation(mydonation.id, "title",
                                mycontroller.editcontroller!.text);
                          }, mycontroller.editcontroller!);
                        }),
                    MyRow(
                        myobject: mydonation.description,
                        title: "Description",
                        onTap: () {
                          returndialog(
                            "Modify The Description",
                            TextInputType.text,
                            () {
                              controller.editdonation(
                                  mydonation.id,
                                  "description",
                                  mycontroller.editcontroller!.text);
                            },
                            mycontroller.editcontroller!,
                          );
                        }),
                    MyRow(
                        myobject: "${mydonation.totalamount} TND",
                        title: "Total Amount",
                        onTap: () {
                          returndialog(
                            "Modify Total Amount",
                            TextInputType.number,
                            () {
                              double? totalAmount = double.tryParse(
                                  mycontroller.editcontroller!.text);
                              if (totalAmount != null) {
                                controller.editdonation(
                                    mydonation.id, "totalamount", totalAmount);
                              } else {
                                Get.snackbar("Error", "Invalid number input");
                              }
                            },
                            mycontroller.editcontroller!,
                          );
                        }),
                    MyRow(
                      myobject: "${mydonation.currentamount} TND",
                      title: "Current amount",
                    ),
                    MyRow(
                      myobject: mydonation.givers.toString(),
                      title: "Givers",
                    ),
                    MyRow(
                        myobject: mydonation.orgonizedby,
                        title: "Orgonizedby",
                        onTap: () {
                          returndialog(
                            "Modify Orgonizedby",
                            TextInputType.text,
                            () {
                              controller.editdonation(
                                  mydonation.id,
                                  "orgonizedby",
                                  mycontroller.editcontroller!.text);
                            },
                            mycontroller.editcontroller!,
                          );
                        }),
                    MyRow(
                      myobject: mydonation.type,
                      title: "Type",
                    ),
                    MyRow(
                        myobject: "${mydonation.daysleft} days",
                        title: "Days left",
                        onTap: () {
                          returndialog(
                            "Change Days left",
                            TextInputType.number,
                            () {
                              int? daysLeft = int.tryParse(
                                  mycontroller.editcontroller!.text);
                              if (daysLeft != null) {
                                controller.editdonation(
                                    mydonation.id, "daysleft", daysLeft);
                              } else {
                                // Handle invalid input
                                Get.snackbar("Error", "Invalid number input");
                              }
                            },
                            mycontroller.editcontroller!,
                          );
                        }),
                  ],
                ),
              ),
              ButtonAuth(
                mytitle: "Delete",
                myfunction: () {
                  controller.deletedontaion(mydonation.donationid);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyRow extends StatelessWidget {
  final String myobject;
  final String title;
  final Function()? onTap;
  const MyRow(
      {super.key, required this.myobject, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 73, 111, 75),
              ),
            ),
            const SizedBox(width: 45.0),
            Flexible(
              child: Text(
                myobject,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

returndialog(String title, TextInputType keyboardType, Function() onPressed,
    TextEditingController controlleredit) {
  return Get.dialog(
    Form(
      child: Dialog(
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                maxLines: 2,
                keyboardType: keyboardType,
                controller: controlleredit,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.edit),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  labelText: "Edit",
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "can not be empty!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text("Cancel"),
                  ),
                  TextButton.icon(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                    label: const Text("Edit"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
