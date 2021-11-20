import 'package:marvel_comics/domain/event_model.dart';
import 'package:marvel_comics/domain/item_model.dart';
import 'package:marvel_comics/domain/url_model.dart';

import 'comic_thumbnail.dart';
import 'creator_model.dart';

class ComicModel {
  int id;
  String title;
  String description;
  String resourceURI;
  List<UrlModel> urls;
  int startYear;
  int endYear;
  String rating;
  String type;
  String modified;
  ThumbnailModel thumbnail;
  CreatorModel creators;
  CreatorModel characters;
  CreatorModel stories;
  CreatorModel comics;
  EventModel events;
  ItemModel next;
  ItemModel previous;

  ComicModel(
      {this.id,
      this.title,
      this.description,
      this.resourceURI,
      this.urls,
      this.startYear,
      this.endYear,
      this.rating,
      this.type,
      this.modified,
      this.thumbnail,
      this.creators,
      this.characters,
      this.stories,
      this.comics,
      this.events,
      this.next,
      this.previous});

  ComicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    resourceURI = json['resourceURI'];
    if (json['urls'] != null) {
      urls = [];
      json['urls'].forEach((v) {
        urls.add(UrlModel.fromJson(v));
      });
    }
    startYear = json['startYear'];
    endYear = json['endYear'];
    rating = json['rating'];
    type = json['type'];
    modified = json['modified'];
    thumbnail = json['thumbnail'] != null
        ? ThumbnailModel.fromJson(json['thumbnail'])
        : null;
    creators = json['creators'] != null
        ? CreatorModel.fromJson(json['creators'])
        : null;
    characters = json['characters'] != null
        ? CreatorModel.fromJson(json['characters'])
        : null;
    stories =
        json['stories'] != null ? CreatorModel.fromJson(json['stories']) : null;
    comics =
        json['comics'] != null ? CreatorModel.fromJson(json['comics']) : null;
    events =
        json['events'] != null ? EventModel.fromJson(json['events']) : null;
    next = json['next'] != null ? ItemModel.fromJson(json['next']) : null;
    previous =
        json['previous'] != null ? ItemModel.fromJson(json['previous']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['resourceURI'] = resourceURI;
    if (urls != null) {
      data['urls'] = urls.map((v) => v.toJson()).toList();
    }
    data['startYear'] = startYear;
    data['endYear'] = endYear;
    data['rating'] = rating;
    data['type'] = type;
    data['modified'] = modified;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail.toJson();
    }
    if (creators != null) {
      data['creators'] = creators.toJson();
    }
    if (characters != null) {
      data['characters'] = characters.toJson();
    }
    if (stories != null) {
      data['stories'] = stories.toJson();
    }
    if (comics != null) {
      data['comics'] = comics.toJson();
    }
    if (events != null) {
      data['events'] = events.toJson();
    }
    if (next != null) {
      data['next'] = next.toJson();
    }
    if (previous != null) {
      data['previous'] = previous.toJson();
    }
    return data;
  }
}
