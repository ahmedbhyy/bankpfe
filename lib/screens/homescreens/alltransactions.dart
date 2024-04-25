import 'package:bankpfe/controllers/homecontroller/aaltransaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/generalwidgets/common_container_background.dart';
import '../../widgets/generalwidgets/common_row_appbar.dart';

class AllTransactions extends StatelessWidget {
  const AllTransactions({super.key});

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
                        itemCount: 10,
                        itemBuilder: (context, index) => Column(
                          children: [
                            ListTile(
                              title: const Text("Donations"),
                              titleTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: Color.fromARGB(255, 94, 161, 216),
                              ),
                              subtitle: const Text("new event is available"),
                              onTap: () {},
                              leading: const Icon(
                                Icons.notifications_active_outlined,
                                color: Color.fromARGB(255, 13, 135, 94),
                              ),
                              trailing: const Text(
                                "Today",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(118, 0, 0, 0),
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            index < 9
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
