import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:marvel_comics/constants/app_colors.dart';
import 'package:marvel_comics/presentation/widgets/text_display.dart';

class AppButton extends StatelessWidget {
  final String translation;
  final Color color;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final TextDecoration textDecoration;
  final BoxDecoration decoration;
  TextStyle style;
  Function onTap;
  final Widget child;
  BorderRadiusGeometry border;

  AppButton(
      {this.translation,
      this.color = AppColor.blue,
      this.textColor = Colors.white,
      this.onTap,
      this.fontSize = 15,
      this.fontWeight = FontWeight.normal,
      this.fontFamily = 'BalsamiqSans',
      this.textDecoration,
      this.border,
      this.child,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(2)),
      decoration: decoration ?? BoxDecoration(
              color: color,
              borderRadius:
                  border ?? BorderRadius.circular(15.0),
            ),
      child: FlatButton(
        onPressed: onTap,
        child: child ??
            AppTextDisplay(
              translation: translation,
              style: style ?? TextStyle(
                      decoration: textDecoration,
                      color: textColor,
                      fontSize: fontSize,
                      fontFamily: fontFamily,
                      fontWeight: fontWeight),
            ),
      ),
    );
  }
}
