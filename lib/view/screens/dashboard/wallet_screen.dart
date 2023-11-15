// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glamcode/data/model/user.dart';
import 'package:glamcode/screen_size.dart';
import 'package:glamcode/view/base/loading_screen.dart';

import 'package:glamcode/view/screens/cashback/cashbackmodel.dart';
import 'package:glamcode/view/screens/dashboard/dashboard_screen.dart';

import 'package:glamcode/view/screens/dashboard/wallatemodel.dart';
import 'package:glamcode/view/screens/gallery/http_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:scratcher/widgets.dart';
import '../../../data/model/auth.dart';
import 'cashbackcratchCardModel.dart';
import 'package:shimmer/shimmer.dart';

class WalletScreen extends StatefulWidget {
  final CashbackViewModel? data;
  const WalletScreen({super.key, this.data});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late ConfettiController _controller;

  // @override
  // void initState() {
  //   _tabController =  TabController(length: 2, vsync: this);
  //   super.initState();
  // }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  final Auth auth = Auth.instance;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
    // _future = DioClient.instance.getHomePage();
    getCard();
    getpoint();
    // getCash();
    _controller = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  // CashbackViewModel? cashbackViewModel;
  // getCash() async {
  //   User currentUser = await auth.currentUser;
  //   var urlsc = "https://admin.glamcode.in/api/scratch-card/${currentUser.id}";
  //   var response = await HttpHelpers.getRequest(urlsc);
  //   if (response.statusCode == 200) {
  //     var jsondata = json.decode(response.body);
  //     var resp = CashbackViewModel.fromJson(jsondata);
  //     setState(() {
  //       cashbackViewModel = resp;
  //     });
  //   } else {
  //     print(response.body());
  //   }
  // }

  ScratchCardModel scratchCardModel = ScratchCardModel();
  Future<ScratchCardModel?> getCard() async {
    log("ScratchCardModel");
    User? currentUser = await auth.currentUser;
    final Map<String, dynamic> data = {
      "user_id": currentUser.id,
    };

    var urlsc = "https://admin.glamcode.in/api/cashback";

    try {
      var response = await http.post(
        Uri.parse(urlsc),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      log("Response Status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        var resp = ScratchCardModel.fromJson(jsondata);
        setState(() {
          scratchCardModel = resp;
        });
        print("Data: ${scratchCardModel.status.toString()}");
        return scratchCardModel;
      } else {
        print("Error Response Body: ${response.body}");
        return scratchCardModel;
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  WalletModel walletModel = WalletModel();
  getpoint() async {
    User currentUser = await auth.currentUser;
    var urlsc = "https://admin.glamcode.in/api/user_wallet/${currentUser.id}";
    var response = await HttpHelpers.getRequest(urlsc);
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      var resp = WalletModel.fromJson(jsondata);
      setState(() {
        walletModel = resp;
      });
    } else {
      print(response.body());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: Padding(
      padding: const EdgeInsets.all(8),
      // child: walletModel == null || cashbackViewModel == null
      child: walletModel == null && scratchCardModel == null
          ? LoadingScreen()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 30, top: 50),
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
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          // color: Color(0xFF882EDF),
                          color: Color.fromARGB(255, 245, 190, 208)),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        // first tab [you can add an icon using the icon property]
                        Tab(
                          text: 'Wallet',
                        ),

                        // second tab [you can add an icon using the icon property]
                        Tab(
                          text: 'Cashback',
                        ),
                      ],
                    ),
                  ),
                ),
                // tab bar view here
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: displayHeight(context) * 0.01,
                          ),
                          Center(
                            child: walletModel.username == null
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: SizedBox(
                                      height: 170,
                                      width: 350,
                                      child: Card(
                                        elevation: 15,
                                        shadowColor: Colors.pink,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Container(),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 170,
                                    width: 350,
                                    child: Card(
                                      elevation: 15,
                                      shadowColor: Colors.pink,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                            colors: const[
                                              Color.fromARGB(
                                                  255, 164, 137, 240),
                                              Color.fromARGB(255, 237, 93, 141),
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              "   ${walletModel.username!.toUpperCase()}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 23,
                                                  color: Colors.yellow),
                                            ),
                                            SizedBox(
                                              height:
                                                  displayHeight(context) * 0.01,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Row(children: [
                                                Text(
                                                  "${walletModel!.total}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 40,
                                                      color: Color.fromARGB(
                                                          255, 255, 211, 53)),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "GlamPoints",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Color.fromARGB(
                                                          255, 255, 211, 53)),
                                                ),
                                              ]),
                                            ),
                                            Divider(),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DashboardScreen(
                                                                pageIndex: 0)));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 80, top: 3),
                                                child: Text(
                                                  "R E D E E M     N O W !",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 238, 243, 238),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),

                          // give the tab bar a height [can change hheight to preferred height]
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      // DataTable(
                                      //     // Datatable widget that have the property columns and rows.
                                      //     columns: [
                                      //       // Set the name of the column
                                      //       DataColumn(
                                      //         label: Text('ID'),
                                      //       ),
                                      //       DataColumn(
                                      //         label: Text('Name'),
                                      //       ),
                                      //       DataColumn(
                                      //         label: Text('LastName'),
                                      //       ),
                                      //       DataColumn(
                                      //         label: Text('Age'),
                                      //       ),
                                      //     ],
                                      //     rows:
                                      //     [
                                      //       // Set the values to the columns
                                      //       DataRow(cells: [
                                      //         DataCell(Text(
                                      //             walletModel!.total!.toString())),
                                      //         DataCell(Text("Alex")),
                                      //         DataCell(Text("Anderson")),
                                      //         DataCell(Text("18")),
                                      //       ]),
                                      //       DataRow(cells: [
                                      //         DataCell(Text("2")),
                                      //         DataCell(Text("John")),
                                      //         DataCell(Text("Anderson")),
                                      //         DataCell(Text("24")),
                                      //       ]),
                                      //     ]),

                                      Column(
                                        children: [
                                          // Card(
                                          //   child: Padding(
                                          //     padding:
                                          //         const EdgeInsets.all(10.0),
                                          //     child: Row(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment
                                          //               .spaceBetween,
                                          //       children: [
                                          //         const Expanded(
                                          //             flex: 1,
                                          //             child: Text(
                                          //               "Sr.No",
                                          //               style: TextStyle(
                                          //                   fontWeight:
                                          //                       FontWeight
                                          //                           .bold),
                                          //             )),
                                          //         Expanded(
                                          //             flex: 1,
                                          //             child: Container()),
                                          //         const Expanded(
                                          //             flex: 2,
                                          //             child: Text("Points",
                                          //                 style: TextStyle(
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold))),
                                          //         const Expanded(
                                          //             flex: 2,
                                          //             child: Text("Expiry",
                                          //                 style: TextStyle(
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold))),
                                          //         Expanded(
                                          //             flex: 1,
                                          //             child: Container()),
                                          //         const Expanded(
                                          //             flex: 2,
                                          //             child: Text("Created",
                                          //                 style: TextStyle(
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold))),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount:
                                                  walletModel?.wallet?.length ??
                                                      0,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                if (walletModel == null ||
                                                    walletModel.wallet ==
                                                        null) {
                                                  // Handle the case where walletModel or walletModel.wallet is null
                                                  return SizedBox
                                                      .shrink(); // or return a loading indicator or error message
                                                }

                                                return Card(
                                                  elevation: 10,
                                                  shadowColor: Colors.pink,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  color: index % 2 == 0
                                                      ? Colors.white
                                                      : Color.fromARGB(
                                                          255, 248, 244, 244),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: double.infinity,
                                                      height: 50.0,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              walletModel
                                                                  .wallet![
                                                                      index]
                                                                  .sr
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.0,
                                                              ),
                                                            ),
                                                            Text(
                                                              walletModel
                                                                  .wallet![
                                                                      index]
                                                                  .points
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.0,
                                                              ),
                                                            ),
                                                            Text(
                                                              walletModel
                                                                  .wallet![
                                                                      index]
                                                                  .expiry
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.0,
                                                              ),
                                                            ),
                                                            Text(
                                                              walletModel
                                                                  .wallet![
                                                                      index]
                                                                  .createdAt
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      // second tab bar view widget

                                      FutureBuilder<ScratchCardModel?>(
                                        future: getCard(),
                                        builder: (context,
                                            AsyncSnapshot<ScratchCardModel?>
                                                snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            // If the Future is still running, show a loading indicator or an empty container
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError ||
                                              snapshot.data == null) {
                                            // If the Future completes with an error, display the error message
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            // If the Future completes successfully, build the UI using the data
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        crossAxisSpacing: 10,
                                                        // mainAxisExtent: 150,
                                                        mainAxisSpacing: 10),
                                                // itemCount:
                                                //     cashbackViewModel!.reward!.length,
                                                itemCount: scratchCardModel
                                                    .data!.cashback!.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Scaffold(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        body:
                                                                            SafeArea(
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsets.only(top: displayHeight(context) * 0.2, left: 20),
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: CircleAvatar(
                                                                                    radius: 15,
                                                                                    child: Icon(Icons.close, color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              AlertDialog(
                                                                                backgroundColor: Colors.white,
                                                                                actions: [
                                                                                  Scratcher(
                                                                                    brushSize: 100,
                                                                                    threshold: 100,
                                                                                    color: Color(0xFF882EDF),
                                                                                    onChange: (value) => print("Scratch progress: $value%"),
                                                                                    onThreshold: () => _controller.play(),
                                                                                    child: Container(
                                                                                      decoration: const BoxDecoration(
                                                                                        image: DecorationImage(
                                                                                          image: AssetImage(
                                                                                            'assets/images/background.png',
                                                                                          ),
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                      height: displayHeight(context) * 0.3,
                                                                                      width: displayWidth(context) * 0.8,
                                                                                      // color: Colors
                                                                                      //     .grey,
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          // Text(
                                                                                          //   "You get ${cashbackViewModel!.reward!.first.reward}",
                                                                                          //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                          // ),
                                                                                          // Text("Expired ${cashbackViewModel!.reward!.first.expiry}", style: const TextStyle(fontSize: 20, color: Colors.white)),
                                                                                          Text(
                                                                                            "You get ${scratchCardModel.data!.cashback![index].amount}",
                                                                                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                          ),
                                                                                          Text("Expired ${scratchCardModel.data!.cashback![index].unit}", style: const TextStyle(fontSize: 20, color: Colors.white)),
                                                                                          Column(
                                                                                            children: [
                                                                                              ConfettiWidget(
                                                                                                blastDirectionality: BlastDirectionality.explosive,
                                                                                                confettiController: _controller,
                                                                                                particleDrag: 0.05,
                                                                                                emissionFrequency: 0.05,
                                                                                                numberOfParticles: 100,
                                                                                                gravity: 0.05,
                                                                                                shouldLoop: false,
                                                                                                colors: const [
                                                                                                  Colors.green,
                                                                                                  Colors.red,
                                                                                                  Colors.yellow,
                                                                                                  Colors.blue,
                                                                                                ],
                                                                                              ),
                                                                                              Text("${scratchCardModel!.data!.cashback![index].type}", style: const TextStyle(fontSize: 20, color: Colors.white)),
                                                                                            ],
                                                                                          ),
                                                                                          GestureDetector(
                                                                                            onTap: () {
                                                                                              addSave(scratchCardModel.data!.cashback![index].cashbackId.toString());
                                                                                              Navigator.push(
                                                                                                context,
                                                                                                MaterialPageRoute(builder: (context) => DashboardScreen(pageIndex: 1)),
                                                                                              );
                                                                                            },
                                                                                            child: const Card(
                                                                                                child: Padding(
                                                                                              padding: EdgeInsets.all(8.0),
                                                                                              child: Text(
                                                                                                "Accept",
                                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                            )),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ))
                                                          // ScrachView(
                                                          //   data:
                                                          //       cashbackViewModel,
                                                          // ))
                                                          );
                                                    },
                                                    child: (scratchCardModel
                                                                .data!
                                                                .cashback![
                                                                    index]
                                                                .scratched ==
                                                            "false")
                                                        ? Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      250,
                                                                      250,
                                                                      251),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    spreadRadius:
                                                                        1),
                                                              ],
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "You've won \n    ₹ ${scratchCardModel!.data!.cashback![index].amount}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black45,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: Color(
                                                                  0xFF882EDF),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    spreadRadius:
                                                                        1),
                                                              ],
                                                            ),
                                                            height: displayHeight(
                                                                    context) *
                                                                1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/images/forntc.svg',
                                                                  height: displayHeight(
                                                                          context) *
                                                                      0.2,
                                                                  width: 16.0,
                                                                  allowDrawingOutsideViewBox:
                                                                      true,
                                                                ),
                                                              ),
                                                            )
                                                            // child: Text(cashbackViewModel!
                                                            //     .reward![index].expiry
                                                            //     .toString()))
                                                            ),
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    ));
  }

  void addSave(String couponId) async {
    User currentUser = await auth.currentUser;

    var url = "https://admin.glamcode.in/api/scratch-card/$couponId/false";

    var body = {
      //   "id": cashbackViewModel!.reward!.first.id.toString(),
      //   "user_id": "${currentUser.id}",
      //   "booking_id": cashbackViewModel!.reward!.first.bookingId.toString(),
      //   "expiry_date": cashbackViewModel!.reward!.first.expiry.toString(),
      //   "reward": cashbackViewModel!.reward!.first.reward.toString(),
    };
    try {
      var response = await get(Uri.parse(url));
      if (kDebugMode) {
        print(response);
      }
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        if (jsondata["status"] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
                content: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Record Success',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
          );
        } else {
          const AlertDialog(
            actions: [Text("data not Add")],
          );
        }
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
    }
  }
}
