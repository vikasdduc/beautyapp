import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/controller/location_controller.dart';
import 'package:glamcode/data/model/user.dart';
import 'package:glamcode/data/model/useraddressmodel.dart';
import 'package:glamcode/screen_size.dart';
import 'package:glamcode/view/screens/gallery/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:glamcode/view/screens/home/search_srceen.dart';
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

import '../../../data/api/api_helper.dart';
import '../../../data/model/auth.dart';
import '../cart/cart_screen.dart';

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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _future = DioClient.instance.getHomePage();
    getUserAddress();
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
      print(response.body());
    }
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
          User user = const User();
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
                            SliverAppBar(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              iconTheme: IconThemeData(
                                  color: const Color(0xFF882EDF),
                                  size: Dimensions.fontSizeOverLarge),
                              toolbarHeight: Dimensions.fontSizeOverLarge * 1.5,
                              pinned: true,
                              floating: true,
                              centerTitle: true,
                              title: Align(
                                alignment: Alignment.topLeft,
                                // ignore: unnecessary_null_comparison

                                child: Text(
                                  userAddressModels!.address?.toString() ??
                                      BlocProvider.of<LocationController>(
                                              context,
                                              listen: true)
                                          .state ??
                                      "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeLarge,
                                      color: const Color(0xFF882EDF),
                                      backgroundColor: Colors.white,
                                      fontWeight: FontWeight.normal),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              titleSpacing: 0,
                              leading: InkWell(
                                onTap: () async {},
                                child: const Icon(Icons.location_on_rounded),
                              ),
                              actions: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CartScreen()));
                                    // Navigator.of(context).pushNamed('/cart');
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_SMALL),
                                    child: Icon(Icons.shopping_cart_rounded),
                                  ),
                                ),
                                // TextField(),
                              ],
                            ),
                            SliverAppBar(
                              expandedHeight: 0,
                              automaticallyImplyLeading: false,
                              backgroundColor: Colors.white,
                              toolbarHeight: kToolbarHeight,
                              pinned: true,
                              flexibleSpace: FlexibleSpaceBar(
                                background: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      // horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                      // vertical: Dimensions.PADDING_SIZE_SMALL
                                      ),
                                  child: SizedBox(
                                    height: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, left: 0, right: 0),
                                          child: Container(
                                              color: Colors.white,
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey)),
                                                        width: displayWidth(
                                                            context),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets
                                                                  .all(5.0),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                  Icons.search),
                                                              Text(
                                                                  "       Search here......")
                                                            ],
                                                          ),
                                                        )),
                                                  ))
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: Wrap(
                                  children: [
                                    ImageSlider(
                                      images: homePageModel.sliderImages ?? [],
                                    ),
                                    const ServicesGrid(),
                                    VideoEmbed(
                                      url: homePageModel
                                              .videos?.homePageVideoUrl ??
                                          "https://www.youtube.com/watch?v=i-X4wtDprY8",
                                    ),
                                    const Packages(),
                                    CustomerTestimonials(
                                      reviews: homePageModel.reviews ?? [],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                const Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: BottomServiceBar(),
                )
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
