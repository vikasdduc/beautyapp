// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:rstore/controller/api_url.dart';
// import 'package:rstore/controller/share_helper.dart';
// import 'package:rstore/model/card_pro_model.dart';
// import 'package:rstore/model/pro_model.dart';
// import 'package:rstore/view/admin/dashboard.dart';
// import 'package:rstore/view/product_details.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:rstore/widget/internet.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key key}) : super(key: key);

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final searchController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     CheckInternet.internet(context);
//     getProduct();
//     getCartItem();
//   }

//   String countItem;
//   CartListModel cartListModel;
//   getCartItem() async {
//     var url = URLapi.cartUrl + SharedHelper.userTid;
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       var resp = CartListModel.fromJson(jsonDecode(response.body));
//       setState(() {
//         cartListModel = resp;
//         countItem = cartListModel.cartList.length.toString();
//         if (kDebugMode) {
//           print('count Item');
//           print(countItem);
//         }
//       });
//       return cartListModel;
//     } else {
//       throw Exception('Failed to load product');
//     }
//   }

//   ProductModel proModel;
//   List<Product> tempList = [];
//   // Product searchPro;
//   getProduct() async {
//     final response = await http.get(Uri.parse(URLapi.productUrl));

//     if (response.statusCode == 200) {
//       var resp = ProductModel.fromJson(jsonDecode(response.body));
//       setState(() {
//         proModel = resp;
//         for (int i = 0; i < proModel.product.length; i++) {
//           tempList.add(proModel.product[i]);
//         }
//       });
//       return proModel;
//     } else {
//       throw Exception('Failed to load product');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       // bottomNavigationBar: const BottomNavigationBarScreen(),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(color: Color.fromARGB(255, 77, 74, 74)),
//         centerTitle: false,
//         title: const Text(
//           "Search Product",
//           style: TextStyle(color: Color.fromARGB(255, 77, 74, 74)),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.home,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const DashboardScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: SizedBox(
//         height: double.infinity,
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//               child: Container(
//                 color: Colors.white,
//                 child: TextField(
//                   // controller: searchController,
//                   onChanged: searchProducts,
//                   controller: searchController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.search),
//                     hintText: "Search Products Name",
//                     labelText: "Search Products Name",
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ),
//             proModel == null
//                 ? const Center(child: CircularProgressIndicator())
//                 : Flexible(
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(left: 10, right: 10, top: 10),
//                       child: ListView.builder(
//                           itemCount: proModel.product.length,
//                           itemBuilder: (context, index) {
//                             return GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => ProductDetails(
//                                             proCompany: proModel
//                                                 .product[index].proCompanyName
//                                                 .toString(),
//                                             stock: proModel
//                                                 .product[index].proStock
//                                                 .toString(),
//                                             itemCartCount: int.parse(countItem),
//                                             proId: proModel.product[index].proId
//                                                 .toString(),
//                                             proName:
//                                                 proModel.product[index].proName,
//                                             proImage: URLapi.imageURL +
//                                                 proModel
//                                                     .product[index].proImage,
//                                             proDescription: proModel
//                                                 .product[index].proDescription,
//                                             proPrice: proModel
//                                                 .product[index].proPrice
//                                                 .toString(),
//                                             proSellingprice: proModel
//                                                 .product[index].proSellingprice
//                                                 .toString(),
//                                             proDiscount: proModel
//                                                 .product[index].proDiscount
//                                                 .toString(),
//                                             proQuantity: proModel
//                                                 .product[index].proQuantity
//                                                 .toString(),
//                                             cateId: proModel
//                                                 .product[index].cateId
//                                                 .toString(),
//                                             cateName: proModel
//                                                 .product[index].cateName,
//                                           )),
//                                 );
//                               },
//                               child: Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 5, horizontal: 10),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Expanded(
//                                         flex: 3,
//                                         child: Image.network(
//                                           URLapi.imageURL +
//                                               proModel.product[index].proImage,
//                                           // "https://sc04.alicdn.com/kf/UTB8rsYviyaMiuJk43PT761SmXXa2.png",
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),

//                                       Expanded(
//                                           flex: 6,
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 5),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   proModel
//                                                       .product[index].proName,
//                                                   style: const TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                     proModel.product[index]
//                                                         .proDescription,
//                                                     maxLines: 3),
//                                                 const SizedBox(
//                                                   height: 5,
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Text(
//                                                       proModel.product[index]
//                                                               .proQuantity
//                                                               .toString() +
//                                                           ' पैकेट ',
//                                                       style: const TextStyle(
//                                                           fontSize: 13),
//                                                     ),
//                                                     Text(
//                                                       '₹' +
//                                                           proModel
//                                                               .product[index]
//                                                               .proSellingprice
//                                                               .toString() +
//                                                           '  ',
//                                                       style: const TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Text(
//                                                   proModel.product[index]
//                                                       .proCompanyName
//                                                       .toString(),
//                                                   textAlign: TextAlign.center,
//                                                   maxLines: 1,
//                                                   style: const TextStyle(
//                                                       color: Colors.green),
//                                                 ),
//                                                 proModel.product[index]
//                                                             .proStock ==
//                                                         0
//                                                     ? Align(
//                                                         alignment: Alignment
//                                                             .centerRight,
//                                                         child: Card(
//                                                             color: Colors
//                                                                 .redAccent[700],
//                                                             child:
//                                                                 const Padding(
//                                                               padding: EdgeInsets
//                                                                   .symmetric(
//                                                                       horizontal:
//                                                                           10,
//                                                                       vertical:
//                                                                           5),
//                                                               child: Text(
//                                                                 'Out of Stock',
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold),
//                                                               ),
//                                                             )),
//                                                       )
//                                                     : Align(
//                                                         alignment: Alignment
//                                                             .centerRight,
//                                                         child: Card(
//                                                             color: Colors
//                                                                     .greenAccent[
//                                                                 700],
//                                                             child: Padding(
//                                                               padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       10,
//                                                                   vertical: 5),
//                                                               child: Text(
//                                                                   proModel
//                                                                           .product[
//                                                                               index]
//                                                                           .proStock
//                                                                           .toString() +
//                                                                       ' आइटम स्टॉक',
//                                                                   style: const TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold)),
//                                                             )),
//                                                       )
//                                               ],
//                                             ),
//                                           )),
//                                       Expanded(
//                                           flex: 1,
//                                           child: GestureDetector(
//                                               onTap: () {
//                                                 // removeItemCard(cartListModel
//                                                 //     .cartList[index].cartId);
//                                               },
//                                               child: IconButton(
//                                                   icon: const FaIcon(
//                                                     FontAwesomeIcons
//                                                         .greaterThan,
//                                                     size: 20,
//                                                   ),
//                                                   onPressed: () {
//                                                     if (kDebugMode) {
//                                                       print("Pressed");
//                                                     }
//                                                   })
//                                               // Icon(
//                                               //   Icons.directions_run,
//                                               //   size: 40,
//                                               //   color: Colors.greenAccent[700],
//                                               // ),
//                                               )),
//                                       // Column(
//                                       //   children: [
//                                       //     SizedBox(
//                                       //       height: 120,
//                                       //       // width: 150,
//                                       //       child: Image.network(
//                                       //         URLapi.imageURL +
//                                       //             proModel
//                                       //                 .product[index].proImage,
//                                       //         // "https://sc04.alicdn.com/kf/UTB8rsYviyaMiuJk43PT761SmXXa2.png",
//                                       //         fit: BoxFit.fill,
//                                       //       ),
//                                       //     ),
//                                       //   ],
//                                       // ),
//                                       // Column(
//                                       //   crossAxisAlignment:
//                                       //       CrossAxisAlignment.start,
//                                       //   children: [
//                                       //     SizedBox(
//                                       //       width: 200,
//                                       //       child: Text(
//                                       //         proModel.product[index].proName,
//                                       //         style: const TextStyle(
//                                       //           fontWeight: FontWeight.bold,
//                                       //         ),
//                                       //       ),
//                                       //     ),
//                                       //     Row(
//                                       //       mainAxisAlignment:
//                                       //           MainAxisAlignment.spaceAround,
//                                       //       children: [
//                                       //         Row(
//                                       //           children: [
//                                       //             Text(
//                                       //               '₹ ' +
//                                       //                   // cartListModel
//                                       //                   //     .cartList[index]
//                                       //                   //     .proSellingprice
//                                       //                   'toString()' +
//                                       //                   '   ',
//                                       //               style: const TextStyle(
//                                       //                   fontWeight:
//                                       //                       FontWeight.bold),
//                                       //             ),
//                                       //             const SizedBox(
//                                       //               width: 20,
//                                       //             ),
//                                       //             Card(
//                                       //                 child: Padding(
//                                       //               padding: const EdgeInsets
//                                       //                       .symmetric(
//                                       //                   vertical: 5,
//                                       //                   horizontal: 10),
//                                       //               child: Text(
//                                       //                   'proQuantity' + ' पैकेट',
//                                       //                   style: const TextStyle(
//                                       //                     fontWeight:
//                                       //                         FontWeight.bold,
//                                       //                   )),
//                                       //             )),
//                                       //           ],
//                                       //         ),
//                                       //       ],
//                                       //     ),
//                                       //   ],
//                                       // ),
//                                       // GestureDetector(
//                                       //   onTap: () {
//                                       //     // removeItemCard(cartListModel
//                                       //     //     .cartList[index].cartId);
//                                       //   },
//                                       //   child: Icon(
//                                       //     Icons.add,
//                                       //     size: 40,
//                                       //     color: Colors.greenAccent[700],
//                                       //   ),
//                                       // )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   void searchProducts(String query) {
//     if (searchController.text == "") {
//       getProduct();
//       getCartItem();
//     } else {
//       final suggestions = proModel.product.where((element) {
//         final productTitle = element.proName.toLowerCase();
//         final input = query.toLowerCase();
//         return productTitle.contains(input);
//       }).toList();
//       setState(() {
//         proModel.product = suggestions;
//       });
//     }
//   }
// }
