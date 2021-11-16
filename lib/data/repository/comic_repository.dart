import 'package:dio/dio.dart';
import 'package:marvel_comics/domain/base_response.dart';

import '../../domain/comic_response.dart';
import '../web_services/comic_web_services.dart';

class ComicRepository {
  final ComicWebServices comicWebServices;

  ComicRepository(this.comicWebServices);

  Future<AppResponse<CharacterResponse>> getComics() async {
    var response = await comicWebServices.getAllComics();
    return AppResponse<CharacterResponse>.fromJson(
        response.data, CharacterResponse.init(),
        isList: false);
  }
}
