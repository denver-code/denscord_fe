import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/Obsidian.png",
          scale: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        const Text("Denscord",
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontFamily: "FixelDisplay"))
      ],
    );
  }
}
