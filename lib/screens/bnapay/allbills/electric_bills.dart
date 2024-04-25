import 'package:bankpfe/screens/bnapay/bills/electric_bill.dart';
import 'package:bankpfe/widgets/generalwidgets/common_container_listtile.dart';
import 'package:flutter/material.dart';

import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class ElectricBills extends StatelessWidget {
  const ElectricBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              const AppBarCommon(title: "All Electric Bills"),
              const SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => const ContainerListTile(
                  mypage: ElectricBill(
                    title: "title",
                    isPayed: true,
                  ),
                  title: "new",
                  mysubtitle: "mysubtitle  (Payed)",
                  myimage: "images/electricity.png",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
