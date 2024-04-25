import 'package:bankpfe/screens/bnapay/bills/water_bill.dart';
import 'package:flutter/material.dart';

import '../../../widgets/generalwidgets/common_container_background.dart';
import '../../../widgets/generalwidgets/common_container_listtile.dart';
import '../../../widgets/generalwidgets/common_row_appbar.dart';

class WaterBills extends StatelessWidget {
  const WaterBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerBackground(
        mywidget: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            children: [
              const AppBarCommon(title: "All Water Bills"),
              const SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => const ContainerListTile(
                  mypage: WaterBill(
                    title: "title",
                    ispayed: false,
                  ),
                  title: "new",
                  mysubtitle: "mysubtitle  (Payed)",
                  myimage: "images/water1.png",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
