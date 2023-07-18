import 'package:flutter/material.dart';
import 'package:glamcode/data/model/address_details_model.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import 'edit_address.dart';
import 'new_address.dart';

class SelectAddressScreen extends StatefulWidget {
  final bool edit;
  final AddressDetails addressDetails;
  const SelectAddressScreen(
      {Key? key, required this.edit, required this.addressDetails})
      : super(key: key);

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map Screen"),
      ),
      body: OpenStreetMapSearchAndPick(
        center: LatLong(26.8467, 80.9462),
        onPicked: (pickedData) {
          setState(() {
            widget.addressDetails.address = pickedData.address;
            widget.addressDetails.lattitude = pickedData.latLong.latitude;
            widget.addressDetails.longitude = pickedData.latLong.longitude;
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => EditAddressScreen(
                  addressDetails: widget.addressDetails,
                ),
              ),
              ModalRoute.withName('/address'));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewAddressScreen(
                address:  pickedData.address,
                locAddress: pickedData.address,
                latitude: pickedData.latLong.latitude,
                longitude: pickedData.latLong.latitude,
              ),
            ),
          );

          print(widget.addressDetails.address);
        },
      ),
    );
  }
}
