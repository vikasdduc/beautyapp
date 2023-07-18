import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glamcode/blocs/auth/auth_bloc.dart';
import 'package:glamcode/home.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/screens/profile/widget/profile_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: ProfileCard()),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: ListTile.divideTiles(
                context: context,
                color: Colors.black,
                tiles: [
                  profileListTile(
                      "Contact Us", context, "mailto:info@glamcode.in", true),
                  profileListTile("About Glamcode", context, "/about", false),
                  const ListTile(
                    trailing: Icon(Icons.navigate_next_rounded),
                    title: Text("Rate Us"),
                    onTap: openStore,
                  ),
                  profileListTile("Privacy Policy", context, "/privacy", false),
                  profileListTile(
                      "Terms and Conditions", context, "/terms", false)
                ]).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFA854FC))),
              onPressed: () {
                final AuthBloc authBloc = context.read<AuthBloc>();
                authBloc.userRepository.signOut();
                authBloc.add(AppLoaded());
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => Home(authBloc: authBloc)),
                    ModalRoute.withName('/index'));
              },
              child: const Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

Widget profileListTile(
    String title, BuildContext context, String url, bool isUrl) {
  return ListTile(
    trailing: const Icon(Icons.navigate_next_rounded),
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
