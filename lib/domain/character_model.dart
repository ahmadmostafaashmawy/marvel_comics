import 'package:marvel_comics/domain/collection_model.dart';
import 'package:marvel_comics/domain/comic_thumbnail.dart';
import 'package:marvel_comics/domain/url_model.dart';
import 'package:marvel_comics/domain/url_model.dart';

class CharacterModel {
  int id;
  String name;
  String description;
  String modified;
  ThumbnailModel thumbnail;
  String resourceURI;
  CollectionModel comics;
  CollectionModel series;
  CollectionModel stories;
  CollectionModel events;
  List<UrlModel> urls;

  CharacterModel(
      {this.id,
      this.name,
      this.description,
      this.modified,
      this.thumbnail,
      this.resourceURI,
      this.comics,
      this.series,
      this.stories,
      this.events,
      this.urls});

  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    modified = json['modified'];
    thumbnail = json['thumbnail'] != null
        ? ThumbnailModel.fromJson(json['thumbnail'])
        : null;
    resourceURI = json['resourceURI'];
    comics = json['comics'] != null
        ? CollectionModel.fromJson(json['comics'])
        : null;
    series = json['series'] != null
        ? CollectionModel.fromJson(json['series'])
        : null;
    stories = json['characters'] != null
        ? CollectionModel.fromJson(json['characters'])
        : null;
    events = json['events'] != null
        ? CollectionModel.fromJson(json['events'])
        : null;
    if (json['urls'] != null) {
      urls = [];
      json['urls'].forEach((v) {
        urls.add(UrlModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['modified'] = modified;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail.toJson();
    }
    data['resourceURI'] = resourceURI;
    if (comics != null) {
      data['comics'] = comics.toJson();
    }
    if (series != null) {
      data['series'] = series.toJson();
    }
    if (stories != null) {
      data['characters'] = stories.toJson();
    }
    if (events != null) {
      data['events'] = events.toJson();
    }
    if (urls != null) {
      data['urls'] = urls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
