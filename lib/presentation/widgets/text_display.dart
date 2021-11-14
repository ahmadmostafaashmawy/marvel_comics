import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:marvel_comics/utilities/app_localizations.dart';

class AppTextDisplay extends StatelessWidget {
  final Color color;
  final double fontSize;
  String text;
  String translation;
  final FontWeight fontWeight;
  final String fontFamily;
  TextStyle style;
  final TextAlign textAlign;
  final bool isUpper;
  final bool softWrap;
  final int maxLines;
  final TextOverflow overflow;
  final TextDecoration decoration;

  AppTextDisplay(
      {this.color = Colors.white,
      this.fontSize = 15.0,
      this.text,
      this.fontFamily = 'BalsamiqSans',
      this.decoration,
      this.translation,
      this.overflow = TextOverflow.ellipsis,
      this.style,
      this.softWrap = false,
      this.maxLines = 2,
      this.textAlign = TextAlign.center,
      this.fontWeight = FontWeight.normal,
      this.isUpper = false});

  @override
  Widget build(BuildContext context) {
    if (style != null) {
      double fontSize = style.fontSize;
      style = style.copyWith(fontSize: ScreenUtil().setSp(fontSize));
    }
    if (isUpper) {
      if (translation != null) {
        translation = translation.toUpperCase();
      }
      if (text != null) {
        text = text.toUpperCase();
      }
    }
    return Text(
      translation != null && translation.isNotEmpty
          ? AppLocalizations.of(context).translate(translation)
          : text ?? '',
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: style ??
          TextStyle(
              decoration: decoration,
              color: color,
              fontSize: ScreenUtil().setSp(fontSize),
              fontFamily: fontFamily,
              fontWeight: fontWeight),
    );
  }
}
