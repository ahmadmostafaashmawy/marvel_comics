class ItemModel {
  String resourceURI;
  String name;
  String type;

  ItemModel({this.resourceURI, this.name, this.type});

  ItemModel.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceURI'] = this.resourceURI;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}
