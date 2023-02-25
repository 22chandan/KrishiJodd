import 'package:flutter/material.dart';
// import 'package:krishijodd/HomePages/PostExpanded.dart';
import 'package:krishijodd/Homepage/post_list.dart';
// import 'package:krishijodd/HomePages/weather_page.dart';
// import 'package:krishijodd/HomePages/postSection_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: const [
        PostList(),
      ]),
    );
  }
}
