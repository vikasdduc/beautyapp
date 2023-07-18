// ignore_for_file: prefer_const_constructors

import 'dart:convert';
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
import 'package:http/http.dart';
import 'package:scratcher/widgets.dart';
import '../../../data/model/auth.dart';

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

    getpoint();
    getCash();
    _controller = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  CashbackViewModel? cashbackViewModel;
  getCash() async {
    User currentUser = await auth.currentUser;
    var urlsc = "https://admin.glamcode.in/api/scratch-card/${currentUser.id}";
    var response = await HttpHelpers.getRequest(urlsc);
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      var resp = CashbackViewModel.fromJson(jsondata);
      setState(() {
        cashbackViewModel = resp;
      });
    } else {
      print(response.body());
    }
  }

  WalletModel? walletModel;
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
      child: walletModel == null || cashbackViewModel == null
          ? LoadingScreen()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      color: Color(0xFF882EDF),
                    ),
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
                // tab bar view here
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: displayHeight(context) * 0.01,
                            ),
                            Text(
                              "Name :-   ${walletModel!.username!.toUpperCase()}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.01,
                            ),
                            Text(
                              "Points :-  ${walletModel!.total}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                                            Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          "Sr.No",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Container()),
                                                    const Expanded(
                                                        flex: 2,
                                                        child: Text("Points",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    const Expanded(
                                                        flex: 2,
                                                        child: Text("Expiry",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Container()),
                                                    const Expanded(
                                                        flex: 2,
                                                        child: Text("Created",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                  itemCount: walletModel!
                                                      .wallet!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Card(
                                                      color: index % 2 == 0
                                                          ? Colors.white
                                                          : Color.fromARGB(255,
                                                              248, 244, 244),
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
                                                                walletModel!
                                                                    .wallet![
                                                                        index]
                                                                    .sr
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                              Text(
                                                                walletModel!
                                                                    .wallet![
                                                                        index]
                                                                    .points
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                              Text(
                                                                walletModel!
                                                                    .wallet![
                                                                        index]
                                                                    .expiry
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                              Text(
                                                                walletModel!
                                                                    .wallet![
                                                                        index]
                                                                    .createdAt
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),

                                        // second tab bar view widget
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 10,
                                                    // mainAxisExtent: 150,
                                                    mainAxisSpacing: 10),
                                            itemCount: cashbackViewModel!
                                                .reward!.length,
                                            itemBuilder: (BuildContext context,
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
                                                                        Colors
                                                                            .transparent,
                                                                    body:
                                                                        SafeArea(
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: displayHeight(context) * 0.2, left: 20),
                                                                            child:
                                                                                GestureDetector(
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
                                                                            backgroundColor:
                                                                                Colors.white,
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
                                                                                      Text(
                                                                                        "You get ${cashbackViewModel!.reward!.first.reward}",
                                                                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                      ),
                                                                                      Text("Expired ${cashbackViewModel!.reward!.first.expiry}", style: const TextStyle(fontSize: 20, color: Colors.white)),
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
                                                                                          Text(cashbackViewModel!.reward!.first.describtion.toString(), style: const TextStyle(fontSize: 20, color: Colors.white)),
                                                                                        ],
                                                                                      ),
                                                                                      GestureDetector(
                                                                                        onTap: () {
                                                                                          addSave();
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
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Color(0xFF882EDF),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: Colors.white,
                                                            spreadRadius: 1),
                                                      ],
                                                    ),
                                                    height:
                                                        displayHeight(context) *
                                                            1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: SvgPicture.asset(
                                                          'assets/images/forntc.svg',
                                                          height: displayHeight(
                                                                  context) *
                                                              0.2,
                                                          width: 20.0,
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    ));
  }

  void addSave() async {
    User currentUser = await auth.currentUser;

    var url = "https://admin.glamcode.in/api/cashback";

    var body = {
      "id": cashbackViewModel!.reward!.first.id.toString(),
      "user_id": "${currentUser.id}",
      "booking_id": cashbackViewModel!.reward!.first.bookingId.toString(),
      "expiry_date": cashbackViewModel!.reward!.first.expiry.toString(),
      "reward": cashbackViewModel!.reward!.first.reward.toString(),
    };
    try {
      var response = await post(Uri.parse(url), body: body);
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
