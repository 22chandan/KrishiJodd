// ignore_for_file: file_names, camel_case_types
import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AuthPages/login_hero.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  launchMailto() async {
    await launch('https://wa.me/+916206194098');
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String? name = "";
  String? profession = "";
  String? about = "";
  String? address = "";
  String? profileurl = "";
  String? proftype = "";
  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["Name"];
          profession = snapshot.data()!["profType"];
          about = snapshot.data()!["about"];
          address = snapshot.data()!["address"];
          profileurl = snapshot.data()!["profileUrl"];
          proftype = snapshot.data()!["profType"];
        });
      }
    });
  }

  @override
  void initState() {
    _getDataFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFEFF3F5),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
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
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          backgroundColor: const Color(0xFF1E232C),
                          minimumSize: const Size(90, 40)),
                      child: Text(
                        "Edit",
                        style: GoogleFonts.urbanist(
                            fontSize: 18, color: Colors.white),
                      ),
                    )
                  ],
                )),
            Align(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: currH * 0.1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1000),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 160, 160, 160),
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 3.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(300.0),
                        child: profileurl != ""
                            ? Image.network(
                                profileurl!,
                                width: currH * 0.16,
                                fit: BoxFit.cover,
                                height: currH * 0.16,
                              )
                            : Image.asset(
                                'assets/images/avatar.png',
                                width: currH * 0.18,
                                fit: BoxFit.cover,
                                height: currH * 0.18,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: currH * 0.023,
                    ),
                    Text(
                      // user.displayName == null ? "Mukesh" : user.displayName!,
                      name != null ? name! : "Name nor Provided",
                      style: GoogleFonts.urbanist(
                          fontSize: currH * 0.047, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: currH * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 0, 35.0, 2.0),
                      child: Text(
                        proftype != null ? proftype! : "Address Not added",
                        style: GoogleFonts.urbanist(
                            fontSize: currH * 0.026,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: currH * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 0, 35.0, 2.0),
                      child: Text(
                        address != null ? address! : "Address Not added",
                        style: GoogleFonts.urbanist(
                            fontSize: currH * 0.022,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: currH * 0.01,
                    ),
                    Text(
                      about != null ? about! : "About not found",
                      style: GoogleFonts.urbanist(
                          fontSize: currH * 0.025,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 44, 43, 43)),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/images/123.png',
                        height: currH * 0.035,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(17.0, 0, 17.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(4.0),
                            // padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.share,
                                        color: Colors.black,
                                        size: currH * 0.028,
                                      ),
                                      SizedBox(
                                        width: currW * 0.03,
                                      ),
                                      Text(
                                        'Share',
                                        style: TextStyle(
                                            fontSize: currH * 0.023,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromARGB(
                                                255, 7, 7, 7)),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: currH * 0.025,
                                  )
                                ]),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(4.0),

                            // padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
                            child: InkWell(
                              onTap: () => launchMailto(),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.contact_support_outlined,
                                          color: Colors.black,
                                          size: currH * 0.028,
                                        ),
                                        SizedBox(
                                          width: currW * 0.03,
                                        ),
                                        Text(
                                          'Contact us',
                                          style: TextStyle(
                                              fontSize: currH * 0.023,
                                              fontWeight: FontWeight.w400,
                                              color: const Color.fromARGB(
                                                  255, 7, 7, 7)),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: currH * 0.025,
                                    )
                                  ]),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(4.0),

                            // padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.gpp_maybe_outlined,
                                        color: Colors.black,
                                        size: currH * 0.028,
                                      ),
                                      SizedBox(
                                        width: currW * 0.03,
                                      ),
                                      Text(
                                        'Privacy Policy',
                                        style: TextStyle(
                                            fontSize: currH * 0.023,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromARGB(
                                                255, 7, 7, 7)),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: currH * 0.025,
                                  )
                                ]),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(4.0),

                            // padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.assignment_outlined,
                                        color: Colors.black,
                                        size: currH * 0.028,
                                      ),
                                      SizedBox(
                                        width: currW * 0.03,
                                      ),
                                      Text(
                                        'Terms and Conditions',
                                        style: TextStyle(
                                            fontSize: currH * 0.023,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromARGB(
                                                255, 7, 7, 7)),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: currH * 0.025,
                                  )
                                ]),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                            child: OutlinedButton(
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    });
                                // if (FirebaseAuth.instance.currentUser != null) {
                                await FirebaseAuth.instance.signOut();
                                // }
                                // if (_googleSignIn.currentUser != null) {
                                _googleSignIn.signOut();
                                // }
                                // if (FirebaseAuth.instance.currentUser == null)
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginHero(),
                                    ));
                              },
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  minimumSize: const Size(90, 40)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        color: Colors.black,
                                        size: currH * 0.028,
                                      ),
                                      SizedBox(
                                        width: currW * 0.03,
                                      ),
                                      Text(
                                        "Logout",
                                        style: GoogleFonts.urbanist(
                                            fontSize: currH * 0.023,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromARGB(
                                                255, 7, 7, 7)),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: currH * 0.025,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
