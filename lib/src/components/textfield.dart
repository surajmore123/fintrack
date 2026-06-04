import 'package:flutter/material.dart';

class ExpenseTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;

  const ExpenseTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}