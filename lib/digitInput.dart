import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitInput extends StatefulWidget {
  final String label;

  const DigitInput({
    super.key,
    required this.label,
  });

  @override
  State<DigitInput> createState() => _DigitInputState();
}

class _DigitInputState extends State<DigitInput> {
  double _digit = 0;
  void _modifyDigit(String income) {
    setState(() {
      _digit = double.parse(income);
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      onChanged: _modifyDigit,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.label,
      ),
    );
  }
}