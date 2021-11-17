import 'package:marvel_comics/domain/comic_url.dart';
import 'package:marvel_comics/domain/creator_model.dart';
import 'package:marvel_comics/domain/event_model.dart';
import 'package:marvel_comics/domain/url_model.dart';
import 'package:marvel_comics/domain/text_object.dart';

import 'comic_thumbnail.dart';
import 'date_model.dart';

class ComicModel {
  int id;
  String title;
  String variantDescription;
  String description;
  int pageCount;
  List<TextObjectsModel> textObjects;
  String resourceURI;
  List<ComicUrlModel> urls;
  UrlModel series;
  List<UrlModel> variants;
  List<UrlModel> collectedIssues;
  List<DateModel> dates;
  ThumbnailModel thumbnail;
  List<ThumbnailModel> images;
  CreatorModel creators;
  CreatorModel characters;
  CreatorModel stories;
  EventModel events;

  ComicModel(
      {this.id,
      this.title,
      this.variantDescription,
      this.description,
      this.pageCount,
      this.textObjects,
      this.resourceURI,
      this.urls,
      this.series,
      this.variants,
      this.collectedIssues,
      this.dates,
      this.thumbnail,
      this.images,
      this.creators,
      this.characters,
      this.stories,
      this.events});

  ComicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    variantDescription = json['variantDescription'];
    description = json['description'];
    pageCount = json['pageCount'];
    if (json['textObjects'] != null) {
      textObjects = [];
      json['textObjects'].forEach((v) {
        textObjects.add(TextObjectsModel.fromJson(v));
      });
    }
    resourceURI = json['resourceURI'];
    if (json['urls'] != null) {
      urls = [];
      json['urls'].forEach((v) {
        urls.add(ComicUrlModel.fromJson(v));
      });
    }
    series =
        json['series'] != null ? UrlModel.fromJson(json['series']) : null;
    if (json['variants'] != null) {
      variants = [];
      json['variants'].forEach((v) {
        variants.add(UrlModel.fromJson(v));
      });
    }
    if (json['collectedIssues'] != null) {
      collectedIssues = [];
      json['collectedIssues'].forEach((v) {
        collectedIssues.add(UrlModel.fromJson(v));
      });
    }
    if (json['dates'] != null) {
      dates = [];
      json['dates'].forEach((v) {
        dates.add(DateModel.fromJson(v));
      });
    }
    thumbnail = json['thumbnail'] != null
        ? ThumbnailModel.fromJson(json['thumbnail'])
        : null;
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(ThumbnailModel.fromJson(v));
      });
    }
    creators =
        json['creators'] != null ? CreatorModel.fromJson(json['creators']) : null;
    characters = json['characters'] != null
        ? CreatorModel.fromJson(json['characters'])
        : null;
    stories =
        json['stories'] != null ? CreatorModel.fromJson(json['stories']) : null;
    events =
        json['events'] != null ? EventModel.fromJson(json['events']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['variantDescription'] = variantDescription;
    data['description'] = description;
    data['pageCount'] = pageCount;
    if (textObjects != null) {
      data['textObjects'] = textObjects.map((v) => v.toJson()).toList();
    }
    data['resourceURI'] = resourceURI;
    if (urls != null) {
      data['urls'] = urls.map((v) => v.toJson()).toList();
    }
    if (series != null) {
      data['series'] = series.toJson();
    }
    if (variants != null) {
      data['variants'] = variants.map((v) => v.toJson()).toList();
    }
    if (collectedIssues != null) {
      data['collectedIssues'] = collectedIssues.map((v) => v.toJson()).toList();
    }
    if (dates != null) {
      data['dates'] = dates.map((v) => v.toJson()).toList();
    }
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail.toJson();
    }
    if (images != null) {
      data['images'] = images.map((v) => v.toJson()).toList();
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
    if (events != null) {
      data['events'] = events.toJson();
    }
    return data;
  }
}
