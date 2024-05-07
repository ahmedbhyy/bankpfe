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
              primaryYAxis: const NumericAxis(
                title: AxisTitle(text: "TND"),
              ),
              title: ChartTitle(text: "N° $cardnumber"),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Mon', 100),
                    SalesData('Tue', 150),
                    SalesData('Wed', 50),
                    SalesData('Thu', 0),
                    SalesData('Fri', 250),
                    SalesData('Sat', 30),
                    SalesData('Sun', 105),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.day,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Total of the week : 685 TND",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            )
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
