import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/address_details_model.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/screens/address/new_address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location_geocoder/location_geocoder.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../../util/dimensions.dart';
import '../../../base/custom_divider.dart';
import '../../../base/loading_screen.dart';
import '../../address/address_screen.dart';
import '../../address/getuserlocationmapscreen.dart';

class SearchLocationScreen extends StatefulWidget {
  final bool edit;
  final AddressDetails addressDetails;
  const SearchLocationScreen(
      {super.key, required this.edit, required this.addressDetails});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  TextEditingController _addressController = TextEditingController();
  static String? finaladdress;
  late SharedPreferences prefs;
  bool showSpinner = false;
  String apiKey = "AIzaSyAwhkMkZRsfmIezAuQOePphi9Xd8DlZfQU";
  late LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey);

  var uuid = const Uuid();
  String? _sessionToken;
  List<dynamic> _placeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = DioClient.instance.getAddress();

    _addressController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggetion(_addressController.text.trim());
  }

  void getSuggetion(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$apiKey&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));

    log(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _placeList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed tp load data');
    }
  }

  Completer<GoogleMapController> _controller = Completer();

  List<Marker> _marker = [];
  final List<Marker> _list = [];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  loaddata() {
    setState(() {
      showSpinner = true;
    });
    getUserCurrentLocation().then((value) async {
      print("My current location");
      print(value.latitude.toString() + " " + value.longitude.toString());

      // _marker.add(Marker(
      //     markerId: MarkerId("5"),
      //     position: LatLng(value.latitude, value.longitude),
      //     infoWindow: InfoWindow(title: "My location")));
      // CameraPosition cameraPosition = CameraPosition(
      //   zoom: 14,
      //   target: LatLng(value.latitude, value.longitude),
      // );

      // final GoogleMapController controller = await _controller.future;
      // controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      final coordinates = Coordinates(value.latitude, value.longitude);
      final address = await geocoder.findAddressesFromCoordinates(coordinates);

      var first = address.first.addressLine;
      log(first.toString());

      setState(() {
        showSpinner = false;
      });
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GetUserLocationScreen(
            address: first.toString(),
            locAddress: first.toString(),
            latitude: value.latitude,
            longitude: value.longitude,
          ),
        ),
      );
    });
  }

  move(String address, String locAddress, num lat, num long) {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GetUserLocationScreen(
          address: address,
          locAddress: locAddress,
          latitude: lat.toDouble(),
          longitude: long.toDouble(),
        ),
      ),
    );
  }

  late Future<AddressDetailsModel?> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),

          // ElevatedButton.icon(
          //   onPressed: () {},
          //   icon: Icon(Icons.location_on_sharp),
          //   label: Text("User my Current Location"),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.grey,
          //     foregroundColor: Colors.black,
          //     fixedSize: Size(double.infinity, 40),
          //     elevation: 0,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(10))),
          //   ),
          // ),

          Card(
            elevation: 0,
            child: Column(
              children: [
                TextField(
                    controller: _addressController,
                    // onChanged: (value) {
                    // },
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(70)),
                      hintText: "Search your location",
                      prefixIcon: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {
                      loaddata();
                    },
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.my_location,
                          color: Colors.purple,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Use current location",
                          style: TextStyle(color: Colors.purple, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder<AddressDetailsModel?>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  AddressDetailsModel addressData = AddressDetailsModel();
                  if (snapshot.hasData) {
                    addressData = snapshot.data!;
                    List<AddressDetails> addressList =
                        addressData.addressDetails ?? [];
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: addressList.length,
                            itemBuilder: (context, index) {
                              return AddressTile(
                                addressDetails: addressList[index],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            ),
          ),
          const Divider(),

          Expanded(
              child: ListView.builder(
                  itemCount: _placeList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        onTap: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          final address = await geocoder.findAddressesFromQuery(
                              _placeList[index]['description']);
                          setState(() {
                            showSpinner = false;
                          });

                          move(
                              _placeList[index]['description'],
                              _placeList[index]['description'],
                              num.parse(address.first.coordinates.latitude
                                  .toString()),
                              num.parse(address.first.coordinates.longitude
                                  .toString()));

                          // log(address.first.coordinates.toString());
                        },
                        title: Text(_placeList[index]['description']),
                      ),
                    );
                  }))
        ]),
      ),
    );
  }
}
