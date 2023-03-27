import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  const LargeText({
    super.key,
    required double income,
  }) : _income = income;

  final double _income;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      '$_income',
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}