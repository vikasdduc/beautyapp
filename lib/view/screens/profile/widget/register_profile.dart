import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/view/base/custom_text_field.dart';
import 'package:glamcode/view/screens/dashboard/dashboard_screen.dart';

import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../data/model/user.dart';
import '../../../../util/dimensions.dart';
import '../../../base/loading_screen.dart';

class RegisterProfileScreen extends StatefulWidget {
  final User user;
  const RegisterProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<RegisterProfileScreen> createState() => _RegisterProfileScreenState();
}

class _RegisterProfileScreenState extends State<RegisterProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
    FacebookAppEvents facebookAppEvents = FacebookAppEvents();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name ?? "";
    emailController.text = widget.user.email ?? "";
    loading = false;
     
    facebookAppEvents.logEvent(
      name: 'Registration Page',
      parameters: {
        'visited Registration Page': 'visited Registration Page',
      },
    );
  }

  final _registerProfileFormKey = GlobalKey<FormState>();
  late bool loading;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text("REGISTER"),
              centerTitle: true,
            ),
            body: Form(
              key: _registerProfileFormKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_LARGE),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customTextField(
                          "Name", nameController, TextInputType.text, null),
                      customTextField("Email", emailController,
                          TextInputType.emailAddress, null),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: TextButton(
                          onPressed: () {
                            facebookAppEvents.setUserData(
                    email: emailController.text.trim(),
                    firstName: nameController.text.trim(),
                  );
                            setState(() {
                              loading = true;
                            });
                            if (_registerProfileFormKey.currentState!
                                .validate()) {
                              User finalUser = widget.user.copyWith(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim());
                              print(finalUser.toJson());
                              context
                                  .read<AuthBloc>()
                                  .add(UserUpdated(finalUser));
                              Navigator.of(context)
                                  .pop();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen(pageIndex: 0)));
                            } else {
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                          child: const Text("Register"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text:
                                'By joining thr Glamcode, you agree to our\n ',
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeLarge,
                                color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Terms & Conditions.',
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeLarge,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed('/privacy');
                                    }),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
