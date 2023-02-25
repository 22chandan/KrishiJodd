import 'package:flutter/material.dart';

class ResoucePage extends StatefulWidget {
  const ResoucePage({super.key});

  @override
  State<ResoucePage> createState() => _ResoucePageState();
}

class _ResoucePageState extends State<ResoucePage> {
  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Container(
            height: currH * 0.2,
            width: currW * 0.9,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // backgroundBlendMode: ,
                // ignore: prefer_const_constructors
                image: DecorationImage(
                    // ignore: prefer_const_constructors
                    image: NetworkImage(
                        "https://krishijagran.com/media/34418/crops.png"),
                    fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}
