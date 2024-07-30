// To parse this JSON data, do
//
//     final addDataModel = addDataModelFromJson(jsonString);

import 'dart:convert';

AddDataModel addDataModelFromJson(String str) => AddDataModel.fromJson(json.decode(str));

String addDataModelToJson(AddDataModel data) => json.encode(data.toJson());

class AddDataModel {
  String? id;
  String? name;
  DataAdd? data;
  DateTime? createdAt;

  AddDataModel({
    this.id,
    this.name,
    this.data,
    this.createdAt,
  });

  factory AddDataModel.fromJson(Map<String, dynamic> json) => AddDataModel(
    id: json["id"],
    name: json["name"],
    data: json["data"] == null ? null : DataAdd.fromJson(json["data"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "data": data?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
  };
}

class DataAdd {
  int? year;
  double? price;
  String? cpuModel;
  String? hardDiskSize;

  DataAdd({
    this.year,
    this.price,
    this.cpuModel,
    this.hardDiskSize,
  });

  factory DataAdd.fromJson(Map<String, dynamic> json) => DataAdd(
    year: json["year"],
    price: json["price"]?.toDouble(),
    cpuModel: json["CPU model"],
    hardDiskSize: json["Hard disk size"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "price": price,
    "CPU model": cpuModel,
    "Hard disk size": hardDiskSize,
  };
}
