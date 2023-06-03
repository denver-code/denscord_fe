import 'package:flutter/material.dart';

class NotImplementedScreen extends StatelessWidget {
  const NotImplementedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child:
                Text("Not implemented yet!", style: TextStyle(fontSize: 20))));
  }
}
