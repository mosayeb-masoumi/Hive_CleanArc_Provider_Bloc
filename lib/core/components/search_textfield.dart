
import 'package:flutter/material.dart';

class MySearchTextField extends StatelessWidget {

  final TextEditingController controller;
  final Icon? prefixIcon;
  final String labelText;
  final Function callback;

  const MySearchTextField({super.key,
    required this.controller, this.prefixIcon, required this.labelText, required this.callback});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      decoration:  InputDecoration(
        prefixIcon: prefixIcon,
        hintText: labelText,
        border: const OutlineInputBorder(), // Creates the outline border
        labelText: labelText,
        // Placeholder label
        // Hint text inside the text field// Clear text button
      ),

      onChanged: (value) {
        callback(value);
      },


    );
  }
}
