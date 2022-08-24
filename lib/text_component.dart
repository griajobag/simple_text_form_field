
import 'package:flutter/material.dart';


class TextComponent extends StatelessWidget {
  final String? text;
  final Color color;
  final bool muted;
  final double size;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final bool isActionBar;

  const TextComponent(
      {Key? key,
        required this.text,
        this.color = Colors.black,
        this.size = 12,
        this.muted = false,
        this.textAlign = TextAlign.left,
        this.fontWeight = FontWeight.normal,
        this.marginTop = 0,
        this.marginBottom = 0,
        this.marginLeft = 0,
        this.isActionBar = false,
        this.marginRight = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            left: marginLeft,
            right: marginRight,
            bottom: marginBottom,
            top: marginTop),
        child: isActionBar
            ? Text(text!)
            : Text(
          text!,
          style: TextStyle(
              fontSize: size,
              fontWeight: fontWeight,
              color: color.withOpacity(muted ? .5 : 1)),
          textAlign: textAlign,
        ));
  }


}
