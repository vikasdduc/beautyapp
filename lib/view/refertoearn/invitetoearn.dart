import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glamcode/data/model/auth.dart';
import 'package:glamcode/data/model/user.dart';
import 'package:glamcode/screen_size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glamcode/view/base/loading_screen.dart';
import 'package:glamcode/view/refertoearn/referalmodel.dart';
import 'package:glamcode/view/screens/gallery/http_helper.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class InviteToEarn extends StatefulWidget {
  const InviteToEarn({super.key});

  @override
  State<InviteToEarn> createState() => _InviteToEarnState();
}

class _InviteToEarnState extends State<InviteToEarn> {
  final Auth auth = Auth.instance;
  @override
  void initState() {
    super.initState();
    // _future = DioClient.instance.getHomePage();

    getreferal();
  }

  ReferalModel? referalModel;
  getreferal() async {
    User currentUser = await auth.currentUser;
    var urlsc = "https://admin.glamcode.in/api/refer-friends/${currentUser.id}";
    var response = await HttpHelpers.getRequest(urlsc);
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      var resp = ReferalModel.fromJson(jsondata);
      setState(() {
        referalModel = resp;
      });
    } else {
      print(response.body());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Refer To Earn"),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          displayHeight(context) * 0.05,
        ),
        child: referalModel == null
            ? const Center(child: LoadingScreen())
            : Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/Untitled design.svg',
                    height: displayHeight(context) * 0.25,
                    width: 20.0,
                    allowDrawingOutsideViewBox: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          color: const Color(0xFF882EDF).withOpacity(0.8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Referall Code",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: displayHeight(context) * 0.018),
                                ),
                                Text(
                                    referalModel!
                                        .referFriendsDetails!.first.referCode
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            displayHeight(context) * 0.018)),
                              ],
                            ),
                          )),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding:
                              EdgeInsets.all(displayHeight(context) * 0.01),
                          child: GestureDetector(
                            onTap: () async {
                              Clipboard.setData(ClipboardData(
                                  text: referalModel!
                                      .referFriendsDetails!.first.referCode
                                      .toString())).then((_) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Referall Code Copied.."))));
                            },
                            child: Text("Copy\nCode",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: displayHeight(context) * 0.018)),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.05,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Invit and Earn",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: displayHeight(context) * 0.02),
                      )),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "How do it Work ?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: displayHeight(context) * 0.018),
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.01,
                            ),
                            Text(
                              "1. Refer a Frind to Download and Sign Up on Glamcode App.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: displayHeight(context) * 0.018),
                            ),
                            Text(
                              "2. As soon as the referees sign up using the refer code, they will receive INR 100 in their GC Wallet.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: displayHeight(context) * 0.018),
                            ),
                            Text(
                              "3. For every referee who completes his/her first booking, the referrer's GC Wallet will be credited with INR 150.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: displayHeight(context) * 0.018),
                            ),
                            Text(
                              "4. Thereafter every time the referees complete a booking, the referrers will keep receiving INR 50 in their GC Wallet.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: displayHeight(context) * 0.018),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(height: displayHeight(context) * 0.02),
                  GestureDetector(
                    onTap: () {
                      Share.share(
                          referalModel!.referFriendsDetails!.first.referUrl
                              .toString(),
                          subject: referalModel!
                              .referFriendsDetails!.first.referCode
                              .toString());
                    },
                    child: Card(
                        color: const Color(0xFF882EDF).withOpacity(0.8),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "REFER NOW",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              ),
      ),
    );
  }
}
