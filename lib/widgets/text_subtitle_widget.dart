import 'dart:ffi';

import 'package:flutter/material.dart';

class TextSubTitleWidget extends StatelessWidget {
  const TextSubTitleWidget({
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
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines ?? 5,
      style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
      ),
      textAlign: align ?? TextAlign.start,
    );
  }
}
