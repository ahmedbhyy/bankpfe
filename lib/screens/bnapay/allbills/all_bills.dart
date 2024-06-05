import 'package:bankpfe/controllers/pay_controllers/all_bills_controller.dart';
import 'package:bankpfe/data/Model/bill_model.dart';
import 'package:bankpfe/screens/bnapay/allbills/paybillwithnumber.dart';
import 'package:bankpfe/screens/bnapay/bills/all_bills_details.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_listtile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../data/Model/card_model.dart';
import '../../../slides/slide_right.dart';
import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class AllBills extends StatelessWidget {
  final List<CardModel> mycard;
  final List<BillModel> mybills;
  final String username;

  const AllBills({
    super.key,
    required this.mycard,
    required this.mybills, required this.username,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(AllBillsControllerImp());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            SlideRight(
              page: PayBillwithNumber(myCard: mycard, username: username),
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
          child: GetBuilder<AllBillsControllerImp>(
            builder: (controller) => ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              children: [
                const AppBarCommon(title: "All Bills"),
                const SizedBox(height: 15.0),
                ...List.generate(
                  2,
                  (index) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "balance for ${mycard[index].cardNumber}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 4, 62, 50),
                          ),
                        ),
                        Text(
                          "${mycard[index].balance.toString().length >= 5 ? mycard[index].balance.toString().substring(0, 5) : mycard[index].balance.toString()} TND",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Color(0xff00aa86),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: Colors.grey),
                mybills.isEmpty
                    ? Lottie.asset(
                        "images/lotties/lottie_empty.json",
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: mybills.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ContainerListTile(
                          mypage: BillsDetails(
                            mybill: mybills[index],
                          ),
                          ispayed: mybills[index].ispayed,
                          myfunction: () {
                            controller.paybill(
                              mybills[index].id,
                              mycard[0].id,
                              mybills[index].amount,
                              mycard[0].balance,
                              mybills[index].type,
                            );
                          },
                          title: mybills[index].title,
                          mysubtitle:
                              "${mybills[index].date.toDate().toString().substring(0, 10)}  (${mybills[index].amount}) TND (${mybills[index].ispayed ? "Payed" : "Unpayed"})",
                          myimage: "images/${mybills[index].image}.png",
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
