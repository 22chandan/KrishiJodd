// ignore_for_file: avoid_unnecessary_containers, camel_case_types, unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'AuthPages/auth_check.dart';


class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const AuthPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // height: currH * 0.6,
              width: currW * 0.5,
              child: 
              // child: Image.network(

              //     ),
              Image.asset(
                'assets/images/kisan.png',
              ),
            ),
            const SizedBox(height: 15),
            Container(
              child: Text(
                'Krishi Jodd',
                style: GoogleFonts.urbanist(
                    fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

