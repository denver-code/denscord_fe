import 'package:denscord_fe/app/utils/hex2color.dart';
import 'package:flutter/material.dart';

class BigButtonWidget extends StatelessWidget {
  const BigButtonWidget(
      {super.key,
      required this.text,
      required this.height,
      required this.onPressed,
      required this.backgroundColor});

  final String text;
  final double height;
  final Color backgroundColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            )),
      ),
    );
  }
}
