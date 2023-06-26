import 'package:flutter/material.dart';

class txtTitle extends StatelessWidget {
  final String label;
  const txtTitle({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF007BBD),
        fontSize: 28,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
