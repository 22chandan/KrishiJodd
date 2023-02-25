// To parse this JSON data, do
//
//     final learnModel = learnModelFromJson(jsonString);

import 'dart:convert';

List<LearnModel> learnModelFromJson(String str) =>
    List<LearnModel>.from(json.decode(str).map((x) => LearnModel.fromJson(x)));

String learnModelToJson(List<LearnModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LearnModel {
  LearnModel({
    required this.title,
    required this.image,
    required this.description,
    required this.author,
  });

  String title;
  String image;
  String description;
  String author;

  factory LearnModel.fromJson(Map<String, dynamic> json) => LearnModel(
        title: json["title"],
        image: json["image"],
        description: json["description"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "description": description,
        "author": author,
      };
}
