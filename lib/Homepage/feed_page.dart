import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:krishijodd/HomePages/PostExpanded.dart';
import 'package:krishijodd/Homepage/post_list.dart';
import 'package:krishijodd/Homepage/weather_page.dart';
import 'package:readmore/readmore.dart';
// import 'package:krishijodd/HomePages/postSection_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Posts');
  // ignore: prefer_typing_uninitialized_variables
  var allData;
  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    // print(allData);
  }

  @override
  void initState() {
    // getData();
    super.initState();
  }

  int _likes = 0;

  void _toggleLike() {
    setState(() {
      _likes = _likes == 0 ? 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;
    bool isLiked = false;
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        // inside the <> you enter the type of your stream
        stream: FirebaseFirestore.instance.collection("Posts").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: SizedBox(
                height: currH,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // ignore: no_leading_underscores_for_local_identifiers

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      ),
                      child: Column(
                        children: [
                          if (index == 0) const WeatherPage(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Color(0xFFEFF3F5),
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 0,
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(bottom: 5)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10)),
                                            Material(
                                              elevation:
                                                  2.0, // Add elevation to the avatar image
                                              borderRadius:
                                                  BorderRadius.circular(23),
                                              clipBehavior: Clip.antiAlias,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1000),
                                                  // border: Border.all(
                                                  //   color: Color.fromARGB(
                                                  //       255, 31, 31, 31),
                                                  //   width: 1,
                                                  // ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  child: Image.network(
                                                    snapshot.data!.docs[index]
                                                        .get('profilePic'),
                                                    width: currW * 0.126,
                                                    height: currW * 0.126,
                                                    // height: currH * .07,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: currW * 0.02,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      .get('name'),
                                                  style: TextStyle(
                                                      fontSize: currH * 0.023,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 63, 63, 63),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      .get('profType'),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          255, 146, 146, 146)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: currW * 0.03),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.share_outlined,
                                            size: currH * 0.035,
                                          ),
                                          onPressed: () {
                                            // Add like button logic here
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: currW,
                                    margin: EdgeInsets.only(
                                        left: currW * .03, right: currW * .03),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]
                                              .get('Title'),
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        ReadMoreText(
                                          snapshot.data!.docs[index]
                                              .get('description'),
                                          trimLines: 2,
                                          textScaleFactor: 1,
                                          colorClickableText: Colors.red,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'Show more',
                                          trimExpandedText: 'Show less',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                          moreStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromARGB(
                                                  255, 123, 35, 35)),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Material(
                                            elevation:
                                                2.0, // Add elevation to the post image
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            clipBehavior: Clip.antiAlias,
                                            child: snapshot.data!.docs[index]
                                                        .get('imageUrl') !=
                                                    null
                                                ? Image.network(
                                                    snapshot.data!.docs[index]
                                                        .get('imageUrl')!,
                                                    // height: currH * 0.25,
                                                    fit: BoxFit.fill,
                                                  )
                                                : null)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: currW * .03,
                                        right: currW * .03,
                                        top: currH * .02),
                                    padding:
                                        EdgeInsets.only(bottom: currH * 0.014),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            setState(() {
                                              isLiked = !isLiked;
                                              print(isLiked);
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: _likes == 1
                                                    // ignore: prefer_const_constructors
                                                    ? Icon(
                                                        Icons.favorite,
                                                        size: 25,
                                                        color: Colors.red,
                                                      )
                                                    // ignore: prefer_const_constructors
                                                    : Icon(
                                                        Icons
                                                            .favorite_border_outlined,
                                                        size: 25,
                                                      ),
                                                onPressed: _toggleLike,
                                              ),
                                              const SizedBox(
                                                  width:
                                                      5), // add some space between the icon and text
                                              const Text(
                                                'Likes(22)',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 89, 89, 89),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Row(
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              const Icon(
                                                Icons.comment_outlined,
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                  width:
                                                      5), // add some space between the icon and text
                                              const Text(
                                                'Comments(22)',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 89, 89, 89),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );

    // return FutureBuilder(
    //   future: getData(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.hasData) {
    //         // allData = snapshot.data
    //         return ListView.builder(
    //             shrinkWrap: true,
    //             itemCount: allData.length,
    //             itemBuilder: (context, index) {
    //               return Container(
    //                 decoration: const BoxDecoration(color: Color(0xFFEFF3F5)),
    //                 padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
    //                 margin: const EdgeInsets.all(2.0),
    //                 child: Column(children: [
    //                   Text(allData[index].Title)
    //                   // Text("allData[index].title"),
    //                   // Text(allData[index].description),
    //                   // Text(allData[index].userid),
    //                 ]),
    //               );
    //             });
    //       } else {
    //         return Text("NO Data");
    //       }
    //     } else {
    //       // ignore: prefer_const_constructors
    //       return Center(
    //         child: const CircularProgressIndicator(),
    //       );
    //     }
    //   },
    // );
  }
}
