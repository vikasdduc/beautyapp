import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/address_details_model.dart';
import 'package:glamcode/home.dart';
import 'package:glamcode/view/base/custom_text_field.dart';
import 'package:glamcode/view/base/loading_screen.dart';
import 'package:glamcode/view/screens/cart/cart_screen.dart';
import 'package:glamcode/view/screens/dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/auth.dart';
import '../../../data/model/user.dart';
import '../../../util/dimensions.dart';

class NewAddressScreen extends StatefulWidget {
  final String address;
  final String locAddress;
  final num latitude;
  final num longitude;
  const NewAddressScreen(
      {Key? key,
      required this.address,
      required this.locAddress,
      required this.latitude,
      required this.longitude})
      : super(key: key);

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen>
    with AutomaticKeepAliveClientMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationAddressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  late User currentUser;
  bool loading = false;

  getUser() async {
    User user = await Auth.instance.currentUser;
    mobileController.text = user.mobile ?? "";
    currentUser = user;
  }

  @override
  void initState() {
    addressController.text = widget.address;
    locationAddressController.text = widget.locAddress;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUser();
    });
  }

  late SharedPreferences prefs;
  void savepref(String address) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("AddressToShow", address);
    setState(() {});
  }

  final _newAddressFormKey = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD NEW ADDRESS"),
      ),
      body: loading
          ? const LoadingScreen()
          : Form(
              key: _newAddressFormKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_LARGE),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customTextField(
                          "Name", nameController, TextInputType.text, null),
                      customTextField("House no./ Flat no. ", addressController,
                          TextInputType.text, null),
                      customTextField(
                          "Location Address",
                          locationAddressController,
                          TextInputType.streetAddress,
                          null),
                      customTextField("Mobile Number", mobileController,
                          TextInputType.phone, null),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: CupertinoButton(
                          color: const Color(0xFFA854FC),
                          onPressed: () {
                            setState(() {
                              loading = true;
                            });
                            AddressDetails address = AddressDetails(
                                userId: currentUser.id,
                                addressHeading: nameController.text,
                                address: addressController.text,
                                street: locationAddressController.text,
                                lattitude: widget.latitude,
                                longitude: widget.longitude,
                                mobileNumber: currentUser.mobile,
                                callingCode: currentUser.callingCode);
                            savepref(address.address.toString());
                            if (_newAddressFormKey.currentState!.validate()) {
                              DioClient.instance
                                  .addAddress(address)
                                  .then((value) async {
                                if (value != null && value.addressId != null) {
                                  await DioClient.instance
                                      .setPrimaryAddress(value)
                                      .then((value) {
                                    if (value) {
                                      // Navigator.of(context).pushAndRemoveUntil(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const CartScreen()),
                                      //     ModalRoute.withName('/index'));
                                      // Navigator.pushAndRemoveUntil(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             DashboardScreen(
                                      //                 pageIndex: 0)),
                                      //     ModalRoute.withName('/index'));
                                      Navigator.pop(context);
                                      Navigator.pop(context);
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
                                    setState(() {
                                      loading = false;
                                    });
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
                          child: const Text("Add Address"),
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
