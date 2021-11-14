import 'package:marvel_comics/presentation/screen/details_screen.dart';
import 'package:marvel_comics/presentation/screen/home_screen.dart';
import 'presentation/screen/splash_screen.dart';

class AppRoute {
  static const splash = '/';
  static const homeScreen = '/home';
  static const detailsScreen = '/detailsScreen';
}

var routes = {
  AppRoute.splash: (context) => const SplashScreen(),
  AppRoute.homeScreen: (context) => const HomeScreen(),
  AppRoute.detailsScreen: (context) => DetailsScreen(),
};
