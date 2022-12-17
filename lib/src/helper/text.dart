import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';




// Text(text,style: TextStyle(color: color,fontSize: size,fontFamily: 'Loew-Next-Arabic-ExtraBold'),);
class AutoSizeFont extends StatelessWidget {
  AutoSizeFont({Key? key, required this.text, required this.color, required this.size, required this.min, required this.maxLine,this.align}) : super(key: key);
  final String text;
  final Color color;
  final double size;
  final double min;
  final int maxLine;

  TextAlign? align;
  @override
  Widget build(BuildContext context) {

    return  AutoSizeText(
      text,
      style: TextStyle(fontSize: size,color: color,),
      minFontSize: min,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      textAlign: align,
    );
  }
}