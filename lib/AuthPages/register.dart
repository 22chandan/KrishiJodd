import 'package:auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:krishijodd/AuthPages/user_details.dart';
import 'package:krishijodd/AuthPages/user_model.dart';
import 'package:krishijodd/AuthPages/user_repo.dart';

import '../Homepage/home_page.dart';
import 'login.dart';
import 'login_hero.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final emailcontrol = TextEditingController();
  final namecontrol = TextEditingController();
  final confirmpasswordcontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  final userRepo = Get.put(UserRepo());
  int isName = 0xFF1E232C;
  int isEmail = 0xFF1E232C;
  int isPass = 0xFF1E232C;
  int isConfPass = 0xFF1E232C;
  bool obsCheck = true;
  Future<bool> _signUpUser() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    if (namecontrol.text.isEmpty) {
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 255, 17, 0),
        duration: Duration(seconds: 1),
        content: Text('Enter Name please'),
      ));
      setState(() {
        isName = 0xFF8B0000;
      });
    }
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
    if (confirmpasswordcontrol.text.isEmpty) {
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 255, 17, 0),
        duration: Duration(seconds: 1),
        content: Text('Enter confirm password.'),
      ));
      setState(() {
        isConfPass = 0xFF8B0000;
      });
    }
    if (namecontrol.text.isEmpty ||
        emailcontrol.text.isEmpty ||
        passwordcontrol.text.isEmpty ||
        confirmpasswordcontrol.text.isEmpty) {
      Navigator.pop(context);
      return false;
    }
    if (passwordcontrol.text != confirmpasswordcontrol.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 255, 17, 0),
        duration: Duration(seconds: 1),
        content: Text("Password and confirm Password didn't match"),
      ));
    } else {
      final user = UserModel(
          id: "${emailcontrol.text}@gmail.com",
          name: namecontrol.text,
          email: "${emailcontrol.text}@gmail.com",
          password: passwordcontrol.text);
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: '${emailcontrol.text}@gmail.com',
          password: passwordcontrol.text,
        );
        await userRepo.createUser(user);
        print(user.email); // ignore: use_build_context_synchronously
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(255, 255, 17, 0),
            duration: Duration(seconds: 1),
            content: Text('Password must contain atleast 6 character'),
          ));
          Navigator.pop(context);

          return false;
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(255, 255, 17, 0),
            duration: Duration(seconds: 1),
            content: Text('The account already exists for that email.'),
          ));
          Navigator.pop(context);
          return false;
        }
      } catch (e) {
        print(e);
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
                  'Hello! Register to get started',
                  style: GoogleFonts.urbanist(
                      fontSize: currW * 0.08,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E232C)),
                ),
                SizedBox(
                  height: currH * 0.03,
                ),
                TextField(
                  controller: namecontrol,
                  onChanged: (text) {
                    setState(() {
                      isName = 0xFF1E232C;
                    });
                  },
                  style: TextStyle(
                    color: const Color(0xFF1E232C),
                    fontSize: currH * 0.019,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        color: Color(0xFF8391A1),
                        fontSize: currH * 0.016,
                        fontWeight: FontWeight.w600,
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.2, color: Color(0xFF1E232C))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.2, color: Color(isName)))),
                ),
                SizedBox(
                  height: currH * 0.015,
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
                    fontSize: currH * 0.019,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(15),
                      suffixText: '@gmail.com',
                      suffixStyle: TextStyle(
                        color: const Color(0xFF1E232C),
                        fontSize: currH * 0.019,
                        fontWeight: FontWeight.w600,
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: const Color(0xFF8391A1),
                        fontSize: currH * 0.018,
                        fontWeight: FontWeight.w600,
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.2, color: Color(0xFF1E232C))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.2, color: Color(isEmail)))),
                ),
                const SizedBox(
                  height: 10,
                ),

                // Password

                TextField(
                  onTap: () {
                    setState(() {
                      obsCheck = !obsCheck;
                    });
                  },
                  onChanged: (text) {
                    setState(() {
                      isPass = 0xFF1E232C;
                    });
                  },
                  controller: passwordcontrol,
                  obscureText: obsCheck,
                  // keyboardType: TextInputType.visiblePassword,
                  obscuringCharacter: "*",
                  style: TextStyle(
                    color: const Color(0xFF1E232C),
                    fontSize: currH * 0.019,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(15),
                      suffixIcon: Icon(
                        Icons.remove_red_eye,
                        size: currH * 0.019,
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: const Color(0xFF8391A1),
                        fontSize: currH * 0.018,
                        fontWeight: FontWeight.w600,
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.2, color: Color(0xFF1E232C))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.2, color: Color(isPass)))),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text("  *Password must be min of 6 char ",
                    style: GoogleFonts.urbanist(fontSize: currH * 0.017)),
                SizedBox(
                  height: currH * 0.009,
                ),

                // Password

                TextField(
                  onChanged: (text) {
                    setState(() {
                      isConfPass = 0xFF1E232C;
                    });
                  },
                  controller: confirmpasswordcontrol,
                  obscureText: true,
                  // keyboardType: TextInputType.visiblePassword,
                  obscuringCharacter: "*",
                  style: TextStyle(
                    color: const Color(0xFF1E232C),
                    fontSize: currH * 0.019,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(15),
                      suffixIcon: Icon(
                        Icons.remove_red_eye,
                        size: currH * 0.019,
                      ),
                      labelText: 'Confirm password',
                      labelStyle: TextStyle(
                        color: Color(0xFF8391A1),
                        fontSize: currH * 0.018,
                        fontWeight: FontWeight.w600,
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.2, color: Color(0xFF1E232C))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.2, color: Color(isConfPass)))),
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
                      if (await _signUpUser()) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddProfileDetails(),
                            ));
                      }
                    },
                    child: Column(children: [
                      Text("Register",
                          style: GoogleFonts.urbanist(fontSize: currH * 0.019))
                    ])),
                SizedBox(
                  height: currH * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '────────  or Register with  ────────',
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
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
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
                        Text("Sign up with Google",
                            style: GoogleFonts.urbanist(
                                fontSize: currH * 0.021,
                                color: const Color.fromARGB(255, 53, 57, 65),
                                fontWeight: FontWeight.w600)),
                      ]),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",
                        style: GoogleFonts.urbanist(fontSize: currH * 0.019)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },
                        child: Text("Login Now",
                            style: GoogleFonts.urbanist(
                                fontSize: currH * 0.019, color: Colors.blue)))
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
