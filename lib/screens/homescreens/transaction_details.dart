import 'package:bankpfe/controllers/homecontroller/transaction_details_controller.dart';
import 'package:bankpfe/data/Model/transaction_model.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_bills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/generalwidgets/common_container_background.dart';
import '../../widgets/generalwidgets/common_row_appbar.dart';

class TransactionDetails extends StatelessWidget {
  final TransactionModel mymodel;

  const TransactionDetails({super.key, required this.mymodel});

  @override
  Widget build(BuildContext context) {
    Get.put(TransactionDetailsControllerImp());
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              const AppBarCommon(title: "Transaction"),
              Image.asset(
                "images/transfer.png",
              ),
              GetBuilder<TransactionDetailsControllerImp>(
                builder: (controller) => CommonContainerBills(
                  mywidget: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            mymodel.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 1, 79, 62),
                            ),
                          ),
                          Lottie.asset(mymodel.lottie,
                              height: 35.0, repeat: false),
                        ],
                      ),
                      ...List.generate(
                        controller.transactioninfo.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              index == controller.transactioninfo.length - 1
                                  ? Text(
                                      controller.transactioninfo[index],
                                      style: GoogleFonts.mulish(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(
                                      controller.transactioninfo[index],
                                      style: GoogleFonts.mulish(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                              index == controller.transactioninfo.length - 1
                                  ? Text(
                                      "${mymodel.amount} TND",
                                      style: const TextStyle(
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    )
                                  : Text(
                                      " ${index == 0 ? mymodel.category : index == 1 ? mymodel.transcationtype : index == 2 ? mymodel.debit : index == 3 ? mymodel.transactionlabel : index == 4 ? mymodel.internal : index == 5 ? mymodel.date.toDate().toString().substring(0, 16) : mymodel.title}",
                                      style: const TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
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
