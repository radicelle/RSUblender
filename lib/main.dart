import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'header.dart';
import 'largeText.dart';
import 'digitInput.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fr RSU blender',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Compute your RSU and taxes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class IncomeTaxRate {
  final int rate;
  final int floor;
  final int threshold;

  const IncomeTaxRate(this.rate, this.floor, this.threshold);
}

class _MyHomePageState extends State<MyHomePage> {
  double _income = 0;
  double _rsu = 0;
  double _obtainedFor = 0;
  double _soldFor = 0;
  List<IncomeTaxRate> rateThreshold = [
    const IncomeTaxRate(0, 0, 10777),
    const IncomeTaxRate(11, 10777, 27478),
    const IncomeTaxRate(30, 27478, 78570),
    const IncomeTaxRate(41, 78570, 168994),
    const IncomeTaxRate(45, 168994, 10000000000)
  ];


  void _modifyRSU(String rsu) {
    setState(() {
      _rsu = double.parse(rsu);
    });
  }
  void _modifyObtainedFor(String price) {
    setState(() {
      _rsu = double.parse(price);
    });
  }
  void _modifySoledFor(String price) {
    setState(() {
      _rsu = double.parse(price);
    });
  }

  @override
  Widget build(BuildContext context) {
    var incomeByRate =
        rateThreshold.map((taxRate) => applyTaxRate(taxRate, _income));
    var taxByRate = rateThreshold
        .map((taxRate) => applyTaxRate(taxRate, _income) * 0.01 * taxRate.rate);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              DigitInput('Taxable income'),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: _modifyRSU,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Number of actions',
                ),
              ),
            ],
          ),
          Table(
            children: [
              const TableRow(children: [
                Header(label: ''),
                Header(label: '0%'),
                Header(label: '11%'),
                Header(label: '30%'),
                Header(label: '41%'),
                Header(label: '45%')
              ]),
              TableRow(children: [
                const Header(label: 'Part taxed'),
                ...incomeByRate.map((e) => LargeText(income: e.toDouble()))
              ]),
              TableRow(children: [
                const Header(label: 'To pay'),
                ...taxByRate.map((e) => LargeText(income: e.toDouble()))
              ])
            ],
          ),
        ],
      ),
    );
  }

  num applyTaxRate(IncomeTaxRate taxRate, double income) {
    var remain = income - taxRate.threshold;
    var taxable = (remain >= 0
            ? taxRate.threshold.toDouble()
            : taxRate.threshold + remain) -
        taxRate.floor;
    return taxable >= 0 ? taxable : 0;
  }
}
