import 'package:denscord_fe/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {super.key,
      required this.text,
      required this.status,
      required this.icon,
      required this.onPressed});

  final String text;
  final String status;
  final IconData? icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width / 2.4,
      height: Get.height / 11,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: DenscordColors.buttonSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 33.0),
              const SizedBox(width: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      )),
                  Text(
                    status,
                    style: TextStyle(
                      color: status == "active"
                          ? const Color.fromARGB(255, 52, 252, 62)
                          : const Color.fromARGB(255, 252, 52, 52),
                      fontSize: 13,
                    ),
                  )
                ],
              )
            ]),
      ),
    );
  }
}

class ProfileSquareButton extends StatelessWidget {
  const ProfileSquareButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPressed});

  final String text;
  final Widget icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width / 3.5,
      height: Get.width / 3.5,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: DenscordColors.buttonSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              const SizedBox(height: 10.0),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ]),
      ),
    );
  }
}
