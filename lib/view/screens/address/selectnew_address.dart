// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:glamcode/data/model/address_details_model.dart';
// import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

// import 'edit_address.dart';
// import 'new_address.dart';

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
//   LatLong currentLocation = const LatLong(0, 0);
//   @override
//   void initState() {
//     super.initState();
//     fetchLocation();
//   }

//   void fetchLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     Position? p;
//     try {
//       p = await Geolocator.getCurrentPosition();
//     } catch (e) {
//       p = await Geolocator.getLastKnownPosition();
//     }

//     if (p == null) return;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setState(() {
//         currentLocation = LatLong(p!.latitude, p.longitude);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Map Screen"),
//       ),
//       body: OpenStreetMapSearchAndPick(
//         center: currentLocation,
//         locationPinIconColor: const Color(0xFFA854FC),
//         buttonColor: const Color(0xFFA854FC),
//         onPicked: (pickedData) {
//           setState(() {
//             widget.addressDetails.address = pickedData.addressName;
//             widget.addressDetails.lattitude = pickedData.latLong.latitude;
//             widget.addressDetails.longitude = pickedData.latLong.longitude;
//           });
//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(
//                 builder: (context) => EditAddressScreen(
//                   addressDetails: widget.addressDetails,
//                 ),
//               ),
//           ModalRoute.withName('/address'));
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => NewAddressScreen(
//                 address: pickedData.addressName,
//                 locAddress: pickedData.addressName,
//                 latitude: pickedData.latLong.latitude,
//                 longitude: pickedData.latLong.latitude,
//               ),
//             ),
//           );

//           print(widget.addressDetails.address);
//         },
//       ),
//     );
//   }
// }
