import 'package:flutter/material.dart';
import 'package:simple_text_form_field/text_component.dart';

class TextInkwellComponent extends StatefulWidget {
  final double? fontsize;
  final String? text;
  final Color? color;
  final TextAlign? textAlign;
  final bool isFullWidth;
  final AlignmentGeometry alignmentGeometry;
  final Function()? functionOnTap;
  final Function()? onLongTap;

  const TextInkwellComponent(
      {this.fontsize = 12,
        required this.text,
        required this.color,
        this.isFullWidth = false,
        this.alignmentGeometry = Alignment.centerRight,
        this.textAlign = TextAlign.left,
        this.onLongTap,
        required this.functionOnTap})
      : super(key: null);

  @override
  _TextInkwellComponentState createState() => _TextInkwellComponentState();
}

class _TextInkwellComponentState extends State<TextInkwellComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.functionOnTap,
      onLongPress: widget.onLongTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        alignment:
        widget.alignmentGeometry == null ? null : widget.alignmentGeometry,
        width: widget.isFullWidth ? MediaQuery.of(context).size.width : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextComponent(
              text: widget.text!,
              textAlign: widget.textAlign!,
              size: widget.fontsize!,
              color: widget.color!),
        ),
      ),
    );
  }
}
