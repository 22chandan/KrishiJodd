import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krishijodd/AuthPages/user_model.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  createUser(UserModel user) async {
    await _db
        .collection("Users")
        .doc(user.id)
        .set(user.toJson())
        // ignore: avoid_print
        .whenComplete(() => print(user.id));
  }
}
