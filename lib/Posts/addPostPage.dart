// ignore_for_file: avoid_print

import 'dart:io';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishijodd/Posts/post_model.dart';
import 'post_repo.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:path/path.dart';
import 'package:lottie/lottie.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  // File? _image;
  // File? _image;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? urlDownload;
  Future uploadFile() async {}

  selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() async {
      pickedFile = result.files.first;
      // print(pickedFile!.name);
    });
  }

  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final postRepo = Get.put(PostRepo());
  CollectionReference ref = FirebaseFirestore.instance.collection('Users');
  String? userid = FirebaseAuth.instance.currentUser!.email;
  final _postRepo = Get.put(PostRepo());

  Future<String> _addPost() async {
    if (pickedFile != null) {
      final path = 'files/${pickedFile!.name}';
      final file = File(pickedFile!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file);
      urlDownload = await ref
          .getDownloadURL()
          .whenComplete(() => print("Hello its done"));
      print("Download urs is $urlDownload");
      print("Is received check");
    }

    PostModel post;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((snapshot) async {
      if (urlDownload != null) {
        post = PostModel(
          title: titlecontroller.text,
          description: descriptioncontroller.text,
          userid: userid,
          imageUrl: urlDownload,
          name: snapshot.data()!["Name"],
          profType: snapshot.data()!["profType"],
          profilePic: snapshot.data()!["profileUrl"],
        );
      } else {
        post = PostModel(
          title: titlecontroller.text,
          description: descriptioncontroller.text,
          userid: userid,
          imageUrl: null,
          name: snapshot.data()!["Name"],
          profType: snapshot.data()!["profType"],
          profilePic: snapshot.data()!["profileUrl"],
        );
      }
      return await _postRepo.addpost(post);
    });

    return "Error occured";
  }

  @override
  Widget build(BuildContext context) {
    // var add_close_button = Io;
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(239, 243, 245, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 12),
                width: currW,
                child: Row(children: [
                  Text(
                    "Title",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: currH * 0.022,
                    ),
                  )
                ]),
              ),
              SizedBox(
                  height: currH * 0.07,
                  child: TextField(
                    controller: titlecontroller,
                    textAlignVertical: TextAlignVertical.top,
                    expands: true,
                    maxLines: null,
                    style: TextStyle(
                        fontSize: currH * 0.019, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Write your title here',
                      filled: true,
                      fillColor: Color.fromRGBO(247, 247, 247, 1),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                    ),
                  )),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "Descrition",
                      style: TextStyle(
                          fontSize: currH * 0.023, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              SizedBox(
                  height: currH * 0.5,
                  child: TextField(
                    controller: descriptioncontroller,
                    // scrollPadding: EdgeInsets.all(10),
                    textAlignVertical: TextAlignVertical.top,
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Write your description here',
                      filled: true,
                      fillColor: const Color.fromRGBO(247, 247, 247, 1),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                  )),
              // Padding(padding: EdgeInsetsDirectional.all(2)),
              Column(children: [
                SizedBox(
                  height: currH * 0.053,
                  width: currW,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    child: Text(
                      'Post',
                      style: TextStyle(fontSize: currH * 0.022),
                    ),
                    onPressed: () async {
                      if (titlecontroller.text == "") {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Color.fromARGB(255, 255, 17, 0),
                          duration: Duration(seconds: 1),
                          content: Text('Enter title first.'),
                        ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        _addPost().whenComplete(() {
                          descriptioncontroller.text = "";
                          titlecontroller.text = "";
                          Navigator.pop(context);
                          // showAboutDialog();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                title: Column(
                                  children: [
                                    Lottie.asset('assets/lottie/load.json'),
                                    Center(
                                        child: Text(
                                      "Post added successfully",
                                      style: TextStyle(fontSize: currH * 0.02),
                                    )),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: Center(
                                        child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          25.0, 3.0, 25.0, 3.0),
                                      decoration: const BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      child: Text(
                                        "Ok",
                                        style: TextStyle(
                                            fontSize: currH * 0.025,
                                            color: Colors.white),
                                      ),
                                    )),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        });
                      }
                      // if (_addPost() == "Successfully posted") {
                      //   showAlertDialog(BuildContext context) {
                      //     // set up the button
                      //     Widget okButton = TextButton(
                      //       child: Text("OK"),
                      //       onPressed: () {
                      //         Navigator.of(context).pop(); // dismiss dialog
                      //       },
                      //     );

                      //     // set up the AlertDialog
                      //     AlertDialog alert = AlertDialog(
                      //       // title: Text(""),
                      //       content: Text("Successes fully posted"),
                      //       actions: [
                      //         okButton,
                      //       ],
                      //     );

                      //     // show the dialog
                      //     showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return alert;
                      //       },
                      //     );
                      //   }
                      // }
                      // // Navigator.pop(context);
                    },
                  ),
                ),
              ]),
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          elevation: 20,
          // ignore: sort_child_properties_last
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo_outlined,
                size: currH * 0.04,
              )
            ],
          ),
          icon: Icons.close,
          backgroundColor: Colors.black,
          overlayColor: Colors.white,
          spacing: 0,
          spaceBetweenChildren: 8,
          closeManually: true,
          overlayOpacity: 0,
          children: [
            SpeedDialChild(
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
              label: 'Camera',
              backgroundColor: Colors.black,
              onTap: () {},
            ),
            SpeedDialChild(
                child: Icon(
                  Icons.folder,
                  color: Colors.white,
                ),
                label: 'Gallery',
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  selectFile();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                backgroundColor: Colors.black),
          ],
        ),
        bottomSheet: Padding(padding: EdgeInsets.only(bottom: currH * 0.13)),
      ),
    );
  }
}
