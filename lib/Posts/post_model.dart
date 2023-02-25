import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? id;
  final String? title;
  final String? description;
  final String? userid;
  final String? imageUrl;
  final String? profilePic;
  final String? name;
  final String? profType;

  const PostModel({
    this.id,
    required this.title,
    required this.description,
    required this.userid,
    required this.imageUrl,
    required this.profilePic,
    required this.name,
    required this.profType,
  });

  toJson() {
    return {
      "Title": title,
      "description": description,
      "userId": userid,
      "imageUrl": imageUrl,
      "profilePic": profilePic,
      "name": name,
      "profType": profType
    };
  }

  factory PostModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PostModel(
        title: data["Title"],
        description: data["description"],
        userid: data["userId"],
        imageUrl: data["imageUrl"],
        name: data["name"],
        profType: data["profType"],
        profilePic: data["profilePic"],
        )
        ;
  }
}
