import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social/utils/colors/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      this.fontSize = 14,
      this.color,
      required this.title,
      this.maxLines = 2,
      this.decoration,
      this.textAlign = TextAlign.start});
  final String title;
  final double fontSize;
  final Color? color;
  final int? maxLines;
  final TextDecoration? decoration;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.abrilFatface(
        textStyle: TextStyle(
          decoration: decoration ?? TextDecoration.none,
          decorationColor: color ?? AppColors.lightPrimaryColor,
          fontSize: fontSize,
          color: color ?? AppColors.lightPrimaryColor,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
