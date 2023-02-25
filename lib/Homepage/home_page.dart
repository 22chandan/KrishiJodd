import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:krishijodd/Posts/addPostPage.dart';
// import 'package:krishijodd/HomePages/feed_page.dart';
// import 'package:krishijodd/HomePages/learnPage.dart';
// import 'package:krishijodd/HomePages/newsPage.dart';
// import 'package:krishijodd/HomePages/preview_image.dart';
// import 'package:krishijodd/HomePages/productPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:krishijodd/Homepage/preview_image.dart';
import 'package:krishijodd/Homepage/productPage.dart';
import 'package:krishijodd/Homepage/profilePage.dart';

import '../Posts/addPostPage.dart';
import 'feed_page.dart';
import 'learnPage.dart';
import 'newsPage.dart';

// import '../profilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: non_constant_identifier_names

  List pages = const [
    FeedPage(),
    NewsPage(),
    AddNew(),
    ProductPage(),
    learnPage()
  ];
  // ignore: non_constant_identifier_names
  List Title = const [
    'KrishiJodd',
    'Local News',
    'Add Post',
    'Products',
    'Resouces'
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  String? profilePic;
  Future _getUserData() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          profilePic = snapshot.data()!["profileUrl"];
        });
      }
    });
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const profilePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.easeInCirc;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFEFF3F5),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(0),
          // padding: const EdgeInsets.fromLTRB(20, 12, 20, 2),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/kisan.png',
                          height: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
                          child: Text(
                            // Title[currentIndex],
                            "its me bro",
                            style: GoogleFonts.urbanist(
                                fontSize: currW * 0.06,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E232C)),
                          ),
                        ),
                      ],
                    ),
                    Row(children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PreviewImagePage(),
                              ));
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        child: Icon(
                          Icons.pest_control_outlined,
                          color: Color.fromARGB(255, 30, 80, 1),
                          size: currH * 0.04,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 2, 2, 2),
                        child: Material(
                          color: const Color(0xFFEFF3F5),
                          child: InkWell(
                            onTap: () {
                              // Navigator.of(context).push(_createRoute());
                            },
                            focusColor: const Color(0xFFEFF3F5),
                            hoverColor: const Color(0xFFEFF3F5),
                            splashColor: const Color(0xFFEFF3F5),
                            child: Container(
                              // ignore: sort_child_properties_last
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: profilePic == null
                                      ? Image.asset(
                                          'assets/images/hero.png',
                                          fit: BoxFit.cover,
                                          height: currH * 0.053,
                                          width: currH * 0.053,
                                        )
                                      : Image.network(
                                          profilePic!,
                                          fit: BoxFit.cover,
                                          height: currH * 0.053,
                                          width: currH * 0.053,
                                        )),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(1000),
                                border: Border.all(
                                  color: Color.fromARGB(255, 31, 31, 31),
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 160, 160, 160),
                                    offset: Offset(
                                      0.0,
                                      0.0,
                                    ),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
              SingleChildScrollView(
                  child: SizedBox(
                height: currH * 0.74,
                child: pages[currentIndex],
              ))
            ],
          ),
        )),
      ),

      //Bottom Navigation

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(0),
        child: BottomNavigationBar(
            backgroundColor: const Color(0xFFEFF3F5),
            onTap: onTap,
            type: BottomNavigationBarType.values[0],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: const Color.fromARGB(255, 41, 121, 43),
            unselectedItemColor: const Color.fromARGB(255, 52, 51, 51),
            iconSize: currH * 0.033,
            selectedFontSize: 20,
            currentIndex: currentIndex,
            elevation: 0,
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              const BottomNavigationBarItem(
                  label: 'Home', icon: Icon(Icons.home_rounded)),
              const BottomNavigationBarItem(
                  label: 'Local News', icon: Icon(Icons.newspaper_outlined)),
              BottomNavigationBarItem(
                  label: 'Add Post',
                  icon: Icon(
                    Icons.add_circle_rounded,
                    color: const Color.fromARGB(255, 14, 1, 55),
                    size: currH * 0.055,
                  )),
              const BottomNavigationBarItem(
                  label: 'Porducts', icon: Icon(Icons.shopping_bag_outlined)),
              const BottomNavigationBarItem(
                  label: 'Resouces', icon: Icon(Icons.article_rounded)),
            ]),
      ),
    );
  }
}
