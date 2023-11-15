import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:glamcode/data/model/auth.dart';
import 'package:glamcode/helper/responsive_helper.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/screens/dashboard/wallet_screen.dart';
import 'package:glamcode/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:glamcode/view/screens/home/home_screen.dart';
import 'package:glamcode/view/screens/location/location_screen.dart';
import 'package:glamcode/view/screens/my_booking/my_booking_screen.dart';
import 'package:glamcode/view/screens/notification/notification_screen.dart';
import 'package:glamcode/view/screens/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../util/custom_drawer.dart';
import 'package:launch_review/launch_review.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  const DashboardScreen({super.key, required this.pageIndex});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  late final List<Widget> _screens = const [
    HomeScreen(),
    WalletScreen(),
    // GalleryScreen(),
    MyBookingScreen(),
    // NotificationScreen(),
    ProfileScreen(),
  ];
  late List<String> _titles;
  late List<BottomNavigationBarItem> bottomNavbarList;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = kIsWeb ? true : false;
  late SharedPreferences prefs;
  late bool isCitySelected;

  @override
  void initState() {
    super.initState();
    final checker = AppVersionChecker();
    checker.checkUpdate();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _titles = [
      "GLAM CODE",
      "Wallet",
      "My Bookings",
      // "Notifications",
      "Profile"
    ];

    bottomNavbarList = [
      bottomNavItem(
        context,
        Icons.cabin_outlined,
        "Home",
      ),
      bottomNavItem(
        context,
        Icons.wallet_outlined,
        "Wallet",
      ),
      bottomNavItem(
        context,
        Icons.calendar_month_outlined,
        "Bookings",
      ),
      // bottomNavItem(context, Icons.notifications, "Notifications"),
      bottomNavItem(
        context,
        Icons.person_outlined,
        "Profile",
        
      )
    ];

    if (Platform.isAndroid || Platform.isIOS) {
      // print(Get.find<NetworkStatusController>().connectionType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (_canExit) {
            return true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Back press again to exit.',
                  style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Color(0xFF882EDF),
            

              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            _canExit = true;
            Timer(const Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      },
      child: (Auth.instance.prefs.containsKey("selectedLocation") &&
              Auth.instance.prefs.containsKey("selectedLocationId"))
          ? Scaffold(
              backgroundColor: const Color(0xFFFFF1F1),
              // appBar: AppBar(
              //   // centerTitle: _pageIndex == 0 ? true : false,
              //   elevation: 0,
              //   centerTitle: true,
              //   title: const Text(
              //     "GLAMCODE",
              //     // _titles[_pageIndex],
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              //   backgroundColor: Colors.white,
              //   actions: [
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) =>
              //                     const NotificationScreen()));
              //       },
              //       child: const Padding(
              //         padding: EdgeInsets.only(right: 10),
              //         child: Icon(
              //           Icons.notifications_active_sharp,
              //           color: Colors.black,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              key: _scaffoldKey,
              bottomNavigationBar: ResponsiveHelper.isDesktop(context)
                  ? const SizedBox()
                  : BottomNavigationBar(
                      items: bottomNavbarList,
                      onTap: _setPage,
                      currentIndex: _pageIndex,
                      showUnselectedLabels: true,
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: const Color(0xFF882EDF),
                    ),
              drawer: const CustomDrawer(),
              body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: _screens,
              ),
            )
          : const SelectLocationScreen(),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  Widget trackView(BuildContext context, {required bool status}) {
    return Container(
        height: 3,
        decoration: BoxDecoration(
            color: status
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT)));
  }
}
