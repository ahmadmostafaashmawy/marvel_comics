class DateModel {
  String type;
  String date;

  DateModel({this.type, this.date});

  DateModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['date'] = this.date;
    return data;
  }
}