import 'package:bankpfe/data/Model/account_model.dart';

import 'package:bankpfe/screens/bnapay/bills/mobile_bill.dart';
import 'package:bankpfe/screens/bnapay/bills/pay_mobile_bill.dart';
import 'package:bankpfe/slides/slide_right.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_container_listtile.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class MobileBills extends StatelessWidget {
  final List<AccountModel> myaccounts;

  const MobileBills({
    super.key,
    required this.myaccounts,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            SlideRight(
              page: PayMobileBill(
                myCard: myaccounts,
              ),
            ),
          );
        },
        elevation: 6,
        backgroundColor: const Color(0xff00aa86),
        child: Text(
          "Pay",
          style: GoogleFonts.mulish(
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              const AppBarCommon(title: "All Mobile Bills"),
              const SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => const ContainerListTile(
                  mypage: MobileBill(
                    title: "Orange Bill",
                  ),
                  title: "Orange Bill",
                  ispayed: true,
                  mysubtitle: "Payed Yesterday",
                  myimage: "images/mobile1.png",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
