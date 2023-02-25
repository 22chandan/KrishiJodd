import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'dart:io';

class PreviewImagePage extends StatefulWidget {
  const PreviewImagePage({super.key});

  @override
  State<PreviewImagePage> createState() => _PreviewImagePageState();
}

class _PreviewImagePageState extends State<PreviewImagePage> {
  File? _image;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String urlDownload = "Its url";
  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    urlDownload =
        await ref.getDownloadURL().whenComplete(() => print("Hello its done"));
    print("Download urs is " + urlDownload);
    print("Is received check");
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
      // print(pickedFile!.name);
    });
  }

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    // final imageTemporary = File(image.path);
    final imagePermanent = await saveFilePermanently(image.path);
    setState(() {
      _image = imagePermanent;
    });
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                          backgroundColor: Colors.white,
                          minimumSize: const Size(40, 40),
                          side: const BorderSide(
                              width: 1.2, color: Color(0xFF1E232C)),
                          padding: const EdgeInsets.all(8)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      // ignore: prefer_const_constructors
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 23,
                      )),
                ),
                OutlinedButton(
                  onPressed: () async {
                    uploadFile();
                  },
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      backgroundColor: const Color(0xFF1E232C),
                      minimumSize: const Size(100, 43)),
                  child: Text(
                    "Upload",
                    style:
                        GoogleFonts.urbanist(fontSize: 18, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(
              height: currH * 0.04,
            ),
            Text(
              "पौधे की फोटो अपलोड कर जानें बीमारी",
              style: TextStyle(fontSize: currW * 0.08),
            ),
            pickedFile != null
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Container(
                        height: currH * 0.2,
                        child: Image.file(File(pickedFile!.path!))),
                  )
                : Container(
                    height: currH * 0.5,
                    child: Icon(Icons.cloud_upload_outlined, size: currW * 0.4),
                  ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 32, 38, 49),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(12)),
                    minimumSize: Size(currW, currH * 0.066)),
                onPressed: () => getImage(ImageSource.camera),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Upload Image via Camara  ",
                      style: GoogleFonts.urbanist(fontSize: 18)),
                  Icon(
                    Icons.camera_alt_outlined,
                    size: currW * 0.06,
                  ),
                ])),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 32, 38, 49),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(12)),
                    minimumSize: Size(currW, currH * 0.066)),
                onPressed: () => selectFile(),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Upload Image via Gallery  ",
                      style: GoogleFonts.urbanist(fontSize: 18)),
                  Icon(
                    Icons.folder_open_outlined,
                    size: currW * 0.06,
                  ),
                ])),
            Text(urlDownload),
            if (urlDownload != "Its url")
              Image.network(urlDownload, height: 60),
          ]),
        ),
      ),
    );
  }
}
