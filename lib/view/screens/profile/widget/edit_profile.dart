import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/view/base/custom_text_field.dart';

import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../data/model/user.dart';
import '../../../../util/dimensions.dart';
import '../../../base/loading_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name ?? "";
    addressController.text = widget.user.detailedAddress ?? "";
    emailController.text = widget.user.email ?? "";
    mobileController.text = widget.user.mobile ?? "";
  }

  final _editProfileFormKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? const LoadingScreen() : Scaffold(
      appBar: AppBar(
        title: const Text("EDIT PROFILE"),
      ),
      body: Form(
        key: _editProfileFormKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_LARGE),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customTextField(
                    "Name", nameController, TextInputType.text, null),
                customTextField(
                    "Email", emailController, TextInputType.emailAddress, null),
                customTextField("Address", addressController,
                    TextInputType.streetAddress, null),
                customTextField("Mobile Number", mobileController,
                    TextInputType.phone, null),
                Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      if (_editProfileFormKey.currentState!.validate()) {
                        User finalUser = widget.user.copyWith(name: nameController.text, email: emailController.text, address: addressController.text, mobile: mobileController.text);
                        context.read<AuthBloc>().add(UserUpdated(finalUser));
                        Navigator.pop(context);
                        setState(() {
                          loading = false;
                        });
                      } else {
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    child: const Text("Edit Profile"),
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
