// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Homepage/home_page.dart';

// import '../HomePages/home_page.dart';

class AddProfileDetails extends StatefulWidget {
  const AddProfileDetails({Key? myKey}) : super(key: myKey);
  @override
  State<AddProfileDetails> createState() => _AddProfileDetailsState();
}

class _AddProfileDetailsState extends State<AddProfileDetails> {
  final about = TextEditingController();
  final address = TextEditingController();

  String dropdownvalueprof = 'Farmer';
  var profess = ["Farmer", "Agriculture Expert"];
  String dropdownvaluelang = 'English';
  var lang = ["English", "Hindi", "Bengali"];
  String? _image;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final User user;
  Future<void> inputData() async {
    user = await auth.currentUser!;
  }

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? urlDownload;
  Future uploadFile() async {}

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
      print(pickedFile!.name);
    });
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final refimg = FirebaseStorage.instance.ref().child(path);
    await refimg.putFile(file);
    urlDownload = await refimg.getDownloadURL();
    print("Download url is ${urlDownload!}");
    print("Is received check");
  }

  CollectionReference ref = FirebaseFirestore.instance.collection('Users');

  // Future getImage(ImageSource source) async {
  //   final image = await ImagePicker().pickImage(source: source);
  //   if (image == null) return;
  //   // final imageTemporary = File(image.path);
  //   final imagePermanent = await saveFilePermanently(image.path);
  //   setState(() {
  //     _image = imagePermanent;
  //   });
  // }

  // Future<File> saveFilePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${directory.path}/$name');
  //   return File(imagePath).copy(image.path);
  // }

  @override
  void initState() {
    inputData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(23.0),
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: currH * 0.04,
              ),
              Text(
                "Enter profile detail’s",
                style: GoogleFonts.urbanist(
                    fontSize: currW * 0.08,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E232C)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(200.0),
                              child: pickedFile == null
                                  ? Image.network(
                                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                                      height: currH * 0.14,
                                      width: currH * 0.14,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(pickedFile!.path!),
                                      height: currH * 0.14,
                                      width: currH * 0.14,
                                      fit: BoxFit.cover,
                                    ))),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            currW * 0.21, currH * 0.13, 0, 0),
                        child: InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                            await selectFile();
                            Navigator.pop(context);
                          },
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      blurRadius: 0.0,
                                      spreadRadius: 2,
                                    ),
                                  ]),
                              // ignore: prefer_const_constructors
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 20,
                                ),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: currH * 0.02,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border:
                        Border.all(color: const Color(0xFF1E232C), width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(
                      8.0), //here include this to get padding
                  child: DropdownButton(
                    isExpanded: true,
                    underline: Container(),
                    alignment: Alignment.bottomCenter,
                    elevation: 0,
                    value: dropdownvalueprof,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: profess.map((String profess) {
                      return DropdownMenuItem(
                        value: profess,
                        child: Text(profess),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalueprof = newValue!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: currH * 0.02,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xFF1E232C), width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(
                      8.0), //here include this to get padding
                  child: DropdownButton(
                    isExpanded: true,
                    underline: Container(),
                    alignment: Alignment.bottomCenter,
                    elevation: 0,
                    value: dropdownvaluelang,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: lang.map((String lang) {
                      return DropdownMenuItem(
                        value: lang,
                        child: Text(lang),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvaluelang = newValue!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: currH * 0.02,
              ),
              SizedBox(
                // height: currH * 0.2,
                child: TextField(
                  controller: address,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                    color: const Color(0xFF1E232C),
                    fontSize: currH * 0.023,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Address',
                      labelStyle: TextStyle(
                        color: const Color(0xFF8391A1),
                        fontSize: currH * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF1E232C))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF1E232C)))),
                ),
              ),
              SizedBox(
                height: currW * 0.04,
              ),
              SizedBox(
                // height: currH * 0.3,
                child: TextField(
                  controller: about,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                    color: const Color(0xFF1E232C),
                    fontSize: currH * 0.023,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'About',
                      labelStyle: TextStyle(
                        color: const Color(0xFF8391A1),
                        fontSize: currH * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF1E232C))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF1E232C)))),
                ),
              ),
              SizedBox(
                height: currH * 0.05,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 24, 28, 36),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(6)),
                      minimumSize: Size(currW, currH * 0.06)),
                  onPressed: () async {
                    if (address.text != "" &&
                        about.text != "" &&
                        pickedFile != null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      await ref.doc(user.email).update({
                        'profType': dropdownvalueprof,
                        'language': dropdownvaluelang,
                        'address': address.text,
                        'about': about.text,
                        'profileUrl': urlDownload,
                      });

                      Navigator.pop(context);
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
                                  "Account created successfully",
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
                                    "Continue",
                                    style: TextStyle(
                                        fontSize: currH * 0.025,
                                        color: Colors.white),
                                  ),
                                )),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ));
                                },
                              )
                            ],
                          );
                        },
                      );
                      // ignore: use_build_context_synchronously
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 255, 17, 0),
                        duration: Duration(seconds: 1),
                        content: Text('Please omplete the details first'),
                      ));
                    }
                    // ignore: use_build_context_synchronously

                    // ignore: use_build_context_synchronously
                  },
                  child: Column(children: [
                    Text("Complete Registration",
                        style: GoogleFonts.urbanist(fontSize: currH * 0.019))
                  ])),
            ],
          )),
        ),
      ),
    );
  }
}
