import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../widgets/generalwidgets/common_container_background.dart';
import '../../widgets/generalwidgets/common_row_appbar.dart';

class CardStatic extends StatelessWidget {
  final String cardnumber;
  const CardStatic({super.key, required this.cardnumber});

  @override
  Widget build(BuildContext context) {
    return ContainerBackground(
      mywidget: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          children: [
            const AppBarCommon(title: "Card Analysis"),
            Image.asset(
              "images/analysis.png",
              height: 200,
            ),
            SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              title: ChartTitle(text: "N° $cardnumber"),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Mon', 35),
                    SalesData('Tue', 28),
                    SalesData('Wed', 34),
                    SalesData('Thu', 32),
                    SalesData('Fri', 40),
                    SalesData('Sat', 40),
                    SalesData('Sun', 40),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.day,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.day, this.sales);
  final String day;
  final double sales;
}
