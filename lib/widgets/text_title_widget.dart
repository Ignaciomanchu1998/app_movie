import 'package:flutter/material.dart';

class TextTitleWidget extends StatelessWidget {
  const TextTitleWidget({
    Key? key,
    required this.sms,
    required this.color,
    required this.fontFamily,
    required this.fontSize,
  }) : super(key: key);

  final String sms;
  final Color color;
  final String fontFamily;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      sms,
      style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
      ),
    );
  }
}
