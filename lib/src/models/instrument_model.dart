import 'dart:convert';

InstrumentModel instrumentModelFromJson(String str) => InstrumentModel.fromJson(json.decode(str));

String instrumentModelToJson(InstrumentModel data) => json.encode(data.toJson());

class InstrumentModel {
  String id;
  String title;
  String type;
  double value;
  bool available;
  String urlImage;

  InstrumentModel({
    this.id,
    this.title      = '',
    this.type       = '',
    this.value      = 0.0,
    this.available  = true,
    this.urlImage,
  });

  factory InstrumentModel.fromJson(Map<String, dynamic> json) => InstrumentModel(
    id        : json["id"],
    title     : json["title"],
    type      : json["type"],
    value     : json["value"],
    available : json["available"],
    urlImage  : json["urlImage"],
  );

  Map<String, dynamic> toJson() => {
    //"id"        : id,
    "title"     : title,
    "type"      : type,
    "value"     : value,
    "available" : available,
    "urlImage"  : urlImage,
  };
}
