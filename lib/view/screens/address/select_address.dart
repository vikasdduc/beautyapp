// import 'package:flutter/material.dart';
// import 'package:glamcode/view/screens/address/edit_address.dart';
// import 'package:glamcode/view/screens/address/new_address.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

// import '../../../data/model/address_details_model.dart';

// import '../../../screen_size.dart';
// import '../../../util/dimensions.dart';

// class SelectAddressScreen extends StatefulWidget {
//   final bool edit;
//   final AddressDetails addressDetails;
//   const SelectAddressScreen(
//       {Key? key, required this.edit, required this.addressDetails})
//       : super(key: key);

//   @override
//   State<SelectAddressScreen> createState() => _SelectAddressScreenState();
// }

// class _SelectAddressScreenState extends State<SelectAddressScreen> {
//   //   with AutomaticKeepAliveClientMixin {
//   // TextEditingController nameController = TextEditingController();
//   // TextEditingController addressController = TextEditingController();
//   // TextEditingController locationAddressController = TextEditingController();
//   // TextEditingController mobileController = TextEditingController();
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   nameController.text = widget.addressDetails.addressHeading ?? "";
//   //   addressController.text = widget.addressDetails.address ?? "";
//   //   locationAddressController.text = widget.addressDetails.street ?? "";
//   //   mobileController.text = widget.addressDetails.mobileNumber ?? "";
//   // }

//   // final _editAddressFormKey = GlobalKey<FormState>();
//   // bool loading = false;

//   // @override
//   // bool get wantKeepAlive => true;

//   // bool isVisibleProductEnterpriseProgram = false;

//   // void visibleProductEnterpriseProgram() {
//   //   setState(() {
//   //     isVisibleProductEnterpriseProgram = !isVisibleProductEnterpriseProgram;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Stack( 
//       children: [
//         PlacePicker(
//           apiKey: r'AIzaSyAbpe1uQUBDEaQ8hyOEnEj4viZ0tbIud2I',
//           initialPosition: const LatLng(19.0759837, 72.8776559),
//           useCurrentLocation: true,
//           selectInitialPosition: true,
//           automaticallyImplyAppBarLeading: false,
//           enableMapTypeButton: false,
//           selectedPlaceWidgetBuilder:
//               (_, selectedPlace, state, isSearchBarFocused) {
//             return isSearchBarFocused
//                 ? Container()
//                 : FloatingCard(
//                     bottomPosition: 0.0,
//                     leftPosition: 0.0,
//                     rightPosition: 0.0,
//                     borderRadius: BorderRadius.circular(12.0),
//                     child: SizedBox(
//                       child: Center(
//                         child: state == SearchingState.Searching
//                             ? SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.3,
//                                 child: const Center(
//                                   child: CircularProgressIndicator(
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               )
//                             : Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Padding(
//                                     padding: EdgeInsets.all(
//                                         Dimensions.PADDING_SIZE_DEFAULT),
//                                     child: Text("SELECT ADDRESS"),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal:
//                                             Dimensions.PADDING_SIZE_DEFAULT),
//                                     child: selectedPlace?.addressComponents !=
//                                             null
//                                         ? Row(
//                                             children: [
//                                               const Icon(
//                                                   Icons.location_on_outlined),
//                                               Text(
//                                                 selectedPlace
//                                                         ?.addressComponents![1]
//                                                         .shortName ??
//                                                     "",
//                                                 style: TextStyle(
//                                                     fontSize: Dimensions
//                                                         .fontSizeOverLarge,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               )
//                                             ],
//                                           )
//                                         : Container(),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(
//                                         Dimensions.PADDING_SIZE_DEFAULT),
//                                     child: Text(
//                                       selectedPlace?.formattedAddress ?? "",
//                                       style: TextStyle(
//                                           fontSize: Dimensions.fontSizeLarge),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(
//                                         Dimensions.PADDING_SIZE_DEFAULT),
//                                     child: TextButton(
//                                       onPressed: () {
//                                         // visibleProductEnterpriseProgram();
//                                         widget.addressDetails.address =
//                                             selectedPlace?.addressComponents![1]
//                                                     .shortName ??
//                                                 "";
//                                         widget.addressDetails.street =
//                                             selectedPlace?.formattedAddress ??
//                                                 "";
//                                         widget.addressDetails.lattitude =
//                                             selectedPlace
//                                                     ?.geometry?.location.lat ??
//                                                 0;
//                                         widget.addressDetails.longitude =
//                                             selectedPlace
//                                                     ?.geometry?.location.lng ??
//                                                 0;
//                                         widget.edit
//                                             ? Navigator.of(context)
//                                                 .pushAndRemoveUntil(
//                                                     MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           EditAddressScreen(
//                                                         addressDetails: widget
//                                                             .addressDetails,
//                                                       ),
//                                                     ),
//                                                     ModalRoute.withName(
//                                                         '/address'))
//                                             : Navigator.of(context).push(
//                                                 MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       NewAddressScreen(
//                                                     address: selectedPlace
//                                                             ?.addressComponents![
//                                                                 1]
//                                                             .shortName ??
//                                                         "",
//                                                     locAddress: selectedPlace
//                                                             ?.formattedAddress ??
//                                                         "",
//                                                     latitude: selectedPlace
//                                                             ?.geometry
//                                                             ?.location
//                                                             .lat ??
//                                                         0,
//                                                     longitude: selectedPlace
//                                                             ?.geometry
//                                                             ?.location
//                                                             .lng ??
//                                                         0,
//                                                   ),
//                                                 ),
//                                               );
//                                       },
//                                       child: const Text("CONFIRM LOCATION"),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                       ),
//                     ),
//                   );
//           },
//           onAutoCompleteFailed: (error) {
//             print(error);
//           },
//         ),
//         // isVisibleProductEnterpriseProgram == true
//         //     ? Positioned(
//         //         top: 200,
//         //         // top: 80,
//         //         child: Visibility(
//         //           visible: isVisibleProductEnterpriseProgram,
//         //           child: Column(
//         //             children: <Widget>[
//         //               GestureDetector(
//         //                 onTap: () {
//         //                   visibleProductEnterpriseProgram();
//         //                 },
//         //                 child: Center(
//         //                   child: Container(
//         //                     decoration: const BoxDecoration(
//         //                         shape: BoxShape.circle,
//         //                         boxShadow: [
//         //                           BoxShadow(
//         //                             color: Colors.black,
//         //                             blurRadius: 1.0,
//         //                           ),
//         //                         ]),
//         //                     height: displayHeight(context) * 0.04,
//         //                     width: displayHeight(context) * 0.04,
//         //                     child: const Icon(
//         //                       Icons.clear,
//         //                       color: Colors.white,
//         //                     ),
//         //                   ),
//         //                 ),
//         //               ),
//         //               SizedBox(
//         //                 height: displayHeight(context) * 0.01,
//         //               ),
//         //               Container(
//         //                   decoration: const BoxDecoration(
//         //                       color: Colors.white,
//         //                       // border: Border.all(
//         //                       //     // color: Colors.black,
//         //                       //     ),
//         //                       borderRadius:
//         //                           BorderRadius.all(Radius.circular(20))),
//         //                   height: displayHeight(context) * 0.95,
//         //                   width: displayWidth(context),
//         //                   child: Column(
//         //                     children: <Widget>[
//         //                       Expanded(
//         //                         child: Padding(
//         //                           padding: EdgeInsets.all(
//         //                               displayHeight(context) * 0.0),
//         //                           child: CustomScrollView(
//         //                             slivers: <Widget>[
//         //                               SliverToBoxAdapter(
//         //                                 child: Row(
//         //                                   children: <Widget>[
//         //                                     Expanded(
//         //                                         flex: 9,
//         //                                         child: Column(
//         //                                           crossAxisAlignment:
//         //                                               CrossAxisAlignment.start,
//         //                                           children: const <Widget>[
//         //                                             // Text(
//         //                                             //   'hello',
//         //                                             //   style: TextStyle(
//         //                                             //       fontWeight:
//         //                                             //           FontWeight.bold),
//         //                                             // ),
//         //                                           ],
//         //                                         )),
//         //                                   ],
//         //                                 ),
//         //                               ),
//         //                               SliverToBoxAdapter(
//         //                                 child: SafeArea(
//         //                                   child: SizedBox(
//         //                                     width: displayWidth(context),
//         //                                     height:
//         //                                         displayHeight(context) * 0.9,
//         //                                     child: ListView(
//         //                                       children: [
//         //                                         Container(
//         //                                           height: 20,
//         //                                           color: Colors.amber,
//         //                                         ),
//         //                                         TextField(),
//         //                                       ],
//         //                                     ),
//                                             // "Name",
//                                             // nameController,
//                                             // TextInputType.text,
//                                             // null

//                                             // child: ListView.builder(
//                                             //   scrollDirection: Axis.vertical,
//                                             //   itemCount: 20,
//                                             //   itemBuilder: (context, indexNews) {
//                                             //     return GestureDetector(
//                                             //       onTap: () {},
//                                             //       child: SizedBox(
//                                             //         width: displayWidth(context) *
//                                             //             0.4,
//                                             //         child: Card(
//                                             //           shape:
//                                             //               const RoundedRectangleBorder(
//                                             //                   side: BorderSide(
//                                             //                     color: Color
//                                             //                         .fromARGB(
//                                             //                             221,
//                                             //                             221,
//                                             //                             221,
//                                             //                             221),
//                                             //                     width: 1.0,
//                                             //                   ),
//                                             //                   borderRadius: BorderRadius.only(
//                                             //                       topLeft: Radius
//                                             //                           .circular(
//                                             //                               10),
//                                             //                       bottomLeft: Radius
//                                             //                           .circular(
//                                             //                               10),
//                                             //                       topRight: Radius
//                                             //                           .circular(
//                                             //                               10),
//                                             //                       bottomRight: Radius
//                                             //                           .circular(
//                                             //                               10))),
//                                             //           child: Row(
//                                             //             children: [
//                                             //               Stack(
//                                             //                 children: [
//                                             //                   Icon(Icons.abc),
//                                             //                   const Padding(
//                                             //                     padding:
//                                             //                         EdgeInsets
//                                             //                             .all(
//                                             //                                 10.0),
//                                             //                     child: Text(
//                                             //                       "5",
//                                             //                       style: TextStyle(
//                                             //                           fontWeight:
//                                             //                               FontWeight
//                                             //                                   .bold,
//                                             //                           color: Colors
//                                             //                               .white,
//                                             //                           fontSize:
//                                             //                               25),
//                                             //                     ),
//                                             //                   )
//                                             //                 ],
//                                             //               ),
//                                             //               const Text(
//                                             //                   "Edp tranning cirtificate")
//                                             //             ],
//                                             //           ),
//                                             //         ),
//                                             //       ),
//                                             //     );
//                                             //   },
//                                             // ),
//             //                               ),
//             //                             ),
//             //                           ),
//             //                           // SliverToBoxAdapter(
//             //                           //   child: SizedBox(
//             //                           //     height:
//             //                           //         displayHeight(context) * 0.8,
//             //                           //     child: Text("data"),
//             //                           //   ),
//             //                           // )
//             //                         ],
//             //                       ),
//             //                     ),
//             //                   )
//             //                 ],
//             //               )),
//             //         ],
//             //       ),
//             //     ),
//             //   )
//             // : Container(),
//       ],
//     );
//   }
// }
