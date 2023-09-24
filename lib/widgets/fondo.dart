import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Fondo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
        ),
      ],
    );
  }
}
