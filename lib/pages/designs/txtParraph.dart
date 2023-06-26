import 'package:flutter/material.dart';

class txtParraph extends StatelessWidget {
  final String label;
  const txtParraph({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontStyle: FontStyle.normal,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
