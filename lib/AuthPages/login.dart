// ignore_for_file: file_names, use_build_context_synchronously

import 'package:auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishijodd/AuthPages/register.dart';

import '../Homepage/home_page.dart';
import 'login_hero.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  int isEmail = 0xFF1E232C;
  int isPass = 0xFF1E232C;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> _signin() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    if (emailcontrol.text.isEmpty) {
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 255, 17, 0),
        duration: Duration(seconds: 1),
        content: Text('Enter Email please'),
      ));
      setState(() {
        isEmail = 0xFF8B0000;
      });
    }
    if (passwordcontrol.text.isEmpty) {
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 255, 17, 0),
        duration: Duration(seconds: 1),
        content: Text('Enter Password.'),
      ));
      setState(() {
        isPass = 0xFF8B0000;
      });
    }
    if (emailcontrol.text.isEmpty || passwordcontrol.text.isEmpty) {
      Navigator.pop(context);
      return false;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: '${emailcontrol.text}@gmail.com',
          password: passwordcontrol.text);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
          duration: Duration(seconds: 1),
          content: Text('Account not Found'),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 17, 0),
          duration: Duration(seconds: 1),
          content: Text('Wrong password'),
        ));
      }
    }
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                        backgroundColor: Colors.white,
                        minimumSize: const Size(40, 40),
                        side: const BorderSide(
                            width: 1.3, color: Color(0xFF1E232C)),
                        padding: const EdgeInsets.all(8)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginHero(),
                          ));
                    },
                    // ignore: prefer_const_constructors
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 23,
                    )),
                SizedBox(
                  height: currH * 0.05,
                ),
                Text(
                  'Welcome back! Glad\nto see you, Again!',
                  style: GoogleFonts.urbanist(
                      fontSize: currW * 0.08,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E232C)),
                ),
                SizedBox(
                  height: currH * 0.06,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      isEmail = 0xFF1E232C;
                    });
                  },
                  controller: emailcontrol,
                  style: TextStyle(
                    color: const Color(0xFF1E232C),
                    fontSize: currH * 0.02,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(20),
                      suffixText: '@gmail.com',
                      suffixStyle: TextStyle(
                        color: const Color(0xFF1E232C),
                        fontSize: currH * 0.02,
                        fontWeight: FontWeight.w600,
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'Enter your email',
                      labelStyle: TextStyle(
                        color: const Color(0xFF8391A1),
                        fontSize: currH * 0.018,
                        fontWeight: FontWeight.w600,
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.3, color: Color(0xFF1E232C))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.3, color: Color(isEmail)))),
                ),
                SizedBox(
                  height: currH * 0.02,
                ),

                // Password

                TextField(
                  onChanged: (text) {
                    setState(() {
                      isPass = 0xFF1E232C;
                    });
                  },
                  controller: passwordcontrol,
                  obscureText: true,
                  // keyboardType: TextInputType.visiblePassword,
                  obscuringCharacter: "*",
                  style: TextStyle(
                    color: const Color(0xFF1E232C),
                    fontSize: currH * 0.02,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(20),
                      suffixIcon: const Icon(Icons.remove_red_eye),
                      labelText: 'Enter your password',
                      labelStyle: TextStyle(
                        color: const Color(0xFF8391A1),
                        fontSize: currH * 0.018,
                        fontWeight: FontWeight.w600,
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.3, color: Color(0xFF1E232C))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.3, color: Color(isPass)))),
                ),
                SizedBox(
                  height: currH * 0.07,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 32, 38, 49),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(4)),
                        minimumSize: Size(currW, currH * 0.066)),
                    onPressed: () async {
                      if (await _signin()) {
                        // ignore: use_build_context_synchronously
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                      }
                    },
                    child: Column(children: [
                      Text("Login", style: GoogleFonts.urbanist(fontSize: 20))
                    ])),
                SizedBox(
                  height: currH * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '────────  or Login with  ────────',
                      style: GoogleFonts.urbanist(
                          fontSize: currH * 0.016,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6A707C)),
                    )
                  ],
                ),
                SizedBox(
                  height: currH * 0.02,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                          width: 1.5, color: Color.fromARGB(255, 67, 73, 83)),
                      elevation: 0,
                      minimumSize: Size(currW, currH * 0.066)),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    await _googleSignIn.signIn().then((value) => {});
                    if (_googleSignIn.currentUser != null) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    }
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          // child: Image.asset(
                          //   'assets/images/google.png',
                          //   height: currH * 0.03,
                          // ),
                        ),
                        Text("Sign in with Google",
                            style: GoogleFonts.urbanist(
                                fontSize: currH * 0.021,
                                color: const Color.fromARGB(255, 53, 57, 65),
                                fontWeight: FontWeight.w600)),
                      ]),
                ),
                SizedBox(
                  height: currH * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont't have account? ",
                        style: GoogleFonts.urbanist(fontSize: currH * 0.019)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Registerpage(),
                            ));
                      },
                      child: Text("Register Now",
                          style: GoogleFonts.urbanist(
                              fontSize: currH * 0.019, color: Colors.blue)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
