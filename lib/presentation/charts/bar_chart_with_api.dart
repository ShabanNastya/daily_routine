import 'package:daily_routine/data/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../domain/models/gender.dart';

class BarChartWithApi extends StatefulWidget {
  const BarChartWithApi({Key? key}) : super(key: key);

  @override
  State<BarChartWithApi> createState() => _BarChartWithApiState();
}

class _BarChartWithApiState extends State<BarChartWithApi> {
  List<Gender> genders = [];
  NetworkHelper _networkHelper = NetworkHelper();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    var response = await _networkHelper.get(
        'https://api.genderize.io/?name[]=peter&name[]=emma&name[]=tom&name[]=nastya&name[]=olivia&name[]=stevie');
    List<Gender> tempData = genderModelFromJson(response.body);
    setState(() {
      genders = tempData;
    });
  }

  List<charts.Series<Gender, String>> _createSampleData() {
    return [
      charts.Series<Gender, String>(
        data: genders,
        id: 'sales',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (Gender genderModel, _) => genderModel.name,
        measureFn: (Gender genderModel, _) => genderModel.count,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Bar chart with API'),
      // ),
      body: Center(
        child: SizedBox(
          height: 250,
          child: charts.BarChart(_createSampleData()),
        ),
      ),
    );
  }
}
