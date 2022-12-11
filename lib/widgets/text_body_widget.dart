import 'package:flutter/material.dart';

class TextBodyWidget extends StatelessWidget {
  const TextBodyWidget({
    Key? key,
    required this.sms,
    required this.color,
    required this.fontFamily,
    required this.fontSize,
    this.align,
    this.maxLines,
  }) : super(key: key);

  final String sms;
  final Color color;
  final String fontFamily;
  final double fontSize;
  final TextAlign? align;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      sms,
      style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
      ),
      textAlign: align ?? TextAlign.start,
    );
  }
}
