import 'dart:convert';
import 'package:glamcode/screen_size.dart';
import 'package:glamcode/view/base/loading_screen.dart';
import 'package:glamcode/view/screens/home/searchmodel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../data/model/auth.dart';
import '../../../util/convertHtmlToString.dart';
import '../../../util/dimensions.dart';
import '../../base/golden_text.dart';
import '../packages/packages_screen.dart';

class SearchScreen extends StatefulWidget {
  // final SearchModel searchModel;
  // final String? title;
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // CheckInternet.internet(context);
    getProduct();
    // getCartItem();
  }

  SearchModel? searchModel;
  List<Services> tempList = [];

  getProduct() async {
    final response = await http.get(Uri.parse(
        "https://admin.glamcode.in/api/search/${Auth.instance.prefs.getInt("selectedLocationId")}"));

    if (response.statusCode == 200) {
      var resp = SearchModel.fromJson(jsonDecode(response.body));
      setState(() {
        searchModel = resp;
        if (searchModel != null) {
          tempList = searchModel!.services ?? [];
        }
        // for (int i = 0; i < tempList.length; i++,) {
        //   tempList.add(tempList[i]);
        // }
      });
      return searchModel;
    } else {
      throw Exception('Failed to load product');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('temp --> ${tempList.length}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search Service"),
        ),
        body: searchModel == null
            ? const Center(child: LoadingScreen())
            : ListView(
                children: [
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all()),
                      child: TextField(
                        // controller: searchController,
                        onChanged: searchProducts,
                        controller: searchController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search service ",
                          // labelText: "Search ",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: displayHeight(context) * 0.85,
                    child: ListView.builder(
                      itemCount: tempList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // print("main${tempList[index].mainCategoryId}");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PackagesScreen(
                                          mainCategoryId:
                                              tempList[index].mainCategoryId!,
                                          mainCategoryName:
                                              tempList[index].category!.name!,
                                        )));
                            //     ModalRoute.withName('/index'));
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => M()));
                            // ModalRoute.withName('/index'));
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //        ('/index')
                            //             )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_SMALL),
                            child: Card(
                              elevation: 0,
                              borderOnForeground: true,
                              margin: const EdgeInsets.all(0),
                              shape: const RoundedRectangleBorder(),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              Dimensions.PADDING_SIZE_DEFAULT,
                                              Dimensions.PADDING_SIZE_DEFAULT,
                                              0,
                                              Dimensions.PADDING_SIZE_DEFAULT),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    Dimensions
                                                        .PADDING_SIZE_EXTRA_SMALL),
                                                child: Text(
                                                  tempList[index]
                                                      .name
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: Dimensions
                                                          .fontSizeLarge,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow:
                                                          TextOverflow.fade),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "₹${tempList[index].discountedPrice}",
                                                      // "₹${servicePackage.discountedPrice}   ",
                                                      style: TextStyle(
                                                          fontSize: Dimensions
                                                              .fontSizeDefault,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          overflow: TextOverflow
                                                              .fade),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "₹${tempList[index].price}",

                                                          // "₹${servicePackage.price}",
                                                          style: TextStyle(
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                                  .only(
                                                              left: Dimensions
                                                                  .PADDING_SIZE_SMALL),
                                                          child: GoldenText(
                                                            text:
                                                                "${tempList[index].discount}%off",
                                                            // "  ${servicePackage.discount}% Off  ",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Text(),
                                              // Padding(
                                              //   padding: const EdgeInsets.all(
                                              //       Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                              //   child: Row(
                                              //     children: [
                                              //       // RichText(
                                              //       //   text: TextSpan(
                                              //       //     text:
                                              //       //     //     "₹${servicePackage.discountedPrice}   ",
                                              //       //     // style: TextStyle(
                                              //       //     //     fontSize: Dimensions.fontSizeDefault,
                                              //       //     //     color: Colors.black,
                                              //       //     //     fontWeight: FontWeight.bold,
                                              //       //     //     overflow: TextOverflow.fade),
                                              //       //     // children: [
                                              //       //     //   TextSpan(
                                              //       //     //     text: "₹${servicePackage.price}",
                                              //       //     //     style: TextStyle(
                                              //       //     //         fontSize: Dimensions.fontSizeSmall,
                                              //       //     //         color: Colors.grey,
                                              //       //     //         decoration:
                                              //       //     //             TextDecoration.lineThrough,
                                              //       //     //         overflow: TextOverflow.fade),
                                              //       //     //   ),
                                              //       //     // ],
                                              //       //   ),
                                              //       // ),

                                              //       // Padding(
                                              //       //   padding: const EdgeInsets.only(
                                              //       //       left: Dimensions.PADDING_SIZE_SMALL),
                                              //       //   child: GoldenText(
                                              //       //     text: "  ${servicePackage.discount}% Off  ",
                                              //       //   ),
                                              //       // ),
                                              //     ],
                                              //   ),

                                              // ),

                                              const SizedBox(
                                                height: 5,
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    Dimensions
                                                        .PADDING_SIZE_EXTRA_SMALL),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.access_time_rounded,
                                                      color: Colors.grey,
                                                      size: Dimensions
                                                          .fontSizeSmall,
                                                    ),
                                                    RichText(
                                                        text: TextSpan(
                                                      text:
                                                          "${tempList[index].time} Minutes",
                                                      // text: " ${servicePackage.time} Minutes",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: Dimensions
                                                              .fontSizeSmall,
                                                          overflow: TextOverflow
                                                              .fade),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "Services :-",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Dimensions
                                                        .fontSizeLarge,
                                                    overflow:
                                                        TextOverflow.fade),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  Dimensions
                                                      .PADDING_SIZE_SMALL),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                clipBehavior: Clip.hardEdge,
                                                child: Image.network(
                                                    tempList[index]
                                                        .serviceImageUrl
                                                        .toString()),
                                              ),
                                            ),
                                            // ignore: prefer_const_constructors
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(top: 1),
                                            //   child: const CartCounter(
                                            //     servicePackage: ServicePackage(),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: convertHtmlToString(
                                                tempList[index]
                                                    .description
                                                    .toString())
                                            .map(
                                              (e) => Padding(
                                                padding: const EdgeInsets.all(
                                                  Dimensions
                                                      .PADDING_SIZE_EXTRA_EXTRA_SMALL,
                                                ),
                                                child: Text(
                                                  "\u2022 $e",
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Align(
                                  //     alignment: Alignment.topLeft,
                                  //     child: OutlinedButton(
                                  //       style: ButtonStyle(
                                  //           splashFactory:
                                  //               InkRipple.splashFactory,
                                  //           backgroundColor:
                                  //               MaterialStateProperty.all(
                                  //             const Color(0xFF882EDF),
                                  //           )),
                                  //       onPressed: () {
                                  //         Navigator.of(context).push(
                                  //             MaterialPageRoute(
                                  //                 builder:
                                  //                     (context) => PackageInfo(
                                  //                           servicePackage: ServicePackage(
                                  //                               categoryId:
                                  //                                   searchModel!
                                  //                                       .services![
                                  //                                           index]
                                  //                                       .name!
                                  //                                       .length),
                                  //                         )));
                                  //       },
                                  //       child: Text(
                                  //         "View Details",
                                  //         style: TextStyle(
                                  //             color: Colors.white,
                                  //             fontSize:
                                  //                 Dimensions.fontSizeLarge),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: Dimensions.PADDING_SIZE_SMALL),
                  //     child: Card(
                  //       elevation: 0,
                  //       borderOnForeground: true,
                  //       margin: const EdgeInsets.all(0),
                  //       shape: const RoundedRectangleBorder(),
                  //       child: Column(
                  //         children: [
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Expanded(
                  //                 flex: 4,
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.fromLTRB(
                  //                       Dimensions.PADDING_SIZE_DEFAULT,
                  //                       Dimensions.PADDING_SIZE_DEFAULT,
                  //                       0,
                  //                       Dimensions.PADDING_SIZE_DEFAULT),
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     mainAxisAlignment: MainAxisAlignment.end,
                  //                     mainAxisSize: MainAxisSize.max,
                  //                     children: [
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(
                  //                             Dimensions
                  //                                 .PADDING_SIZE_EXTRA_SMALL),
                  //                         child: Text(
                  //                           tempList.first.name
                  //                               .toString(),
                  //                           style: TextStyle(
                  //                               fontSize:
                  //                                   Dimensions.fontSizeLarge,
                  //                               fontWeight: FontWeight.bold,
                  //                               overflow: TextOverflow.fade),
                  //                         ),
                  //                       ),
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: Column(
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.start,
                  //                           children: [
                  //                             Text(
                  //                               "demo",
                  //                               // "₹${servicePackage.discountedPrice}   ",
                  //                               style: TextStyle(
                  //                                   fontSize: Dimensions
                  //                                       .fontSizeDefault,
                  //                                   color: Colors.black,
                  //                                   fontWeight: FontWeight.bold,
                  //                                   overflow:
                  //                                       TextOverflow.fade),
                  //                             ),
                  //                             const SizedBox(
                  //                               height: 5,
                  //                             ),
                  //                             Row(
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.start,
                  //                               children: [
                  //                                 Text(
                  //                                   "data",
                  //                                   // "₹${servicePackage.price}",
                  //                                   style: TextStyle(
                  //                                       fontSize: Dimensions
                  //                                           .fontSizeSmall,
                  //                                       color: Colors.grey,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                       decoration:
                  //                                           TextDecoration
                  //                                               .lineThrough,
                  //                                       overflow:
                  //                                           TextOverflow.fade),
                  //                                 ),
                  //                                 Padding(
                  //                                   padding: const EdgeInsets
                  //                                           .only(
                  //                                       left: Dimensions
                  //                                           .PADDING_SIZE_SMALL),
                  //                                   child: GoldenText(
                  //                                       text: "hello"
                  //                                       // "  ${servicePackage.discount}% Off  ",
                  //                                       ),
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       // Text(),
                  //                       // Padding(
                  //                       //   padding: const EdgeInsets.all(
                  //                       //       Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //                       //   child: Row(
                  //                       //     children: [
                  //                       //       // RichText(
                  //                       //       //   text: TextSpan(
                  //                       //       //     text:
                  //                       //       //     //     "₹${servicePackage.discountedPrice}   ",
                  //                       //       //     // style: TextStyle(
                  //                       //       //     //     fontSize: Dimensions.fontSizeDefault,
                  //                       //       //     //     color: Colors.black,
                  //                       //       //     //     fontWeight: FontWeight.bold,
                  //                       //       //     //     overflow: TextOverflow.fade),
                  //                       //       //     // children: [
                  //                       //       //     //   TextSpan(
                  //                       //       //     //     text: "₹${servicePackage.price}",
                  //                       //       //     //     style: TextStyle(
                  //                       //       //     //         fontSize: Dimensions.fontSizeSmall,
                  //                       //       //     //         color: Colors.grey,
                  //                       //       //     //         decoration:
                  //                       //       //     //             TextDecoration.lineThrough,
                  //                       //       //     //         overflow: TextOverflow.fade),
                  //                       //       //     //   ),
                  //                       //       //     // ],
                  //                       //       //   ),
                  //                       //       // ),

                  //                       //       // Padding(
                  //                       //       //   padding: const EdgeInsets.only(
                  //                       //       //       left: Dimensions.PADDING_SIZE_SMALL),
                  //                       //       //   child: GoldenText(
                  //                       //       //     text: "  ${servicePackage.discount}% Off  ",
                  //                       //       //   ),
                  //                       //       // ),
                  //                       //     ],
                  //                       //   ),

                  //                       // ),

                  //                       SizedBox(
                  //                         height: 5,
                  //                       ),

                  //                       Padding(
                  //                         padding: const EdgeInsets.all(
                  //                             Dimensions
                  //                                 .PADDING_SIZE_EXTRA_SMALL),
                  //                         child: Row(
                  //                           children: [
                  //                             Icon(
                  //                               Icons.access_time_rounded,
                  //                               color: Colors.grey,
                  //                               size: Dimensions.fontSizeSmall,
                  //                             ),
                  //                             RichText(
                  //                                 text: TextSpan(
                  //                               text: "fghj",
                  //                               // text: " ${servicePackage.time} Minutes",
                  //                               style: TextStyle(
                  //                                   color: Colors.grey,
                  //                                   fontSize: Dimensions
                  //                                       .fontSizeSmall,
                  //                                   overflow:
                  //                                       TextOverflow.fade),
                  //                             ))
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       Text(
                  //                         "Services :-",
                  //                         style: TextStyle(
                  //                             color: Colors.black,
                  //                             fontWeight: FontWeight.bold,
                  //                             fontSize:
                  //                                 Dimensions.fontSizeLarge,
                  //                             overflow: TextOverflow.fade),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               Expanded(
                  //                 flex: 3,
                  //                 child: Stack(
                  //                   alignment: Alignment.bottomCenter,
                  //                   children: [
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(
                  //                           Dimensions.PADDING_SIZE_SMALL),
                  //                       child: ClipRRect(
                  //                         borderRadius:
                  //                             BorderRadius.circular(15),
                  //                         clipBehavior: Clip.hardEdge,
                  //                         // child: Hero(
                  //                         //   // tag: servicePackage.slug ?? "",
                  //                         //   child: Image.network(
                  //                         //       servicePackage.serviceImageUrl ?? ""),
                  //                         // ),
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.only(top: 1),
                  //                       // child: CartCounter(
                  //                       //   servicePackage: servicePackage,
                  //                       // ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.only(
                  //                 left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //             child: SizedBox(
                  //               width: double.infinity,
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: convertHtmlToString(
                  //                         "<p><span style=\"font-size: 14px;\">&nbsp;Premium HD Make Up.</span></p><p><span style=\"font-size: 14px;\">&nbsp;Advance Hair Do.</span></p><p><span style=\"font-size: 14px;\">&nbsp;Dress/Saree Draping.</span></p><p><span style=\"font-size: 14px;\">&nbsp;Professional Makeup Artist</span><br></p>")
                  //                     .map(
                  //                       (e) => Padding(
                  //                         padding: const EdgeInsets.all(
                  //                           Dimensions
                  //                               .PADDING_SIZE_EXTRA_EXTRA_SMALL,
                  //                         ),
                  //                         child: Text(
                  //                           "\u2022 $e",
                  //                         ),
                  //                       ),
                  //                     )
                  //                     .toList(),
                  //               ),
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Align(
                  //               alignment: Alignment.topLeft,
                  //               child: OutlinedButton(
                  //                 style: ButtonStyle(
                  //                     splashFactory: InkRipple.splashFactory,
                  //                     backgroundColor:
                  //                         MaterialStateProperty.all(
                  //                       const Color(0xFF882EDF),
                  //                     )),
                  //                 onPressed: () {
                  //                   // Navigator.of(context).push(MaterialPageRoute(
                  //                   //     builder: (context) => PackageInfo(
                  //                   //           servicePackage: servicePackage,
                  //                   //         )));
                  //                 },
                  //                 child: Text(
                  //                   "View Details",
                  //                   style: TextStyle(
                  //                       color: Colors.white,
                  //                       fontSize: Dimensions.fontSizeLarge),
                  //                 ),
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
      ),
    );

    // Scaffold(
    //   resizeToAvoidBottomInset: false,
    //   backgroundColor: Colors.white,
    //   // bottomNavigationBar: const BottomNavigationBarScreen(),
    //   // appBar: AppBar(
    //   //   backgroundColor: Colors.white,
    //   //   iconTheme: const IconThemeData(color: Color.fromARGB(255, 77, 74, 74)),
    //   //   centerTitle: false,
    //   //   title: const Text(
    //   //     "Search Product",
    //   //     style: TextStyle(color: Color.fromARGB(255, 77, 74, 74)),
    //   //   ),
    //   // ),

    //   body: SafeArea(
    //     child: SizedBox(
    //       height: double.infinity,
    //       child: Column(
    //         children: <Widget>[
    //           Padding(
    //             padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
    //   child: Container(
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(5),
    //         border: Border.all()),
    //     child: TextField(
    //       // controller: searchController,
    //       onChanged: searchProducts,
    //       controller: searchController,
    //       decoration: InputDecoration(
    //         prefixIcon: const Icon(Icons.search),
    //         hintText: "Search service ",
    //         // labelText: "Search ",
    //         border: InputBorder.none,
    //       ),
    //     ),
    //   ),
    // ),
    //           searchModel == null
    //               ? const Center(child: CircularProgressIndicator())
    //               : Flexible(
    //                   child: Padding(
    //                     padding:
    //                         const EdgeInsets.only(left: 10, right: 10, top: 10),
    //                     child: ListView.builder(
    //                         itemCount: tempList.length,
    //                         itemBuilder: (context, index) {
    //                           return GestureDetector(
    //                             // onTap: () {
    //                             //     Navigator.push(
    //                             //       context,
    //                             //       MaterialPageRoute(
    //                             //           builder: (context) =>

    //                             //   )
    //                             // },
    //                             child: Card(
    //                               child: Padding(
    //                                 padding: const EdgeInsets.symmetric(
    //                                     vertical: 5, horizontal: 10),
    //                                 child: Row(
    //                                   // mainAxisAlignment:
    //                                   //     MainAxisAlignment.spaceAround,
    //                                   children: [
    //                                     Expanded(
    //                                       child: SizedBox(
    //                                         height:
    //                                             displayHeight(context) * 0.1,
    //                                         child: ClipRRect(
    //                                           borderRadius:
    //                                               BorderRadius.circular(10),
    //                                           child: Image(
    //                                               image: NetworkImage(
    //                                                   searchModel!
    //                                                       .services![index]
    //                                                       .image
    //                                                       .toString())),
    //                                         ),
    //                                       ),
    //                                     ),

    //                                     Expanded(
    //                                       child: Column(
    //                                         children: [
    //                                           Text(
    //                                             searchModel!
    //                                                 .services![index].name
    //                                                 .toString(),
    //                                             style: TextStyle(
    //                                                 fontWeight:
    //                                                     FontWeight.bold),
    //                                           ),
    //                                           Text(searchModel!
    //                                               .services![index].describtion
    //                                               .toString()),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                     // Text(searchModel!
    //                                     //     .services![index].describtion
    //                                     //     .toString()),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                           );
    //                         }),
    //                   ),
    //                 ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  void searchProducts(String query) {
    print('search controller ---> ${searchController.text}');
    print('query---> $query');
    setState(() {
      if (searchController.text == "") {
        tempList = searchModel?.services ?? [];
        // getProduct();
        // getCartItem();
      } else {
        final suggestions = tempList.where((element) {
          final productTitle = element.name!.toLowerCase();
          final input = query.toLowerCase();
          return productTitle.contains(input);
        }).toList();
        tempList = suggestions;
      }
    });
  }
}
