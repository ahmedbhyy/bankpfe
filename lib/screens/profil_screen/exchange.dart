import 'package:bankpfe/controllers/profil_controllers/exchange_controller.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';

import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:bankpfe/widgets/generalwidgets/textfield_exchange.dart';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/generalwidgets/common_container_background.dart';
import '../../widgets/generalwidgets/common_row_appbar.dart';

class Exchange extends StatelessWidget {
  const Exchange({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExchangeControllerImp());
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              const AppBarCommon(title: "Exchange"),
              const SizedBox(height: 20.0),
              Image.asset(
                "images/exchange1.png",
                filterQuality: FilterQuality.high,
                height: 200.0,
              ),
              const SizedBox(height: 10.0),
              GetBuilder<ExchangeControllerImp>(
                builder: (controller) => CommonContainerBills(
                  mywidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "From",
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              showCurrencyPicker(
                                context: context,
                                showFlag: true,
                                showCurrencyName: true,
                                showCurrencyCode: true,
                                onSelect: (Currency currencyfrom) {
                                  controller.choosefrom();
                                },
                              );
                            },
                            child: const Text(
                              "Click to choose",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFieldExchange(
                        label:
                            "${controller.currecyfrom.toString().split(".").last.toUpperCase()}  ${controller.fromcontroller.text.isEmpty ? controller.money : ""}",
                        hint2: "",
                        readonly: false,
                        mytext:
                            "${controller.currecyfrom.toString().split(".").last.toUpperCase()}  ",
                        mycontroller: controller.fromcontroller,
                        myicon: const Icon(Icons.currency_exchange),
                        ispass: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Can't to be empty ";
                          } else if (val.length > 8) {
                            return "Your Phone number should be equal to 8 numbers!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      controller.isloading
                          ? const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_downward_sharp,
                                  color: Colors.blue,
                                  size: 27.0,
                                ),
                                Icon(
                                  Icons.arrow_upward_outlined,
                                  color: Colors.red,
                                  size: 27.0,
                                ),
                              ],
                            ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "To",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showCurrencyPicker(
                                context: context,
                                showFlag: true,
                                showCurrencyName: true,
                                showCurrencyCode: true,
                                onSelect: (Currency currencyto) {},
                              );
                            },
                            child: const Text(
                              "Click to choose",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFieldExchange(
                        label:
                            "${controller.currecyto.toString().split(".").last.toUpperCase()}  ${controller.convert}",
                        hint2: "",
                        readonly: true,
                        mytext: "",
                        mycontroller: controller.to,
                        myicon: const Icon(Icons.currency_exchange),
                        ispass: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Can't to be empty ";
                          } else if (!val.isNumericOnly) {
                            return "verify if it is a number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Currency rate",
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "1 ${controller.currecyfrom.toString().split(".").last.toUpperCase()} = ${controller.convert1} ${controller.currecyto.toString().split(".").last.toUpperCase()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      ButtonAuth(
                        mytitle: "Exchange",
                        myfunction: () async {
                          await controller.exchangecurrency(
                              controller.currecyfrom, controller.currecyto);
                        },
                      ),
                      const SizedBox(height: 10.0),
                    ],
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
