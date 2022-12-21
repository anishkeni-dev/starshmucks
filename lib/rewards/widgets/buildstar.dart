import 'package:flutter/material.dart';

class BuildStar extends StatelessWidget {
  BuildStar({Key? key, this.color, this.text}) : super(key: key);
  final color;
  final text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.stars_sharp,
          color: color,
        ),
        Text(text, style: TextStyle(fontSize: 11))
      ],
    );
  }
}