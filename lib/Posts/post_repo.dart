// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:krishijodd/Login/user_model.dart';
import 'post_model.dart';

class PostRepo extends GetxController {
  static PostRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  addpost(PostModel post) async {
    // ignore: void_checks
    await _db.collection("Posts").add(post.toJson()).whenComplete(() {
      print("Successfully posted");
      return "Successfully posted";
    });
  }

  Future<List<PostModel>> allPost() async {
    final snapshot = await _db.collection("Posts").get();
    final postData =
        snapshot.docs.map((e) => PostModel.fromSnapshot(e)).toList();
    return postData;
  }
}
