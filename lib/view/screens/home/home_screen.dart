import 'dart:convert';
import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:glamcode/controller/location_controller.dart';
import 'package:glamcode/data/model/address_details_model.dart';
import 'package:glamcode/data/model/user.dart';
import 'package:glamcode/data/model/useraddressmodel.dart';
import 'package:glamcode/screen_size.dart';
import 'package:glamcode/view/screens/gallery/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:glamcode/view/screens/home/search_srceen.dart';
import 'package:glamcode/view/screens/location/location_screen.dart';
import 'package:glamcode/view/screens/notification/notification_screen.dart';
import 'package:http/http.dart' as http;
import 'package:glamcode/data/model/home_page.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/bottomServiceBar.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/base/loading_screen.dart';
import 'package:glamcode/view/screens/home/searchmodel.dart';
import 'package:glamcode/view/screens/home/widget/customer_testimonials.dart';
import 'package:glamcode/view/screens/home/widget/packages.dart';
import 'package:glamcode/view/screens/home/widget/services_grid.dart';
import 'package:glamcode/view/screens/home/widget/slider.dart';
import 'package:glamcode/view/screens/home/widget/video_embed.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/api/api_helper.dart';
import '../../../data/model/auth.dart';
import '../cart/cart_screen.dart';
import 'map_location/searchLocationMap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final searchController = TextEditingController();
  late Future<HomePageModel?> _future;
  // late Future<UserAddress?> _address;
  final Auth auth = Auth.instance;
  late AddressDetails addressDetails;
  String addressFromPref = "";
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _future = DioClient.instance.getHomePage();
    getUserAddress();
    getPrefs();
  }

  UserAddressModels? userAddressModels;

  getUserAddress() async {
    User currentUser = await auth.currentUser;
    var urlsc = "https://admin.glamcode.in/api/address/${currentUser.id}";
    // 4715
    var response = await HttpHelpers.getRequest(urlsc);
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      var resp = UserAddressModels.fromJson(jsondata);
      setState(() {
        userAddressModels = resp;
      });
    } else {
      log(response.body());
    }
  }

  late SharedPreferences sharedPreferences;
  getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? address = sharedPreferences.getString("AddressToShow");
    // print(address);
    setState(() {
      addressFromPref = address.toString();
      log(addressFromPref.toString());
    });
  }

  SearchModel? searchModel;
  List<Services> tempList = [];

  getProduct() async {
    final response =
        await http.get(Uri.parse("https://admin.glamcode.in/api/search"));

    if (response.statusCode == 200) {
      var resp = SearchModel.fromJson(jsonDecode(response.body));
      setState(() {
        searchModel = resp;
        for (int i = 0; i < searchModel!.services!.length; i++) {
          tempList.add(searchModel!.services![i]);
        }
      });
      return searchModel;
    } else {
      throw Exception('Failed to load product');
    }
  }

  @override
  Widget build(BuildContext context) {
    Auth.instance.currentUser;
    super.build(context);
    return FutureBuilder<HomePageModel?>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.connectionState == ConnectionState.done) {
          HomePageModel homePageModel = HomePageModel();
          if (snapshot.hasData) {
            homePageModel = snapshot.data!;

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      _future = DioClient.instance.getHomePage();
                    });
                  },
                  child: userAddressModels == null
                      //  || searchModel == null
                      ? const Center(child: CircularProgressIndicator())
                      // : Text(searchModel!.services!.first.category
                      //     .toString()),
                      : CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: <Widget>[
                            // SliverAppBar(
                            //   floating: true,
                            //   backgroundColor: const Color(0xFFFFF1F1),
                            //   elevation: 0,
                            //   iconTheme: IconThemeData(
                            //       color: const Color(0xFF882EDF),
                            //       size: Dimensions.fontSizeOverLarge),
                            //   toolbarHeight:
                            //       Dimensions.fontSizeOverLarge * 1.5,
                            //   // pinned: true,
                            //   centerTitle: true,
                            //   title: Align(
                            //     alignment: Alignment.topLeft,
                            //     // ignore: unnecessary_null_comparison
                            //     child: Text(
                            //       userAddressModels!.address?.toString() ??
                            //           BlocProvider.of<LocationController>(
                            //                   context,
                            //                   listen: true)
                            //               .state ??
                            //           "",
                            //       textAlign: TextAlign.center,
                            //       style: TextStyle(
                            //           fontSize: Dimensions.fontSizeLarge,
                            //           color: const Color(0xFF882EDF),
                            //           backgroundColor:
                            //               const Color(0xFFFFF1F1),
                            //           fontWeight: FontWeight.normal),
                            //       overflow: TextOverflow.ellipsis,
                            //     ),
                            //   ),
                            //   titleSpacing: 0,
                            //   leading: InkWell(
                            //     onTap: () async {
                            //       Navigator.pushReplacement(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) =>
                            //                   const SelectLocationScreen()));
                            //     },
                            //     child: const Icon(Icons.location_on_rounded),
                            //   ),
                            //   actions: [
                            //     InkWell(
                            //       onTap: () {
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     const CartScreen()));
                            //         // Navigator.of(context).pushNamed('/cart');
                            //       },
                            //       child: const Padding(
                            //         padding: EdgeInsets.symmetric(
                            //             horizontal:
                            //                 Dimensions.PADDING_SIZE_SMALL),
                            //         child: Icon(Icons.shopping_cart_rounded),
                            //       ),
                            //     ),
                            //     // TextField(),
                            // ],
                            // ),
                            SliverAppBar(
                              elevation: 0,
                              floating: true,
                              expandedHeight: 100,
                              automaticallyImplyLeading: false,
                              backgroundColor: const Color(0xFFFFF1F1),
                              toolbarHeight: kToolbarHeight,
                              pinned: true,
                              titleSpacing: 0,
                              flexibleSpace: FlexibleSpaceBar(
                                centerTitle: true,
                                title: SizedBox(
                                    height: 30,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SearchScreen(

                                                        // searchModel:
                                                        //     SearchModel(),
                                                        )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Card(
                                          shadowColor: Colors.red,
                                          elevation: 2,
                                          color: const Color(0xFFFFF1F1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Row(
                                            children: [
                                              const Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 5,
                                                  ),
                                                  child: Icon(
                                                    Icons.search,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "    Search for ",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 10),
                                              ),
                                              DefaultTextStyle(
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 10),
                                                  child: AnimatedTextKit(
                                                      repeatForever: true,
                                                      totalRepeatCount: 5,
                                                      animatedTexts: [
                                                        TyperAnimatedText(
                                                            "Waxing",
                                                            speed: Duration(
                                                                milliseconds:
                                                                    80)),
                                                        TyperAnimatedText(
                                                            "Facial",
                                                            speed: Duration(
                                                                milliseconds:
                                                                    80)),
                                                        TyperAnimatedText(
                                                            "Mani-Pedi",
                                                            speed: Duration(
                                                                milliseconds:
                                                                    80)),
                                                      ])),
                                              SizedBox(
                                                width: 90,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                                // title: Container(
                                //     color: const Color(0xFFFFF1F1),
                                //     child: GestureDetector(
                                //         onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const SearchScreen(

                                //                 // searchModel:
                                //                 //     SearchModel(),
                                //                 )));
                                //         },
                                //         child: Container(
                                //             decoration: BoxDecoration(
                                //                 borderRadius:
                                //                     BorderRadius.circular(12),
                                //                 border: Border.all(
                                //                     width: 1,
                                //                     color: Colors.grey)),
                                //             width: displayWidth(context),
                                //             child: Row(
                                //               children: [
                                // Text(
                                //   "    Search here...",
                                //   style: TextStyle(
                                //       color: Colors.black54),
                                // ),
                                // Align(
                                //   alignment:
                                //       Alignment.centerRight,
                                //   child: Padding(
                                //     padding: EdgeInsets.only(
                                //         left: 0),
                                //     child: Icon(Icons.search),
                                //   ),
                                //                 ),
                                //               ],
                                //             )))
                                //   child: TextField(
                                //     enableInteractiveSelection:
                                //         false, // will disable paste operation

                                //     // controller: searchController,

                                //     controller: searchController,
                                //     decoration:
                                //         const InputDecoration(
                                //       prefixIcon:
                                //           Icon(Icons.search),
                                //       hintText:
                                //           "Search Products Name",
                                //       // labelText:
                                //       //     "Search Products Name",
                                //       border: InputBorder.none,
                                //     ),
                                //   ),
                                // ),
                                // ),
                                background: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 50,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: Card(
                                        elevation: 0,
                                        color: const Color(0xFFFFF1F1),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SearchLocationScreen(
                                                                  edit: false,
                                                                  addressDetails:
                                                                      AddressDetails(),
                                                                )));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .location_on_rounded,
                                                        size: 15,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 200,
                                                        child: Text(
                                                          // addressFromPref.toString() ??
                                                          userAddressModels!
                                                                  .address
                                                                  ?.toString() ??
                                                              BlocProvider.of<
                                                                          LocationController>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                                  .state ??
                                                              "",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .black54),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    // CupertinoButton(
                                                    //     child: Icon(
                                                    //       Icons.shopping_cart,
                                                    //       size: 10,
                                                    //     ),
                                                    //     onPressed: () {}),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    ((context) =>
                                                                        const CartScreen())));
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .shopping_cart_outlined,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                    ),

                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    ((context) =>
                                                                        NotificationScreen())));
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .notifications_outlined,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ]),
                                              SizedBox(
                                                height: 7,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SliverToBoxAdapter(
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: ImageSlider(
                                      images: homePageModel.sliderImages ?? [],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    child: Center(
                                      child: Text(
                                        "Home Salon Services by Glamcode",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  const ServicesGrid(),
                                  const Packages(),
                                  VideoEmbed(
                                    url: homePageModel
                                            .videos?.homePageVideoUrl ??
                                        "https://www.youtube.com/watch?v=i-X4wtDprY8",
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomerTestimonials(
                                      reviews: homePageModel.reviews ?? [],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
                const BottomServiceBar()
              ],
            );
          } else {
            return const CustomError();
          }
        } else {
          return const CustomError();
        }
      },
    );
  }
}
