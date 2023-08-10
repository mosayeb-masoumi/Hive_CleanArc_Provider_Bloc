
import 'package:flutter/material.dart';

class MyOutlinedTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hint;

  const MyOutlinedTextField({super.key,
    required this.controller, required this.hint
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
     controller: controller,
      decoration:  InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(), // Creates the outline border
        labelText: 'Enter your text', // Placeholder label
       // Hint text inside the text field// Clear text button
      ),

    );
  }
}
