import 'package:bankpfe/controllers/homecontroller/aaltransaction_controller.dart';
import 'package:bankpfe/data/Model/transaction_model.dart';
import 'package:bankpfe/screens/homescreens/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../slides/slide_right.dart';
import '../../widgets/generalwidgets/common_container_background.dart';
import '../../widgets/generalwidgets/common_row_appbar.dart';

class AllTransactions extends StatelessWidget {
  final List<TransactionModel> mytranscation;

  const AllTransactions({super.key, required this.mytranscation});

  @override
  Widget build(BuildContext context) {
    Get.put(AllTransactionControllerImp());
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              const AppBarCommon(title: "All Transactions"),
              Image.asset("images/transaction.png"),
              GetBuilder<AllTransactionControllerImp>(
                builder: (controller) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      padding: const EdgeInsets.all(7.0),
                      height: MediaQuery.of(context).size.height / 1.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: mytranscation.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            ListTile(
                              title: Text(mytranscation[index].title),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    mytranscation[index]
                                        .date
                                        .toDate()
                                        .toString()
                                        .substring(0, 16),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Row(
                                    children: [
                                      mytranscation[index].type == "Transfer" ||
                                              mytranscation[index].type ==
                                                  "Retrait"
                                          ? const Icon(
                                              Icons.remove_circle_outline,
                                              size: 15.0,
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              Icons.add_circle_outline,
                                              size: 15.0,
                                              color: Colors.green,
                                            ),
                                      const SizedBox(width: 5.0),
                                      Text(
                                        "${mytranscation[index].amount} TND",
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                          color: (mytranscation[index].type ==
                                                      "Retrait" ||
                                                  mytranscation[index].type ==
                                                      "Transfer")
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  SlideRight(
                                    page: TransactionDetails(
                                        mymodel: mytranscation[index]),
                                  ),
                                );
                              },
                              trailing: Lottie.asset(
                                "images/lotties/lottie_arrow.json",
                                height: 30.0,
                              ),
                              leading: Lottie.asset(
                                mytranscation[index].lottie,
                                width: 35.0,
                              ),
                            ),
                            index < mytranscation.length - 1
                                ? const Divider(
                                    color: Colors.grey,
                                    thickness: 1.0,
                                    indent: 20.0,
                                    endIndent: 20.0,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 50.0,
                      top: -16.0,
                      child: InkWell(
                        onTap: () {
                          controller.updatecolor();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          padding: const EdgeInsets.all(5.0),
                          width: 80.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: controller.isselected
                                ? const Color.fromARGB(255, 138, 154, 139)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "EPARGNE",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: !controller.isselected
                                  ? const Color.fromARGB(255, 107, 101, 101)
                                  : Colors.white,
                              fontWeight: controller.isselected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 50.0,
                      top: -16.0,
                      child: InkWell(
                        onTap: () {
                          controller.updatecolor();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          padding: const EdgeInsets.all(5.0),
                          width: 80.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: !controller.isselected
                                ? const Color.fromARGB(255, 138, 154, 139)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "INFINITE",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: !controller.isselected
                                  ? Colors.white
                                  : const Color.fromARGB(255, 107, 101, 101),
                              fontWeight: !controller.isselected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
