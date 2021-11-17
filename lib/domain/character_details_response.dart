import 'package:marvel_comics/domain/comic_model.dart';

import 'api_response.dart';

class CharacterDetailsResponse extends BaseResponse {
  int offset;
  int limit;
  int total;
  int count;
  List<ComicModel> comics;

  CharacterDetailsResponse(
      {this.offset, this.limit, this.total, this.count, this.comics});

  CharacterDetailsResponse.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      comics = [];
      json['results'].forEach((v) {
        comics.add(ComicModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offset'] = offset;
    data['limit'] = limit;
    data['total'] = total;
    data['count'] = count;
    if (comics != null) {
      data['results'] = comics.map((v) => v.toJson()).toList();
    }
    return data;
  }

  CharacterDetailsResponse.init();

  @override
  fromJson(Map<String, dynamic> json) => CharacterDetailsResponse.fromJson(json);
}
