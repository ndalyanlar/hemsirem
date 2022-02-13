import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  Icon? icon;
  TextEditingController controller;
  MyTextField(
      {Key? key,
      required this.label,
      this.maxLines = 1,
      this.minLines = 1,
      this.icon,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black87),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
          suffixIcon: icon,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black45),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
