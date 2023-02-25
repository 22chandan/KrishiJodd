import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'news_model.dart';


class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Article> result = [];
  bool mainLoader = true;
  bool loading = true;
  int page = 1;
  @override
  void initState() {
    super.initState();
    _getNews(page);
    getMore();
  }

  void _getNews(parapage) async {
    setState(() {
      loading = true;
    });
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=agriculture&apiKey=8af874f5041343518f316ddd42a2b9b7&page=$parapage&pageSize=7"));
    NewsModel newsmodel = NewsModel.fromJson(json.decode(response.body));
    result = result + newsmodel.articles;
    int localpage = page + 1;
    setState(() {
      result;
      loading = false;
      mainLoader = false;
      page = localpage;
    });
  }

  ScrollController scrollController = ScrollController();

  void getMore() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        _getNews(page);
      }
    });
  }
  // Future<void> _launchUrl  () async {
  //   final Uri url =
  // }

  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xFFEFF3F5),
        body: mainLoader
            // ignore: prefer_const_constructors
            ? Padding(
                padding: const EdgeInsets.all(30),
                child: Center(child: CircularProgressIndicator()))
            : ListView.builder(
                shrinkWrap: true,
                controller: scrollController,
                itemCount: result.length,
                itemBuilder: ((context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: InkWell(
                      onTap: () async {
                        await launch(Uri.encodeFull(result[index].url));
                      },
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Color(0xFFEFF3F5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(15), // Image border
                                child: SizedBox.fromSize(
                                  // Image radius
                                  child: Image.network(result[index].urlToImage,
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(result[index].title,
                                  style: GoogleFonts.urbanist(
                                      color: const Color(0xFF2D2D2D),
                                      fontSize: currH * 0.027,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      result[index].source.name,
                                      style: GoogleFonts.urbanist(
                                          fontSize: currH * 0.02),
                                    ),
                                    if (result[index].url != null)
                                      Text(
                                        result[index]
                                            .publishedAt
                                            .toString()
                                            .substring(0, 10),
                                        style: GoogleFonts.urbanist(
                                            fontSize: currH * 0.02),
                                      )
                                  ]),
                            ),
                            loading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : const Text('')
                          ],
                        ),
                      ),
                    ))),
              ));
  }
}
