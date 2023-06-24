import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String) value;
  final TextInputType keyboardType;
  const InputWidget(
      {super.key,
      required this.label,
      required this.hint,
      required this.value,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
        keyboardType: keyboardType,
        onChanged: value,
        decoration: InputDecoration(
            labelText: label,
            filled: true,
            floatingLabelStyle: TextStyle(
              color: Colors.black,
            ),
            hintStyle: TextStyle(
              
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            fillColor: Color(0xFFEDEDED),
            hintText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xFFEDEDED), width: 0))),
      ),
    );
  }
}
