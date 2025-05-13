import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final int? lines;
  final bool? smallSize;
  final bool? isNumber;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    this.lines,
    this.isNumber,
    required this.controller,
    this.smallSize,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: smallSize == true ? 150 : double.maxFinite,
      child: TextFormField(
        minLines: lines,
        maxLines: lines,
        controller: controller,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label is required';
          }
          return null;
        },
        keyboardType:
            isNumber == true ? TextInputType.number : TextInputType.name,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
