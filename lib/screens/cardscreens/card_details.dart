import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bankpfe/controllers/card_controller/cards_controller.dart';
import 'package:bankpfe/data/Model/card_model.dart';
import 'package:bankpfe/screens/cardscreens/card_static.dart';
import 'package:bankpfe/slides/slide_right.dart';
import 'package:bankpfe/widgets/generalwidgets/common_appbar.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_background.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:u_credit_card/u_credit_card.dart';

class CardDetails extends StatelessWidget {
  final CardModel myCard;
  final String username;
  const CardDetails({
    super.key,
    required this.myCard,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(CardsControllerImp());
    return Scaffold(
      body: ContainerBackground(
        mywidget: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          children: [
            const CommonAppBar(
              title: "My Card",
              lottie: "images/lotties/lottie_onboadring3.json",
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: CreditCardUi(
                cardHolderFullName: username,
                cardNumber: myCard.cardNumber,
                validFrom: '01/24',
                scale: 0.85,
                validThru: '01/29',
                topLeftColor: Colors.blue,
                doesSupportNfc: true,
                placeNfcIconAtTheEnd: true,
                cardType: CardType.credit,
                creditCardType: CreditCardType.visa,
                cardProviderLogo: Image.asset("images/bna.png"),
                cardProviderLogoPosition: CardProviderLogoPosition.right,
                backgroundDecorationImage: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(myCard.background),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              "Cureent Balance",
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                fontSize: 20.0,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  "${myCard.balance.toString().length >= 5 ? myCard.balance.toString().substring(0, 5) : myCard.balance.toString()} TND",
                  textStyle: GoogleFonts.mulish(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 9, 87, 64),
                  ),
                  textAlign: TextAlign.center,
                  colors: [
                    Colors.black,
                    const Color.fromARGB(255, 32, 82, 33),
                  ],
                ),
              ],
              isRepeatingAnimation: true,
              totalRepeatCount: 100,
              pause: const Duration(milliseconds: 50),
            ),
            const SizedBox(height: 10.0),
            CommonContainerBills(
              mywidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "INFINITE",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    myCard.cardNumber
                        .replaceRange(4, myCard.cardNumber.length, "********"),
                    style: const TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                  const Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                    endIndent: 1.0,
                    indent: 1.0,
                  ),
                  const SizedBox(height: 7.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Relayted account number",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 72, 67, 67),
                        ),
                      ),
                      Text(
                        myCard.relatedaccount,
                        style: const TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7.0),
                  const Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                    endIndent: 1.0,
                    indent: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "RIB",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 72, 67, 67),
                        ),
                      ),
                      Text(
                        myCard.rib,
                        style: const TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7.0),
                  const Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                    endIndent: 1.0,
                    indent: 1.0,
                  ),
                  GetBuilder<CardsControllerImp>(
                    builder: (controller) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  controller.favorite
                                      ? Icons.favorite
                                      : Icons.cancel,
                                  color: controller.favorite
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 25.0,
                                ),
                                const SizedBox(width: 12.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.light0
                                          ? "Favorite Card"
                                          : "Second Card",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text("Tap to rend this card favorite")
                                  ],
                                ),
                              ],
                            ),
                            Switch(
                              value: controller.favorite,
                              activeColor: Colors.green,
                              onChanged: (bool value) {
                                controller.updatefavorite(value);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        const Divider(
                          thickness: 1.0,
                          color: Colors.grey,
                          endIndent: 1.0,
                          indent: 1.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  controller.light0
                                      ? Icons.lock_open_rounded
                                      : Icons.lock_outline_sharp,
                                  color: !controller.light0
                                      ? Colors.grey
                                      : Colors.lightGreen,
                                  size: 25.0,
                                ),
                                const SizedBox(width: 12.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.light0
                                          ? "Card is unlocked"
                                          : "Card is locked",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text("Tap to lock it")
                                  ],
                                ),
                              ],
                            ),
                            Switch(
                              value: controller.light0,
                              activeColor: Colors.green,
                              onChanged: (bool value) {
                                controller.updatecolor(value);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        const Divider(
                          thickness: 1.0,
                          color: Colors.grey,
                          endIndent: 1.0,
                          indent: 1.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              SlideRight(
                                page: CardStatic(cardnumber: myCard.cardNumber),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Card Analysis",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 72, 67, 67),
                                ),
                              ),
                              Lottie.asset(
                                "images/lotties/lottie_arrow.json",
                                height: 40.0,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
