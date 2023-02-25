// ignore_for_file: file_names, library_prefixes, camel_case_types

import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:krishijodd/resources.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' as rootBundle;

import 'learn_model.dart';

class learnPage extends StatefulWidget {
  const learnPage({super.key});

  @override
  State<learnPage> createState() => _learnPageState();
}

class _learnPageState extends State<learnPage> {
  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F5),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<LearnModel>;
            return ListView.builder(
                itemCount: items == null ? 0 : items.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(color: Color(0xFFEFF3F5)),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.all(2.0),
                    child: Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          items[index].title,
                          style: GoogleFonts.urbanist(
                              fontSize: currW * 0.08,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E232C)),
                        ),
                      ),
                      SizedBox(
                        height: currH * 0.011,
                      ),
                      YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: YoutubePlayer.convertUrlToId(
                              items[index].author)!,
                          flags: const YoutubePlayerFlags(
                              autoPlay: false, disableDragSeek: true),
                        ),
                        showVideoProgressIndicator: true,
                      ),
                      SizedBox(
                        height: currH * 0.01,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          items[index].description.toString(),
                          style: GoogleFonts.urbanist(
                              fontSize: currW * 0.05,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFF1E232C)),
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 8,
                      )
                    ]),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<LearnModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/resources.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => LearnModel.fromJson(e)).toList();
  }
}
