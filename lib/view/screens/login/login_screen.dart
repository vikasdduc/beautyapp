import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:glamcode/blocs/auth/auth_bloc.dart';
import 'package:glamcode/helper/validator.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/loading_screen.dart';
import 'package:glamcode/view/screens/dashboard/dashboard_screen.dart';
import 'package:glamcode/view/screens/location/location_screen.dart';
import 'package:glamcode/view/screens/otp/otp_screen.dart';

class LoginPage extends StatefulWidget {
  final AuthBloc authBloc;
  const LoginPage({Key? key, required this.authBloc}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool code = false;
  final _LoginFormKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();
    return loading
        ? const LoadingScreen()
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset("assets/images/bgLogin.png"),
                      SafeArea(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/loginLogo.png",
                              height: MediaQuery.of(context).size.width * 0.2,
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            // Align(
                            //     alignment: Alignment.topRight,
                            //     child: Text("Skip>>"))
                          ],
                        ),
                      ))
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                    child: Form(
                      key: _LoginFormKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_DEFAULT),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                focusColor: Colors.black,
                                floatingLabelStyle:
                                    TextStyle(color: Colors.black),
                                labelText: "Phone Number",
                              ),
                              validator: CustomValidator().validateMobile,
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: phoneNumberController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_DEFAULT),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  loading = true;
                                });
                                print(loading);
                                if (_LoginFormKey.currentState!.validate()) {
                                  print(phoneNumberController.text);
                                  widget.authBloc.userRepository
                                      .sendOtp(phoneNumberController.text,
                                          referralCodeController.text)
                                      .then((value) {
                                    if (value) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => OTPScreen(
                                                  phoneNumber:
                                                      phoneNumberController
                                                          .text,
                                                  referlcode:
                                                      referralCodeController
                                                          .text)));
                                      setState(() {
                                        loading = false;
                                      });
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                      const snackBar = SnackBar(
                                        content: Text('Error sending OTP!'),
                                        backgroundColor: (Colors.black12),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  });
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
                              child: Container(
                                width: 400,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 155, 74, 221),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Get OTP",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: GestureDetector(
                                // child: Text(
                                //   "Referral Code",
                                //   style: TextStyle(
                                //       fontSize: displayHeight(context) * 0.025),
                                // ),
                                onTap: () {
                                  setState(() {
                                    code = true;
                                  });
                                },
                                child: Container(
                                  width: 400,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        const Color.fromARGB(255, 155, 74, 221),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Referral Code",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          code
                              ? Padding(
                                  padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_DEFAULT),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      focusColor: Colors.black,
                                      floatingLabelStyle:
                                          TextStyle(color: Colors.black),
                                      labelText: "Referal Code",
                                    ),
                                    // validator: CustomValidator().validateMobile,
                                    keyboardType: TextInputType.text,
                                    // autovalidateMode:
                                    //     AutovalidateMode.onUserInteraction,
                                    controller: referralCodeController,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
