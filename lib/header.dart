import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String label;

  const Header({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      label,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}