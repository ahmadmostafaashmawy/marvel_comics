// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:marvel_comics/presentation/widgets/size.dart';
// import 'package:marvel_comics/presentation/widgets/snakBar.dart';
// import 'package:marvel_comics/utilities/navigator.dart';
// import 'package:weather/bloc/get_city_forecast/get_city_forecast_bloc.dart';
// import 'package:weather/bloc/get_city_forecast/get_city_forecast_event.dart';
// import 'package:weather/bloc/get_city_forecast/get_city_forecast_state.dart';
// import 'package:weather/model/weather_response.dart';
// import 'package:weather/routes.dart';
// import 'package:weather/utilities/app_color.dart';
// import 'package:weather/utilities/app_edit_validator.dart';
// import 'package:weather/utilities/app_images.dart';
// import 'package:weather/utilities/localization/localization_constains.dart';
// import 'package:weather/utilities/navigator.dart';
// import 'package:weather/view/city_forecast_builder.dart';
// import 'package:weather/view/home_header.dart';
// import 'package:weather/widgets/button_display.dart';
// import 'package:weather/widgets/loading.dart';
// import 'package:weather/widgets/size.dart';
// import 'package:weather/widgets/snak_bar.dart';
// import 'package:weather/widgets/text_display.dart';
// import 'package:weather/widgets/text_field_display.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   var formKey = GlobalKey<FormState>();
//   var citiesEditTextController = TextEditingController();
//   List<WeatherResponse> citiesForecast = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => FetchCityForecastBLoc(),
//       child: Scaffold(
//         backgroundColor: AppColor.BackgroundColor,
//         body: Form(
//           key: formKey,
//           child: SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   HomeHeader(
//                     iconPath: AppImages.forecastCurrentLocationIcon,
//                     onClick: () =>
//                         pushName(context, AppRoute.currentCityForecastScreen),
//                   ),
//                   buildTextHeader(),
//                   WidthBox(4),
//                   buildCities(),
//                   if (citiesForecast.isNotEmpty) buildCitiesList()
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildCities() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//               child: AppEditText(
//             text: "Ex: Cairo, Berlin, New York",
//             controller: citiesEditTextController,
//             validator: (value) => validatorStringRequired(value, context),
//           )),
//           WidthBox(8),
//           buildButtonConsumer()
//         ],
//       ),
//     );
//   }
//
//   Widget buildButtonConsumer() {
//     return BlocConsumer<FetchCityForecastBLoc, FetchCityForecastState>(
//         listener: fetchForecastListener,
//         builder: (context, state) {
//           return state is GetCityLoading
//               ? LoadingWidget()
//               : buildAppButton(context);
//         });
//   }
//
//   Widget buildAppButton(BuildContext context) {
//     return AppButton(
//         translation: kGet,
//         onTap: () {
//           if (!formKey.currentState.validate()) {
//             return;
//           }
//           List<String> cities = [];
//           List<String> str = citiesEditTextController.text.split(',');
//           for (String cityName in str) {
//             if (RegExp(r'^[a-zA-Z ]+$')
//                 .hasMatch(cityName.trimLeft().trimRight())) {
//               cities.add(cityName);
//             }
//           }
//           if (cities.isNotEmpty) {
//             BlocProvider.of<FetchCityForecastBLoc>(context)
//                 .add(FetchEvent(cities));
//           } else {
//             showSnackBar(context, "You have to type a right city name");
//           }
//         });
//   }
//
//   void fetchForecastListener(
//       BuildContext context, FetchCityForecastState state) {
//     if (state is GetCitySuccess) {
//       setState(() => citiesForecast = state.citiesForecast);
//     } else if (state is GetCityFailed) {
//       showSnackBar(
//           context,
//           state.error != null || state.error != "null"
//               ? state.error
//               : "Error!");
//       // print(state.error);
//     }
//   }
//
//   Widget buildTextHeader() {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: AppTextDisplay(
//           translation: kEnterCities,
//           textAlign: TextAlign.start,
//           color: AppColor.DarkBlue,
//         ),
//       ),
//     );
//   }
//
//   Widget buildCitiesList() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GridView.builder(
//         shrinkWrap: true,
//         itemCount: citiesForecast.length,
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (BuildContext context, int index) {
//           return CityForecastBuilder(cityForecast: citiesForecast[index]);
//         },
//       ),
//     );
//   }
// }

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
import 'package:marvel_comics/domain/comic_model.dart';
import 'package:marvel_comics/presentation/bloc/comic/comic_cubit.dart';
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
  ComicRepository comicRepository;
  ComicCubit comicCubit;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  List<ComicModel> comicsList = [];
  List<ComicModel> searchedComics = [];

  @override
  void initState() {
    comicRepository = ComicRepository(ComicWebServices());
    comicCubit = ComicCubit(comicRepository);
    comicCubit.getAllComics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext blocContext) => comicCubit,
      child: Scaffold(
        backgroundColor: AppColor.black,
        appBar: AppBar(
          backgroundColor: AppColor.black,
          leading: _isSearching
              ? const BackButton(color: AppColor.red)
              : Container(),
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
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ComicCubit, ComicState>(
      builder: (context, state) {
        if (state is ComicSuccess) {
          comicsList = (state).comics;
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
    searchedComics = comicsList
        .where((comic) => comic.title.toLowerCase().startsWith(searchedComic))
        .toList();
    setState(() {});
  }

  Widget buildComicList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _searchTextController.text.isEmpty
          ? comicsList.length
          : searchedComics.length,
      itemBuilder: (ctx, index) {
        return comicItem(
          _searchTextController.text.isEmpty
              ? comicsList[index]
              : searchedComics[index],
        );
      },
    );
  }

  Widget comicItem(ComicModel comic) {
    return InkWell(
      onTap: () => pushName(context, AppRoute.detailsScreen, arguments: comic),
      child: Stack(alignment: Alignment.bottomLeft, children: [
        FadeInImage.assetNetwork(
          width: double.infinity,
          placeholder: AppImages.loadingImg,
          image: comic.thumbnail.path +
              landscapeXLarge +
              comic.thumbnail.extension,
          fit: BoxFit.cover,
        ),
        Container(
          color: AppColor.white,
          padding: const EdgeInsets.all(16),
          child: AppTextDisplay(
            text: comic.title,
            color: AppColor.black,
          ),
        ),
      ]),
    );
  }
}
