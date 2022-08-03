import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class CircularChart extends StatefulWidget {
  const CircularChart({Key? key}) : super(key: key);

  @override
  State<CircularChart> createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  late List<GData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfCircularChart(
          title: ChartTitle(text: 'This is chart'),
          legend: Legend(
              isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            DoughnutSeries<GData, String>(
                dataSource: _chartData,
                xValueMapper: (GData data, _) => data.continent,
                yValueMapper: (GData data, _) => data.gdp,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true),
          ],
        ),
      ),
    );
  }

  List<GData> getChartData() {
    final List<GData> charData = [
      GData('Oceania', 1600),
      GData('Africa', 2490),
      GData('S America', 2900),
      GData('Europe', 23050),
      GData('N America', 24880),
      GData('Asia', 34390),
    ];
    return charData;
  }
}

class GData {
  final String continent;
  final int gdp;

  GData(this.continent, this.gdp);
}
