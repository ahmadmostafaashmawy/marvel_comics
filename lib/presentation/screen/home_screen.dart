import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:marvel_comics/constants/app_colors.dart';
import 'package:marvel_comics/constants/app_images.dart';
import 'package:marvel_comics/constants/localization_constains.dart';
import 'package:marvel_comics/constants/strings.dart';
import 'package:marvel_comics/data/repository/comic_repository.dart';
import 'package:marvel_comics/data/web_services/comic_web_services.dart';
import 'package:marvel_comics/domain/character_model.dart';
import 'package:marvel_comics/presentation/bloc/characters/characters_cubit.dart';
import 'package:marvel_comics/presentation/widgets/loading.dart';
import 'package:marvel_comics/presentation/widgets/no_internet_widget.dart';
import 'package:marvel_comics/presentation/widgets/text_display.dart';
import 'package:marvel_comics/presentation/widgets/text_field_display.dart';
import 'package:marvel_comics/routes.dart';
import 'package:marvel_comics/utilities/navigator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  List<CharacterModel> charactersList = [];
  List<CharacterModel> searchedCharacters = [];

  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getAllMarvelCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        backgroundColor: AppColor.black,
        leading:
            _isSearching ? const BackButton(color: AppColor.red) : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return const NoInternetWidget();
          }
        },
        child: LoadingWidget(),
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersSuccess) {
          charactersList = (state).comics;
          return buildComicList();
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildAppBarTitle() => Center(
        child: Image.asset(
          AppImages.logoIcon,
          width: ScreenUtil().setWidth(80),
        ),
      );

  Widget _buildSearchField() => AppEditText(
        controller: _searchTextController,
        translation: kSearch,
        prefixIcon: const Icon(Icons.search),
        onChanged: (searchedComic) {
          addSearchedFOrItemsToSearchedList(searchedComic);
        },
      );

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        InkWell(
          onTap: () {
            _clearSearch();
            Navigator.pop(context);
          },
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(4)),
            child: Center(
                child: AppTextDisplay(
              translation: kCancel,
              color: AppColor.red,
              fontSize: 14,
            )),
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(Icons.search, color: AppColor.red),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  void addSearchedFOrItemsToSearchedList(String searchedComic) {
    searchedCharacters = charactersList
        .where((comic) => comic.name.toLowerCase().startsWith(searchedComic))
        .toList();
    setState(() {});
  }

  Widget buildComicList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _searchTextController.text.isEmpty
          ? charactersList.length
          : searchedCharacters.length,
      itemBuilder: (ctx, index) {
        return comicItem(
          _searchTextController.text.isEmpty
              ? charactersList[index]
              : searchedCharacters[index],
        );
      },
    );
  }

  Widget comicItem(CharacterModel character) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, detailsScreen, arguments: character),
      child: Stack(alignment: Alignment.bottomLeft, children: [
        CachedNetworkImage(
          width: double.infinity,
          placeholder: (context, url) => LoadingWidget(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageUrl: character.thumbnail.path +
              landscapeXLarge +
              character.thumbnail.extension,
          fit: BoxFit.cover,
        ),
        Container(
          color: AppColor.white,
          padding: const EdgeInsets.all(16),
          child: AppTextDisplay(
            text: character.name,
            color: AppColor.black,
          ),
        ),
      ]),
    );
  }
}
