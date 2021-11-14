class TextObjectsModel {
  String type;
  String language;
  String text;

  TextObjectsModel({this.type, this.language, this.text});

  TextObjectsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    language = json['language'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['language'] = language;
    data['text'] = text;
    return data;
  }
}
