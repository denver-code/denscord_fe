import 'package:denscord_fe/theme.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.isEnabled,
      required this.controller,
      required this.hintText});

  final bool isEnabled;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: isEnabled,
      controller: controller,
      cursorColor: Colors.black,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius:
                BorderRadius.all(Radius.circular(DenscrodSizes.borderRadius)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius:
                BorderRadius.all(Radius.circular(DenscrodSizes.borderRadius)),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14)),
    );
  }
}
