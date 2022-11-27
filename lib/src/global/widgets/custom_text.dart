import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool? softWrap;
  final int? maxLines;
  final Color? color;
  final TextStyle? style;

  const CustomText(
    this.text, {
    super.key,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.style,
    this.maxLines,
    this.softWrap,
  });

  factory CustomText.heading(
    String text, {
    Color? color,
    double fontSize = 34,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return CustomText(
      text,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  factory CustomText.title(
    String text, {
    Color? color,
    double fontSize = 22,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return CustomText(
      text,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  factory CustomText.body(
    String text, {
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 16,
  }) {
    return CustomText(
      text,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  factory CustomText.subtitle(
    String text, {
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 13,
  }) {
    return CustomText(
      text,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  factory CustomText.label(
    String text, {
    Color? color,
    FontWeight fontWeight = FontWeight.w300,
    double fontSize = 11,
  }) {
    return CustomText(
      text,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  CustomText copyWith({
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    double? fontSize,
    bool? softWrap,
    int? maxLines,
    Color? color,
    TextStyle? style,
  }) {
    return CustomText(
      text,
      textAlign: textAlign ?? this.textAlign,
      overflow: overflow ?? this.overflow,
      fontWeight: fontWeight ?? this.fontWeight,
      fontSize: fontSize ?? this.fontSize,
      softWrap: softWrap ?? this.softWrap,
      maxLines: maxLines ?? this.maxLines,
      color: color ?? this.color,
      style: style ?? this.style,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: style ??
          TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? Theme.of(context).colorScheme.onBackground,
          ),
    );
  }
}
