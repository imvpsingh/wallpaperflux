import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final List <Shadow>? shadow;
  final Color? color;
  final String text;
  final double fontSize;
  const CustomText({super.key,  this.shadow, required this.text, required this.fontSize,  this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        style:  TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          shadows: shadow ?? [
            const Shadow(color: Colors.blue,
            blurRadius: 4)
          ],
          color: color ?? Colors.black87

        ),

      ),
    );
  }
}
