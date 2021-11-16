import 'package:dio/dio.dart';
import 'package:marvel_comics/utilities/api_utils.dart';
import '../../constants/strings.dart';

class ComicWebServices {
  Dio dio;

  ComicWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }

  Future<dynamic> getAllComics() async {
    try {
      int ts = generateTimeStamp();
      print("timestamps: $ts");
      print("timestamps: ${generateMd5(ts.toString(), privateKey, publicKey)}");
      Response response = await dio.get('characters', queryParameters: {
        'ts': ts,
        'apikey': publicKey,
        'hash': generateMd5(ts.toString(), privateKey, publicKey)
      });
      print(response.data.toString());
      return response;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
