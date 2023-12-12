import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glamcode/view/screens/address/new_address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/model/address_details_model.dart';
import '../home/map_location/searchLocationMap.dart';
import 'package:location_geocoder/location_geocoder.dart';

class GetUserLocationScreen extends StatefulWidget {
  String? address;
  String? locAddress;
  double? latitude;
  double? longitude;

  GetUserLocationScreen(
      {super.key,
      this.address,
      this.locAddress,
      this.latitude,
      this.longitude});

  @override
  State<GetUserLocationScreen> createState() => _GetUserLocationScreenState();
}

class _GetUserLocationScreenState extends State<GetUserLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  String apiKey = "AIzaSyAwhkMkZRsfmIezAuQOePphi9Xd8DlZfQU";
  late LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey);
  late LatLng destinationLocation;
  bool showSpinner = false;
  double lat = 0;
  double long = 0;
  @override
  void initState() {
    // TODO: implement initState
    destinationLocation = LatLng(widget.latitude!, widget.longitude!);
    kGooglePlex = CameraPosition(target: destinationLocation, zoom: 18);
    super.initState();
  }

  CameraPosition? kGooglePlex;

  List<Marker> _marker = <Marker>[];

  Future<Position> locateMe() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission denied permanentely");
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      widget.latitude = position.latitude;
      widget.longitude = position.longitude;
    });

    return position;
  }

  fixTheAddress() async {
    final coordinates = Coordinates(
        destinationLocation.latitude, destinationLocation.longitude);
    final address = await geocoder.findAddressesFromCoordinates(coordinates);
    setState(() {
      widget.address = address.first.addressLine;

      widget.latitude = destinationLocation.latitude;
      widget.longitude = destinationLocation.longitude;
    });
  }

  // String apiKey = "AIzaSyAwhkMkZRsfmIezAuQOePphi9Xd8DlZfQU";
  // late LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey);
  // Future<Position> getUserCurrentLocation1() async {
  //   await Geolocator.requestPermission()
  //       .then((value) {})
  //       .onError((error, stackTrace) {
  //     print("error" + error.toString());
  //   });
  //   return await Geolocator.getCurrentPosition();
  // }

  // loaddata() {
  //   setState(() {
  //     showSpinner = true;
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.backspace)),
        title: Text("Google Map"),
      ),
      body: (widget.address == null)
          ? CircularProgressIndicator()
          : SafeArea(
              child: Stack(children: [
                GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: kGooglePlex!,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  mapType: MapType.normal,
                  markers: Set<Marker>.of(_marker),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onCameraMove: (position) {
                    log(position.target.toString());
                    if (destinationLocation != position.target) {
                      setState(() {
                        destinationLocation = position.target;
                      });
                    }
                  },
                  onCameraIdle: () {
                    print("IDLE");
                    // add the function to get the address
                    fixTheAddress();
                    setState(() {});
                  },
                  onTap: (latlng) {
                    log(latlng.latitude.toString());
                    log(latlng.longitude.toString());
                  },
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.pin_drop_sharp),
                ),
                Positioned(
                  bottom: 240.0,
                  left: 0.0,
                  right: 0.0,
                  child: Padding(
                      padding: const EdgeInsets.only(right: 100, left: 100),
                      child: InkWell(
                        onTap: () async {
                          Position position = await locateMe();
                          final GoogleMapController googleMapController =
                              await _controller.future;
                          googleMapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(
                                      position.latitude, position.longitude),
                                  zoom: 14)));
                          _marker.clear();
                          _marker.add(Marker(
                              markerId: const MarkerId("Current Location"),
                              position: LatLng(
                                  position.latitude, position.longitude)));

                          final coordinates = Coordinates(
                              position.latitude, position.longitude);
                          final address = await geocoder
                              .findAddressesFromCoordinates(coordinates);

                          var first = address.first.addressLine;
                          log(first.toString());

                          widget.address = first;
                          widget.latitude = position.latitude;
                          widget.longitude = position.longitude;

                          setState(() {});

                          print(_marker.toString());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(12)),
                          height: 40,
                          width: 5,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "LOCATE ME",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SELECT SERVICE LOCATION',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 18.0),
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            const Text(
                              "Address Details",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SearchLocationScreen(
                                              edit: false,
                                              addressDetails: AddressDetails(),
                                            )));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          103, 164, 159, 159),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Padding(
                                      padding: EdgeInsets.all(6),
                                      child: Text(
                                        "CHANGE",
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.pink),
                                      ))),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.address!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                          ),
                        ),
                        const SizedBox(height: 18.0),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: CupertinoButton(
                            child: Text(
                              "CONFIRM LOCATION",
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  enableDrag: true,
                                  showDragHandle: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12))),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setstate) {
                                      return NewAddressScreen(
                                        address: widget.address.toString(),
                                        locAddress:
                                            widget.locAddress.toString(),
                                        latitude: widget.latitude!,
                                        longitude: widget.longitude!,
                                      );
                                    });
                                  });
                            },
                            color: Colors.pink,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
    );
  }
}
