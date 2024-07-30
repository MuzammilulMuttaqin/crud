// To parse this JSON data, do
//
//     final updateDataModel = updateDataModelFromJson(jsonString);

import 'dart:convert';

UpdateDataModel updateDataModelFromJson(String str) => UpdateDataModel.fromJson(json.decode(str));

String updateDataModelToJson(UpdateDataModel data) => json.encode(data.toJson());

class UpdateDataModel {
  String? id;
  String? name;
  Data? data;
  DateTime? updatedAt;

  UpdateDataModel({
    this.id,
    this.name,
    this.data,
    this.updatedAt,
  });

  factory UpdateDataModel.fromJson(Map<String, dynamic> json) => UpdateDataModel(
    id: json["id"],
    name: json["name"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "data": data?.toJson(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Data {
  int? year;
  double? price;
  String? cpuModel;
  String? hardDiskSize;
  String? color;

  Data({
    this.year,
    this.price,
    this.cpuModel,
    this.hardDiskSize,
    this.color,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    year: json["year"],
    price: json["price"]?.toDouble(),
    cpuModel: json["CPU model"],
    hardDiskSize: json["Hard disk size"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "price": price,
    "CPU model": cpuModel,
    "Hard disk size": hardDiskSize,
    "color": color,
  };
}
