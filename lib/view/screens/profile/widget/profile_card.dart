import 'package:flutter/cupertino.dart';
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Image.network(
                    user.image ??
                        "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
                    height: MediaQuery.of(context).size.width * 0.2,
                    color: Colors.black,
                  ),
                ),
                Text(
                  user.name ?? "",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  user.formattedMobile ?? "",
                  style: const TextStyle(color: Colors.black54),
                ),

                CupertinoButton(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.amberAccent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 35, right: 35, top: 10, bottom: 10),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfileScreen(user: user)));
                    })

                // Row(
                //   children: [
                //     Flexible(
                //       flex: 1,
                //       child: Image.network(
                //         user.image ??
                //             "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
                //         height: MediaQuery.of(context).size.width * 0.2,
                //         color: Colors.white,
                //       ),
                //     ),
                //     Flexible(
                //       flex: 3,
                //       child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.all(
                //                 Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //             child: Text(
                //               user.name ?? "",
                //               style: const TextStyle(color: Colors.white),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.all(
                //                 Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //             child: Text(
                //               user.formattedMobile ?? "",
                //               style: const TextStyle(color: Colors.white),
                //             ),
                //           ),
                //         ],
                //       ),
                //     )
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                //   child: IconButton(
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => EditProfileScreen(user: user)));
                //     },
                //     icon: const Icon(Icons.edit, color: Colors.white),
                //   ),
                // ),
              ],
            );
          } else {
            Fluttertoast.showToast(msg: "There seems to be an error");
            return Container();
          }
        });
  }
}
