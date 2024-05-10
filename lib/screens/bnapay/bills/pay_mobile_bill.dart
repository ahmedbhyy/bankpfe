import 'package:bankpfe/controllers/pay_controllers/pay_mobile_controller.dart';
import 'package:bankpfe/data/Model/card_model.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

import '../../../widgets/homewidget/cards_home.dart';
import '../../cardscreens/card_details.dart';

class PayMobileBill extends StatelessWidget {
  final List<CardModel> myCard;
  final String username;
  const PayMobileBill(
      {super.key, required this.myCard, required this.username});

  @override
  Widget build(BuildContext context) {
    Get.put(PayMobileControllerImp());
    return GetBuilder<PayMobileControllerImp>(
      builder: (controller) => Form(
        key: controller.formState,
        child: Scaffold(
          body: ContainerBackground(
            mywidget: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 15.0),
                children: [
                  const AppBarCommon(title: "Pay Your Mobile bill"),
                  const SizedBox(height: 20.0),
                  Text(
                    "Select a card ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Swiper(
                    itemCount: controller.cardsdetails.length,
                    loop: true,
                    duration: 1200,
                    itemHeight: 200,
                    itemWidth: 300,
                    onIndexChanged: (value) {
                      controller.updateindexz(value);
                    },
                    scrollDirection: Axis.horizontal,
                    layout: SwiperLayout.STACK,
                    itemBuilder: (context, index) {
                      return CardsHome(
                        mypage: CardDetails(
                          myCard: myCard[index],
                          username: username,
                        ),
                        cardtype: CardType.credit,
                        cardholder: username,
                        cardnumber: myCard[index].cardNumber,
                        backgroundimage: myCard[index].background,
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Available balance :  ${myCard[controller.z].balance.toString().substring(0, 6)} TND",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: SizedBox(
                      height: 70.0,
                      child: IntlPhoneField(
                        controller: controller.phonenumber,
                        validator: (val) {
                          if (val == null || val.number.length != 8) {
                            return "Can't to be empty ";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        initialCountryCode: 'TN',
                        onChanged: (phone) {
                          controller.updateimage(phone.number);
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Operator :",
                        style: GoogleFonts.mulish(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      controller.mywidgets[controller.j],
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Choose amount",
                    style: GoogleFonts.mulish(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 80.0,
                      child: ListView.builder(
                        itemCount: controller.amounts.length,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            controller.updateindex(index);
                          },
                          child: Container(
                            width: 100.0,
                            margin: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.i == index
                                  ? const Color(0xff00aa86)
                                  : Colors.transparent,
                              border: Border.all(
                                color: const Color(0xff00aa86),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              controller.amounts[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  ButtonAuth(
                    mytitle: "Confirm",
                    myfunction: () {
                      if (controller.formState.currentState!.validate()) {
                        controller.paymobilebill();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
