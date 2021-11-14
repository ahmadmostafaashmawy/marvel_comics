import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screen_util.dart';

class HeightBox extends StatelessWidget {
  double height;
  Widget child;

  HeightBox(this.height,{child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(height),child: child,
    );
  }
}

class WidthBox extends StatelessWidget {
  double width;
  Widget child;
  WidthBox(this.width,{child});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(width: ScreenUtil().setWidth(width),child:child
    );
  }
}
