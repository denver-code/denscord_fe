import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadingBackButton extends StatelessWidget {
  const LeadingBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          Text(
            "Back",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
