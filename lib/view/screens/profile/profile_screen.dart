import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glamcode/blocs/auth/auth_bloc.dart';
import 'package:glamcode/home.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/screens/profile/widget/profile_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../util/delete_my_account.dart';
import '../dashboard/dashboard_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(left: 30),
        //   child: Align(
        //       alignment: Alignment.centerLeft,
        //       child: InkWell(
        //           onTap: () {
        //             Navigator.pushAndRemoveUntil(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) =>
        //                         const DashboardScreen(pageIndex: 0)),
        //                 (route) => false);
        //           },
        //           child: Icon(Icons.arrow_back_ios))),
        // ),
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: ProfileCard()),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: ListTile.divideTiles(
                context: context,
                color: Colors.black,
                tiles: [
                  profileListTile(Icons.contact_mail_outlined, "Contact Us",
                      context, "mailto:info@glamcode.in", true),
                  profileListTile(Icons.abc_outlined, "About Glamcode", context,
                      "/about", false),
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 183, 213, 247),
                      radius: 17,
                      child: Icon(
                        Icons.rate_review,
                        size: 20,
                      ),
                    ),
                    trailing: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 242, 240, 240),
                        child: Icon(
                          Icons.navigate_next_rounded,
                          color: Colors.black54,
                        )),
                    title: Text("Rate Us"),
                    onTap: openStore,
                  ),
                  profileListTile(Icons.privacy_tip, "Privacy Policy", context,
                      "/privacy", false),
                  profileListTile(Icons.text_format_sharp,
                      "Terms and Conditions", context, "/terms", false),
                  profileListTile(Icons.read_more_outlined, "Blogs", context,
                      "/privacy", false),
                  // profileListTile(
                  //     Icons.abc_outlined, "About Us", context, "/about", false),
                  profileListTile(Icons.contact_emergency, "Contact", context,
                      "/about", false),
                  profileListTile(Icons.shopping_cart_checkout_outlined,
                      "My Cart", context, "/my-cart", false),
                  profileListTile(Icons.refresh_outlined, "Refer and Earn",
                      context, "/refer-earn", false),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 183, 213, 247),
                      radius: 17,
                      child: Icon(
                        Icons.logout_sharp,
                        size: 20,
                      ),
                    ),
                    trailing: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 183, 213, 247),
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 242, 240, 240),
                        child: Icon(
                          Icons.navigate_next_rounded,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    title: const Text("Logout"),
                    onTap: () {
                      final AuthBloc authBloc = context.read<AuthBloc>();
                      authBloc.userRepository.signOut();
                      authBloc.add(AppLoaded());
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => Home(authBloc: authBloc)),
                          ModalRoute.withName('/index'));
                    },
                  ),
                  profileListTile(Icons.delete_forever_outlined,
                      "Delete My Account", context, "/delete-my-account", false)
                ]).toList(),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        //   child: SizedBox(
        //     width: double.infinity,
        //     child: ElevatedButton(
        //       style: ButtonStyle(
        //           backgroundColor:
        //               MaterialStateProperty.all(const Color(0xFFA854FC))),
        //       onPressed: () {
        //         final AuthBloc authBloc = context.read<AuthBloc>();
        //         authBloc.userRepository.signOut();
        //         authBloc.add(AppLoaded());
        //         Navigator.of(context).pushAndRemoveUntil(
        //             MaterialPageRoute(
        //                 builder: (context) => Home(authBloc: authBloc)),
        //             ModalRoute.withName('/index'));
        //       },
        //       child: const Padding(
        //         padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        //         child: Text(
        //           "Logout",
        //           style: TextStyle(color: Colors.white),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

Widget profileListTile(IconData myicon, String title, BuildContext context,
    String url, bool isUrl) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: const Color.fromRGBO(183, 213, 247, 1),
      radius: 17,
      child: Icon(
        myicon,
        size: 20,
      ),
    ),
    trailing: const CircleAvatar(
      backgroundColor: Color.fromARGB(255, 242, 240, 240),
      radius: 17,
      child: Icon(
        Icons.navigate_next_rounded,
        color: Colors.black54,
      ),
    ),
    title: Text(title),
    onTap: () async {
      isUrl ? await launchLink(url) : Navigator.of(context).pushNamed(url);
    },
  );
}

Future<void> launchLink(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}

openStore() async {
  const marketPlaceUrl = 'in.glamcode.app';
  if (Platform.isAndroid) {
    try {
      if (!await launchUrl(Uri.parse("market://details?id=$marketPlaceUrl"),
          mode: LaunchMode.externalApplication)) {
        throw 'Could not launch "market://details?id=$marketPlaceUrl"';
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  } else if (Platform.isIOS) {
    try {
      if (!await launchUrl(
          Uri.parse(
              "itms://itunes.apple.com/in/app/apple-store/{APPLE_STORE_ID}"),
          mode: LaunchMode.externalApplication)) {
        throw 'Could not launch "market://details?id=$marketPlaceUrl"';
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
