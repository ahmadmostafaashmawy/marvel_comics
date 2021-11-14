import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marvel_comics/constants/app_colors.dart';
import 'package:marvel_comics/utilities/app_localizations.dart';

class AppEditText extends StatelessWidget {
  final Color textColor;
  final Color hintColor;
  final Color backgroundColor;
  final Color borderColor;
  final double fontSize;
  final String text;
  final String translation;
  final FontWeight fontWeight;
  final String fontFamily;
  final double radius;
  TextStyle style;
  TextInputType keyboardType;
  bool isHint;
  final TextAlign textAlign;
  final Widget suffixIcon;
  final Widget prefixIcon;
  EdgeInsets contentPadding;
  final TextDecoration textDecoration;
  final InputDecoration decoration;
  final TextEditingController controller;
  final bool autoFocus;
  final bool alignLabelWithHint;
  final bool enableInteractiveSelection;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  final String errorText;
  final bool obscureText;
  final bool readOnly;
  InputBorder border;
  FormFieldValidator<String> validator;

  AppEditText({
    this.textColor = AppColor.red,
    this.backgroundColor = AppColor.white,
    this.fontSize = 14,
    this.text,
    this.validator,
    this.prefixIcon,
    this.readOnly = false,
    this.fontFamily = 'Poppins',
    this.textDecoration,
    this.borderColor = AppColor.black,
    this.focusNode,
    this.radius = 8,
    this.onChanged,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.decoration,
    this.translation,
    this.isHint = false,
    this.style,
    this.contentPadding,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.autoFocus = false,
    this.alignLabelWithHint = false,
    this.enableInteractiveSelection = true,
    this.suffixIcon,
    this.maxLength = 50,
    this.errorText,
    this.obscureText = false,
    this.hintColor = AppColor.grey,
  });

  @override
  Widget build(BuildContext context) {
    if (style != null) {
      double fontSize = style.fontSize;
      style = style.copyWith(fontSize: ScreenUtil().setSp(fontSize));
    }
    init();
    return TextField(
      autofocus: autoFocus,
      // validator: validator,
      readOnly: readOnly,
      maxLength: maxLength,
      onChanged: onChanged,
      focusNode: focusNode,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      decoration: decoration ??
          InputDecoration(
              counterText: "",
              errorText: errorText != null && errorText.isNotEmpty
                  ? AppLocalizations.of(context).translate(errorText)
                  : null,
              suffixIcon: suffixIcon ?? const SizedBox(),
              suffix: suffixIcon,
              prefixIcon: prefixIcon,
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              border: border,
              enabledBorder: border,
              filled: true,
              hintStyle: TextStyle(
                color: hintColor,
              ),
              alignLabelWithHint: alignLabelWithHint,
              labelText: isHint
                  ? null
                  : translation != null && translation.isNotEmpty
                      ? AppLocalizations.of(context).translate(translation)
                      : text ?? '',
              fillColor: backgroundColor),
      textAlign: textAlign,
      style: style ??
          TextStyle(
              decoration: textDecoration ?? textDecoration,
              fontSize: ScreenUtil().setSp(fontSize),
              color: textColor,
              fontFamily: fontFamily,
              fontWeight: fontWeight),
    );
  }

  void init() {
    border = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: .8),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }
}
