import 'package:flutter/material.dart';

import '../../theme.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton(
      {super.key,
      required this.text1,
      required this.text2,
      required this.icon,
      this.onTap});

  final String text1;
  final String text2;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: DenscordColors.textSecondary, size: 30.0),
                const SizedBox(width: 10.0),
                Text(
                  text1,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: DenscordColors.textSecondary),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text2,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: DenscordColors.textHint),
                ),
                const SizedBox(width: 10.0),
                Icon(Icons.arrow_forward_ios_rounded,
                    color: DenscordColors.textHint, size: 20.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}
