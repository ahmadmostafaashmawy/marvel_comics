import 'package:flutter/material.dart';
import 'package:marvel_comics/constants/app_colors.dart';
import 'package:marvel_comics/constants/localization_constains.dart';
import 'package:marvel_comics/constants/strings.dart';
import 'package:marvel_comics/domain/comic_model.dart';
import 'package:marvel_comics/presentation/widgets/size.dart';
import 'package:marvel_comics/presentation/widgets/text_display.dart';

class DetailsScreen extends StatelessWidget {
  CharacterModel comic;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments != null) {
      comic = ModalRoute.of(context).settings.arguments;
    }

    return Scaffold(
      backgroundColor: AppColor.black,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextDisplay(
                        translation: kName,
                        color: AppColor.red,
                        fontSize: 14,
                        isUpper: true,
                      ),
                      HeightBox(8),
                      AppTextDisplay(text: comic.name),
                      HeightBox(16),
                      AppTextDisplay(
                        translation: kDescription,
                        color: AppColor.red,
                        fontSize: 14,
                        isUpper: true,
                      ),
                      HeightBox(8),
                      AppTextDisplay(text: comic.description),
                    ],
                  ),
                ),
                HeightBox(500)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      stretch: true,
      backgroundColor: AppColor.grey,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: comic.id,
          child: Image.network(
            comic.thumbnail.path + landscapeXLarge + comic.thumbnail.extension,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
