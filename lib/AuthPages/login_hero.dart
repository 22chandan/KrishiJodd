// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
// import 'package:krishijodd/Login/loginPage.dart';
// import 'package:krishijodd/Login/register.dart';

class LoginHero extends StatefulWidget {
  const LoginHero({super.key});

  @override
  State<LoginHero> createState() => _LoginHeroState();
}

class _LoginHeroState extends State<LoginHero> {
  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEFF3F5),
        body: Container(
          // height: currH,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/hero.png"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Align(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.baseline,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: currH * 0.2,
                ),
                Lottie.asset('assets/lottie/86090-re-fork-farmer.json',
                    width: currW),
                SizedBox(
                  height: currH * 0.1,
                ),
                Text(
                  'KrishiJodd',
                  style: GoogleFonts.urbanist(
                      textStyle: TextStyle(
                          color: Color(0xFF1E232C),
                          fontWeight: FontWeight.w600,
                          fontSize: 30)),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1E232C),
                      elevation: 0,
                      minimumSize: Size(currW * 0.9, currH * 0.07)),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => LoginPage(),
                    //     ));
                  },
                  child:
                      Text("Login", style: GoogleFonts.urbanist(fontSize: 20)),
                ),
                SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 2, color: Color(0xFF1E232C)),
                        elevation: 0,
                        minimumSize: Size(currW * 0.9, currH * 0.07)),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const Registerpage(),
                      //     ));
                    },
                    child: Text(
                      "Register",
                      style: GoogleFonts.urbanist(
                          fontSize: 20, color: Color(0xFF1E232C)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
