import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/blocs/auth/auth_bloc.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String referlcode;
  const OTPScreen(
      {Key? key, required this.phoneNumber, required this.referlcode})
      : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final pinController = TextEditingController();
  final otpFormKey = GlobalKey<FormState>();

  void submitOtp(String? otp) {
    if (otpFormKey.currentState!.validate()) {
      final AuthBloc authBloc = context.read<AuthBloc>();
      print(widget.phoneNumber);
      authBloc.userRepository
          .verifyOtp(otp ?? "", widget.phoneNumber)
          .then((value) async {
        if (value) {
          authBloc.add(AppLoaded());
          if (await authBloc.userRepository.isSignedIn()) {
            Navigator.of(context).pop();
            
          }
        }
      });
    }
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  late Timer _timer;
  late int start;

  void startTimer() {
    start = 120;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SafeArea(
          child: Form(
            key: otpFormKey,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    vertical: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text(
                          "Enter Verification Code",
                          style: TextStyle(
                            fontSize: Dimensions.fontSizeOverLarge,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text(
                          "We have sent you a 4-digit verification code\n on +91-${widget.phoneNumber}",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: Dimensions.fontSizeLarge),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                        child: Pinput(
                          validator: (s) {
                            if (s != null) {
                              return s.length == 4
                                  ? null
                                  : "OTP should be of 4 digits.";
                            } else {
                              return "Enter OTP";
                            }
                          },
                          controller: pinController,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          //onCompleted: (pin) => print(pin),
                          onCompleted: submitOtp,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: TextButton(
                          onPressed: () {
                            submitOtp(pinController.text);
                          },
                          child: const Text("Verify"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black)),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: "$start sec  ",
                                style: const TextStyle(color: Colors.black54)),
                            TextSpan(
                              text: 'Resend',
                              style: TextStyle(
                                  color: start == 0
                                      ? Colors.blue
                                      : Colors.black87),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print(widget.phoneNumber);
                                  setState(() {
                                    startTimer();
                                  });
                                  start == 0
                                      ? context
                                          .read<AuthBloc>()
                                          .userRepository
                                          .sendOtp(widget.phoneNumber,
                                              widget.referlcode)
                                      : null;
                                  print('Resend');
                                },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
