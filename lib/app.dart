import 'dart:convert';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:glamcode/blocs/addon/addon_bloc.dart';
import 'package:glamcode/blocs/cart/cart_bloc.dart';
import 'package:glamcode/blocs/cart_data/cart_data_bloc.dart';
import 'package:glamcode/controller/location_controller.dart';
import 'package:glamcode/data/repository/cart_data_repository.dart';
import 'package:glamcode/data/repository/shopping_repository.dart';
import 'package:glamcode/splash_screen.dart';
import 'package:glamcode/theme/light_theme.dart';
import 'package:glamcode/util/app_constants.dart';
import 'package:glamcode/view/refertoearn/invitetoearn.dart';
import 'package:glamcode/view/screens/about/about.dart';
import 'package:glamcode/view/screens/addons/addons_screen.dart';
import 'package:glamcode/view/screens/address/address_screen.dart';
import 'package:glamcode/view/screens/booking_success.dart';
import 'package:glamcode/view/screens/cart/cart_screen.dart';
import 'package:glamcode/view/screens/dashboard/dashboard_screen.dart';
import 'package:glamcode/view/screens/dashboard/wallet_screen.dart';
import 'package:glamcode/view/screens/home/home_screen.dart';
import 'package:glamcode/view/screens/location/location_screen.dart';
import 'package:glamcode/view/screens/payment/payment_screen.dart';
import 'package:glamcode/view/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:glamcode/view/screens/select_booking/select_booking_screen.dart';
import 'package:glamcode/view/screens/terms_and_conditions/terms_and_conditions_screen.dart';
import 'package:http/http.dart' as http;
import 'package:upgrader/upgrader.dart';

import 'blocs/auth/auth_bloc.dart';
import 'data/api/api_helper.dart';
import 'data/model/auth.dart';
import 'data/repository/user_repository.dart';
import 'home.dart';
import 'main.dart';
import 'util/delete_my_account.dart';

class MyApp extends StatefulWidget {
  final UserRepository userRepository;
  final ShoppingRepository shoppingRepository;
  final CartDataRepository cartDataRepository;
  final Auth auth;
  final DioClient dioClient;

  const MyApp(
      {super.key,
      required this.userRepository,
      required this.auth,
      required this.dioClient,
      required this.shoppingRepository,
      required this.cartDataRepository});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthBloc authBloc;
  late CartBloc cartBloc;
  late CartDataBloc cartDataBloc;
  late AddonBloc addonBloc;

  UserRepository get userRepository => widget.userRepository;

  ShoppingRepository get shoppingRepository => widget.shoppingRepository;

  CartDataRepository get cartDataRepository => widget.cartDataRepository;

  Auth get auth => widget.auth;

  DioClient get dioClient => widget.dioClient;

  late String token;

  getToken() async {
    token = await FirebaseMessaging.instance.getToken() ?? "";
    print(
        "-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=->$token");
  }

  @override
  void initState() {
    authBloc = AuthBloc(userRepository: userRepository, dioClient: dioClient);
    authBloc.add(AppLoaded());
    cartDataBloc = CartDataBloc(cartDataRepository);
    cartDataBloc.add(CartDataStarted());
    cartBloc = CartBloc(shoppingRepository, cartDataBloc);
    cartBloc.add(CartStarted());
    addonBloc = AddonBloc(shoppingRepository, cartDataBloc);
    addonBloc.add(AddonStarted());
    super.initState();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');
    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initialzationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid, iOS: initialzationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        final http.Response response =
            await http.get(Uri.parse(android.imageUrl ?? ""));
        BigPictureStyleInformation bigPictureStyleInformation =
            BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(
                base64Encode(response.bodyBytes)));

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  color: Colors.blue,
                  icon: "@mipmap/ic_launcher",
                  importance: Importance.high,
                  priority: Priority.high,
                  styleInformation: bigPictureStyleInformation),
            ),
            payload: android.imageUrl);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            // context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title ?? ""),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body ?? "")],
                  ),
                ),
              );
            },
            context: context);
      }
    });

    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => authBloc,
        ),
        BlocProvider(
          create: (context) => cartBloc,
        ),
        BlocProvider(
          create: (context) => cartDataBloc,
        ),
        BlocProvider(
          create: (context) => addonBloc,
        ),
        BlocProvider<LocationController>(
            create: (_) => LocationController("")..getCurrentLocation())
      ],
      child: MaterialApp(
        title: AppConstants.APP_NAME,
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
        ),
        theme: light(color: Colors.white),
/*      theme: themeController.darkTheme
          ? themeController.darkColor == null
              ? dark()
              : dark(color: themeController.darkColor ?? Colors.black54)
          : themeController.lightColor == null
              ? light()
              : light(color: themeController.lightColor ?? Colors.white),*/
        routes: {
          '/': (context) => SplashScreen(
                authBloc: authBloc,
              ),
          "/index": (context) => UpgradeAlert(child: Home(authBloc: authBloc)),
          "/dashboard": (context) => const DashboardScreen(pageIndex: 0),
          "/home": (context) => const HomeScreen(),
          "/location": (context) => const SelectLocationScreen(),
          "/terms": (context) => const TermsConditionsScreen(),
          "/about": (context) => const AboutScreen(),
          "/privacy": (context) => const PrivacyPolicyScreen(),
          "/address": (context) => const AddressDetailsScreen(),
          "/addons": (context) => const AddonsScreen(),
          "/booking-data": (context) => const SelectBookingDateScreen(),
          "/payment": (context) => const PaymentScreen(),
          "/payment-success": (context) => const BookingSuccessScreen(),
          "/wallet-screen": (context) => const WalletScreen(),
          "/my-cart": (context) => const CartScreen(),
          "/delete-my-account": (context) => const DeleteMyAccount(),
        },
      ),
    );
  }
}
