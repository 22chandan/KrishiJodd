import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:krishijodd/Model/Product.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  get product => null;

  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0.0),
        child: FutureBuilder(
            future: ReadJsonData(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var item = data.data as List<ProductDataModel>;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.75,
                    crossAxisCount: 2,
                  ),
                  itemCount: item == null ? 0 : item.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        // ignore: deprecated_member_use
                        await launch(
                            Uri.encodeFull(item[index].ProductUrl.toString()));
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 5),
                            height: currH * .268,
                            width: currW * .5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.all(10),
                                    child: Image(
                                      image: NetworkImage(
                                          item[index].imageUrl.toString()),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      item[index]
                                          .name
                                          .toString()
                                          .substring(0, 20),
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900)),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      item[index]
                                              .description
                                              .toString()
                                              .substring(0, 25) +
                                          "..." +
                                          "More",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${item[index].price}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          // ignore: deprecated_member_use
                                          await launch(Uri.encodeFull(
                                              item[index]
                                                  .ProductUrl
                                                  .toString()));
                                        },
                                        child: Container(
                                          height: currH * .035,
                                          width: currW * .15,
                                          child: Image.network(
                                            "https://www.pngkey.com/png/full/480-4803237_amazon-icon-amazon-logo-png-icon.png",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  // ignore: non_constant_identifier_names
  Future<List<ProductDataModel>> ReadJsonData() async {
    final jsonData =
        await rootBundle.rootBundle.loadString('assets/json/productlist.json');
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => ProductDataModel.fromJSON(e)).toList();
  }
}
