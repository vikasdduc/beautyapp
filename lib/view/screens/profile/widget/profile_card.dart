import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glamcode/data/model/auth.dart';
import 'package:glamcode/generated/assets.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/screens/profile/widget/edit_profile.dart';

import '../../../../data/model/user.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Auth.instance.currentUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.black,
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            User user = const User();
            if (snapshot.hasData) {
              user = snapshot.data!;
            }
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.imagesProfileBg),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Image.network(
                          user.image ??
                              "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
                          height: MediaQuery.of(context).size.width * 0.2,
                          color: Colors.white,
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Text(
                                user.name ?? "",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Text(
                                user.formattedMobile ?? "",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfileScreen(user: user)));
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ],
            );
          } else {
            Fluttertoast.showToast(msg: "There seems to be an error");
            return Container();
          }
        });
  }
}
