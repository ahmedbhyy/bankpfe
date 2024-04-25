import 'package:flutter/material.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../slides/slide_right.dart';

class CardsHome extends StatelessWidget {
  final Widget mypage;

  final String cardholder;
  final String cardnumber;
  final String backgroundimage;
  final CardType cardtype;
  const CardsHome(
      {super.key,
      required this.mypage,
    
      required this.cardholder,
      required this.cardnumber,
      required this.backgroundimage, required this.cardtype});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          SlideRight(page: mypage),
        );
      },
      child: CreditCardUi(
        cardHolderFullName: cardholder,
        cardNumber: cardnumber,
        validFrom: '01/24',
        validThru: '01/29',
        topLeftColor: Colors.blue,
        doesSupportNfc: true,
        placeNfcIconAtTheEnd: true,
        cardType: cardtype,
        creditCardType: CreditCardType.visa,
        cardProviderLogo: Image.asset("images/bna.png"),
        cardProviderLogoPosition: CardProviderLogoPosition.right,
        backgroundDecorationImage: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(backgroundimage),
        ),
      ),
    );
  }
}
