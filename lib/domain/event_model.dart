import 'item_model.dart';

class EventModel {
  int available;
  String collectionURI;
  List<ItemModel> items;
  int returned;

  EventModel(
      {this.available, this.collectionURI, this.items, this.returned});

  EventModel.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    collectionURI = json['collectionURI'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(ItemModel.fromJson(v));
      });
    }
    returned = json['returned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['available'] = available;
    data['collectionURI'] = collectionURI;
    if (items != null) {
      data['items'] = items.map((v) => v.toJson()).toList();
    }
    data['returned'] = returned;
    return data;
  }
}
