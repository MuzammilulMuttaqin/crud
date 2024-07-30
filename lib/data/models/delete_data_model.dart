// To parse this JSON data, do
//
//     final deleteDataModel = deleteDataModelFromJson(jsonString);

import 'dart:convert';

DeleteDataModel deleteDataModelFromJson(String str) => DeleteDataModel.fromJson(json.decode(str));

String deleteDataModelToJson(DeleteDataModel data) => json.encode(data.toJson());

class DeleteDataModel {
  String? message;

  DeleteDataModel({
    this.message,
  });

  factory DeleteDataModel.fromJson(Map<String, dynamic> json) => DeleteDataModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
