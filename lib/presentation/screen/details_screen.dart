import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marvel_comics/constants/app_colors.dart';
import 'package:marvel_comics/constants/localization_constains.dart';
import 'package:marvel_comics/constants/strings.dart';
import 'package:marvel_comics/data/repository/comic_repository.dart';
import 'package:marvel_comics/data/web_services/comic_web_services.dart';
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
  ComicRepository comicRepository;
  CharacterDetailsCubit seriesCubit;
  CharacterDetailsCubit comicCubit;
  CharacterDetailsCubit storiesCubit;
  CharacterDetailsCubit eventsCubit;

  @override
  void initState() {
    comicRepository = ComicRepository(ComicWebServices());
    seriesCubit = CharacterDetailsCubit(comicRepository);
    if (widget.character.series != null) {
      seriesCubit.getCharacterDetails(widget.character.series.collectionURI);
    }
    comicCubit = CharacterDetailsCubit(comicRepository);
    if (widget.character.comics != null) {
      comicCubit.getCharacterDetails(widget.character.comics.collectionURI);
    }
    storiesCubit = CharacterDetailsCubit(comicRepository);
    if (widget.character.stories != null) {
      storiesCubit.getCharacterDetails(widget.character.stories.collectionURI);
    }
    eventsCubit = CharacterDetailsCubit(comicRepository);
    if (widget.character.events != null) {
      eventsCubit.getCharacterDetails(widget.character.events.collectionURI);
    }
    super.initState();
  }

  Widget buildCubitList(CharacterDetailsCubit cubit) {
    return SizedBox(
      height: 300,
      child: BlocProvider(
        create: (_) => cubit,
        child: BlocBuilder<CharacterDetailsCubit, CharacterDetailsState>(
          builder: (context, state) {
            if (state is CharacterDetailsSuccess) {
              List charactersList = (state).comicList;
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: charactersList.length,
                itemBuilder: (context, index) => Container(
                  width: 150,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      buildCachedNetworkImage(
                        charactersList[index].thumbnail.path +
                            portraitLarge +
                            widget.character.thumbnail.extension,
                      ),
                      HeightBox(8),
                      AppTextDisplay(
                        text: charactersList[index].title,
                        fontSize: 12,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is CharacterDetailsFailed) {
              return AppTextDisplay(text: state.error);
            } else {
              return LoadingWidget();
            }
          },
        ),
      ),
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
                      buildTitleWidget(),
                      buildDescriptionWidget(),
                      if (widget.character.comics != null) buildComicsWidget(),
                      if (widget.character.series != null) buildSeriesWidget(),
                      if (widget.character.stories != null)
                        buildStoriesWidget(),
                      if (widget.character.events != null) buildEventsWidget(),
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
          child: buildCachedNetworkImage(widget.character.thumbnail.path +
              landscapeXLarge +
              widget.character.thumbnail.extension),
        ),
      ),
    );
  }

  Widget buildCachedNetworkImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: double.infinity,
      placeholder: (context, url) => LoadingWidget(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget buildComicsWidget() {
    return Column(
      children: [
        HeightBox(16),
        AppTextDisplay(
          translation: kComics,
          color: AppColor.red,
          fontSize: 14,
          isUpper: true,
        ),
        HeightBox(8),
        buildCubitList(comicCubit),
      ],
    );
  }

  Widget buildSeriesWidget() {
    return Column(
      children: [
        HeightBox(16),
        AppTextDisplay(
          translation: kSeries,
          color: AppColor.red,
          fontSize: 14,
          isUpper: true,
        ),
        HeightBox(8),
        buildCubitList(seriesCubit),
      ],
    );
  }

  Widget buildStoriesWidget() {
    return Column(
      children: [
        HeightBox(16),
        AppTextDisplay(
          translation: kStories,
          color: AppColor.red,
          fontSize: 14,
          isUpper: true,
        ),
        HeightBox(8),
        buildCubitList(storiesCubit),
      ],
    );
  }

  Widget buildEventsWidget() {
    return Column(
      children: [
        HeightBox(16),
        AppTextDisplay(
          translation: kEvents,
          color: AppColor.red,
          fontSize: 14,
          isUpper: true,
        ),
        HeightBox(8),
        buildCubitList(eventsCubit),
      ],
    );
  }

  Widget buildDescriptionWidget() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget buildTitleWidget() {
    return Column(
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
      ],
    );
  }
}
