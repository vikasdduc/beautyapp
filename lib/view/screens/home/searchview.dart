// import 'package:flutter/material.dart';
// import 'package:glamcode/data/model/packages_model/service.dart';
// import 'package:glamcode/util/convertHtmlToString.dart';
// import 'package:glamcode/view/base/bottomServiceBar.dart';
// import 'package:glamcode/view/base/cart_counter.dart';
// import 'package:glamcode/view/base/custom_divider.dart';
// import 'package:glamcode/view/base/golden_text.dart';
// import 'package:glamcode/view/screens/home/searchmodel.dart';

// import '../../../util/dimensions.dart';

// class SearchView extends StatefulWidget {
//   final Services searchModel;
//   const SearchView({Key? key, required this.searchModel}) : super(key: key);

//   @override
//   State<SearchView> createState() => _SearchViewState();
// }

// class _SearchViewState extends State<SearchView> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             // Hero(
//             //   tag: searchModel.slug ?? "",
//             // child:
//             Image.network(
//               widget.searchModel.serviceImageUrl.toString(),
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             // ),
//             Padding(
//               padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.searchModel.name.toString(),
//                         style: TextStyle(
//                             fontSize: Dimensions.fontSizeExtraLarge,
//                             fontWeight: FontWeight.w500),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(
//                             Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                         child: RichText(
//                           text: TextSpan(
//                             text: "₹${widget.searchModel.price.toString()}   ",
//                             style: TextStyle(
//                                 fontSize: Dimensions.fontSizeDefault,
//                                 color: Colors.black),
//                             children: [
//                               WidgetSpan(
//                                 child: Transform.translate(
//                                   offset: const Offset(0.0, -4.0),
//                                   child: Text(
//                                     "₹${widget.searchModel.discountedPrice.toString()}",
//                                     style: TextStyle(
//                                       fontSize: Dimensions.fontSizeSmall,
//                                       color: Colors.grey,
//                                       decoration: TextDecoration.lineThrough,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               WidgetSpan(
//                                 alignment: PlaceholderAlignment.bottom,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal:
//                                           Dimensions.PADDING_SIZE_DEFAULT),
//                                   child: GoldenText(
//                                     text:
//                                         "  ${widget.searchModel.discount.toString()}% Off  ",
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(
//                             Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.access_time_rounded,
//                               size: Dimensions.fontSizeDefault,
//                             ),
//                             Text(
//                               "${widget.searchModel.time.toString()} Minutes",
//                               style: TextStyle(
//                                   fontSize: Dimensions.fontSizeDefault),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const CartCounter(
//                     servicePackage: ServicePackage(),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: Dimensions.PADDING_SIZE_DEFAULT,
//                   right: Dimensions.PADDING_SIZE_DEFAULT,
//                   bottom: Dimensions.PADDING_SIZE_DEFAULT),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: convertHtmlToString(
//                           widget.searchModel.description.toString())
//                       .map(
//                         (e) => Padding(
//                           padding: const EdgeInsets.all(
//                               Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
//                           child: Text("\u2022 $e"),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//             ),
//             const CustomDivider(),
//             Padding(
//               padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(
//                           Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                       child: Text(
//                         "Benefits",
//                         style: TextStyle(
//                             fontSize: Dimensions.fontSizeExtraLarge,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Wrap(
//                       children: convertHtmlToString(
//                               widget.searchModel.longDescription.toString())
//                           .map(
//                             (e) => Padding(
//                               padding: const EdgeInsets.all(
//                                   Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
//                               child: Text("\u2022 $e"),
//                             ),
//                           )
//                           .toList(),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//       bottomNavigationBar: const BottomServiceBar(),
//     ));
//   }
// }
