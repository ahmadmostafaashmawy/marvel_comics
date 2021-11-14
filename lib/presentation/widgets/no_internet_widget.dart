import 'package:flutter/material.dart';
import 'package:marvel_comics/constants/app_colors.dart';
import 'package:marvel_comics/constants/localization_constains.dart';
import 'package:marvel_comics/presentation/widgets/size.dart';
import 'package:marvel_comics/presentation/widgets/text_display.dart';
import 'package:marvel_comics/constants/app_images.dart';

class NoInternetWidget extends StatelessWidget {
  final String title;
  final String imagePath;

  const NoInternetWidget({
    Key key,
    this.title = kNoInternet,
    this.imagePath = AppImages.noInternetImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeightBox(20),
            AppTextDisplay(
              translation: title,
              fontSize: 22,
              color: AppColor.grey,
            ),
            Image.asset(imagePath)
          ],
        ),
      ),
    );
  }
}
