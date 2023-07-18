import 'package:flutter/material.dart';
import 'package:glamcode/data/model/address_details_model.dart';
import 'package:glamcode/view/base/custom_text_field.dart';
import 'package:glamcode/view/base/loading_screen.dart';
import 'package:glamcode/view/screens/address/select_address.dart';
import 'package:glamcode/view/screens/address/selectnew_address.dart';

import '../../../data/api/api_helper.dart';
import '../../../util/dimensions.dart';
import '../cart/cart_screen.dart';

class EditAddressScreen extends StatefulWidget {
  final AddressDetails addressDetails;
  const EditAddressScreen({
    Key? key,
    required this.addressDetails,
  }) : super(key: key);

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen>
    with AutomaticKeepAliveClientMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationAddressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.addressDetails.addressHeading ?? "";
    addressController.text = widget.addressDetails.address ?? "";
    locationAddressController.text = widget.addressDetails.street ?? "";
    mobileController.text = widget.addressDetails.mobileNumber ?? "";
  }

  final _editAddressFormKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("EDIT ADDRESS"),
      ),
      body: loading
          ? const LoadingScreen()
          : Form(
              key: _editAddressFormKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_LARGE),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customTextField(
                          "Name", nameController, TextInputType.text, null),
                      customTextField("Address", addressController,
                          TextInputType.text, null),
                      Row(
                        children: [
                          Expanded(
                            child: customTextField(
                                "Location Address",
                                locationAddressController,
                                TextInputType.streetAddress,
                                null),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Disclosure"),
                                  content: const Text(
                                      "Glam Code collects location data to enable you to select addresses even when the app is always in use."),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xFFA854FC))),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Deny"),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xFFA854FC))),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                settings: const RouteSettings(
                                                    name: "/edit-address"),
                                                builder: (context) =>
                                                    SelectAddressScreen(
                                                        edit: true,
                                                        addressDetails: widget
                                                            .addressDetails)));
                                      },
                                      child: const Text("Approve"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              child: Icon(Icons.edit),
                            ),
                          )
                        ],
                      ),
                      customTextField("Mobile Number", mobileController,
                          TextInputType.phone, null),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              loading = true;
                            });
                            AddressDetails address = AddressDetails(
                                addressId: widget.addressDetails.addressId,
                                userId: widget.addressDetails.userId,
                                addressHeading: nameController.text,
                                address: addressController.text,
                                street: locationAddressController.text,
                                lattitude: widget.addressDetails.lattitude,
                                longitude: widget.addressDetails.longitude,
                                mobileNumber:
                                    widget.addressDetails.mobileNumber,
                                callingCode: widget.addressDetails.callingCode);
                            if (_editAddressFormKey.currentState!.validate()) {
                              DioClient.instance
                                  .editAddress(address)
                                  .then((value) async {
                                if (value != null && value.addressId != null) {
                                  await DioClient.instance
                                      .setPrimaryAddress(value)
                                      .then((value) {
                                    if (value) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CartScreen()),
                                          ModalRoute.withName('/index'));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Error adding address',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  });
                                  setState(() {
                                    loading = false;
                                  });
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Error adding address',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              });
                            } else {
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                          child: const Text("Edit Address"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
