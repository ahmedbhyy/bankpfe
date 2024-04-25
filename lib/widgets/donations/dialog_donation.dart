import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../controllers/pay_controllers/donation_details_controller.dart';

class DonationDialog extends GetView<DonationsDetailsControllerImp> {
  const DonationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            controller.cardsdetails.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
              child: InkWell(
                onTap: () {
                  controller.changechekcboxcolor(index);
                },
                child: Column(
                  children: [
                    Container(
                      height: 100.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: controller.isSelectedList[index]
                              ? const Color(0xff00aa86)
                              : Colors.white,
                          width: 3.0,
                        ),
                      ),
                      child: CreditCardUi(
                        cardHolderFullName: controller.cardsdetails[index]
                            ["holdername"],
                        cardNumber: controller.cardsdetails[index]
                            ["cardnumber"],
                        validFrom: '01/24',
                        validThru: '01/29',
                        topLeftColor: Colors.blue,
                        doesSupportNfc: true,
                        placeNfcIconAtTheEnd: true,
                        cardType: CardType.credit,
                        creditCardType: CreditCardType.visa,
                        cardProviderLogo: Image.asset("images/bna.png"),
                        cardProviderLogoPosition:
                            CardProviderLogoPosition.right,
                        backgroundDecorationImage: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            controller.cardsdetails[index]["background"],
                          ),
                        ),
                      ),
                    ),
                    Checkbox(
                      isError: true,
                      tristate: true,
                      checkColor: const Color.fromARGB(255, 255, 255, 255),
                      activeColor: const Color(0xff00aa86),
                      value: controller.isSelectedList[index],
                      onChanged: (bool? value) {
                        controller.changechekcboxcolor(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
