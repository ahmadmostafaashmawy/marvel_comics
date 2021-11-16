import 'api_response.dart';
import 'character_model.dart';

class CharacterResponse extends BaseResponse {
  int offset;
  int limit;
  int total;
  int count;
  List<CharacterModel> comics;

  CharacterResponse(
      {this.offset, this.limit, this.total, this.count, this.comics});

  CharacterResponse.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      comics = [];
      json['results'].forEach((v) {
        comics.add(CharacterModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = offset;
    data['limit'] = limit;
    data['total'] = total;
    data['count'] = count;
    if (comics != null) {
      data['results'] = comics.map((v) => v.toJson()).toList();
    }
    return data;
  }

  CharacterResponse.init();

  @override
  fromJson(Map<String, dynamic> json) => CharacterResponse.fromJson(json);
}
