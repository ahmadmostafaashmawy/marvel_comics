import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_comics/constants/app_colors.dart';
import 'package:marvel_comics/constants/localization_constains.dart';
import 'package:marvel_comics/constants/strings.dart';
import 'package:marvel_comics/domain/character_model.dart';
import 'package:marvel_comics/presentation/bloc/character_details/character_details_cubit.dart';
import 'package:marvel_comics/presentation/widgets/loading.dart';
import 'package:marvel_comics/presentation/widgets/size.dart';
import 'package:marvel_comics/presentation/widgets/text_display.dart';

class DetailsScreen extends StatefulWidget {
  final CharacterModel character;

  const DetailsScreen(this.character, {Key key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<CharacterDetailsCubit>(context)
        .getCharacterDetails(widget.character.series.collectionURI);
    super.initState();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterDetailsCubit, CharacterDetailsState>(
      builder: (context, state) {
        if (state is CharacterDetailsSuccess) {
          List charactersList = (state).comicList;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: charactersList.length,
            itemBuilder: (context, index) => AppTextDisplay(
              text: charactersList[index].title,
              color: AppColor.white,
            ),
          );
        }
        if (state is CharacterDetailsFailed) {
          return AppTextDisplay(text: state.error);
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      AppTextDisplay(text: widget.character.name),
                      HeightBox(16),
                      AppTextDisplay(
                        translation: kDescription,
                        color: AppColor.red,
                        fontSize: 14,
                        isUpper: true,
                      ),
                      HeightBox(8),
                      AppTextDisplay(
                        text: widget.character.description,
                        textAlign: TextAlign.start,
                        maxLines: 10,
                      ),
                      HeightBox(16),
                      buildBlocWidget()
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
      backgroundColor: AppColor.black,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.character.id,
          child: Image.network(
            widget.character.thumbnail.path +
                landscapeXLarge +
                widget.character.thumbnail.extension,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
