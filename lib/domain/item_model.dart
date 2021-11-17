class ItemModel {
  String resourceURI;
  String name;
  String role;
  String type;

  ItemModel({
    this.resourceURI,
    this.name,
    this.role,
    this.type,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
    role = json['role'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resourceURI'] = resourceURI;
    data['name'] = name;
    data['role'] = role;
    data['type'] = this.type;
    return data;
  }
}
