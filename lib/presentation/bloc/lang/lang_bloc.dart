import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:marvel_comics/data/repository/lang_reposirory.dart';
import 'lang_event.dart';
import 'lang_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String arabic = 'ar';
  static const String english = 'en';

  LanguageBloc() : super(LanguageInitial());
  String lang = 'en';

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is AppStart) {
      LanguageLoading();
      String result = await LanguageRepository.hasLang();
      lang = result ?? 'ar';
      yield LanguagChanged(language: result ?? "ar");
    } else if (event is ChangeLanguage) {
      LanguageLoading();
      lang = event.lang;
      await LanguageRepository.saveLang(lang);
      yield LanguagChanged(language: event.lang);
    }
  }
}
