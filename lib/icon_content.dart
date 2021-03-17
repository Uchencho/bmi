import 'package:flutter/material.dart';

class ReuseableIcon extends StatelessWidget {
  ReuseableIcon({@required this.genderText, @required this.genderIcon});
  final String genderText;
  final IconData genderIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          this.genderIcon,
          size: 80.0,
        ),
        SizedBox(height: 15.0),
        Text(
          this.genderText,
          style: TextStyle(color: Color(0xFF8D8E98), fontSize: 18.0),
        )
      ],
    );
  }
}
