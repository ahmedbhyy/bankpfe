import 'package:bankpfe/controllers/pay_controllers/all_bills_controller.dart';
import 'package:bankpfe/screens/bnapay/bills/all_bills_details.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_listtile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/Model/card_model.dart';
import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class AllBills extends StatelessWidget {
  final List<CardModel> mycard;
  const AllBills({super.key, required this.mycard});

  @override
  Widget build(BuildContext context) {
    Get.put(AllBillsControllerImp());
    return Scaffold(
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
                          "${mycard[index].balance} TND",
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ContainerListTile(
                    mypage: const BillsDetails(
                      title: "title",
                      isPayed: true,
                    ),
                    ispayed: true,
                    myfunction: () {
                      controller.paybill();
                    },
                    title: "new",
                    mysubtitle: "mysubtitle  (Payed)",
                    myimage: "images/electricity.png",
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
