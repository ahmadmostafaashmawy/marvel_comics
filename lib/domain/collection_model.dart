import 'package:marvel_comics/domain/items_model.dart';

class CollectionModel {
  int available;
  String collectionURI;
  List<ItemModel> items;
  int returned;

  CollectionModel({this.available, this.collectionURI, this.items, this.returned});

  CollectionModel.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    collectionURI = json['collectionURI'];
    if (json['items'] != null) {
      items = new List<ItemModel>();
      json['items'].forEach((v) {
        items.add(new ItemModel.fromJson(v));
      });
    }
    returned = json['returned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['collectionURI'] = this.collectionURI;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['returned'] = this.returned;
    return data;
  }
}