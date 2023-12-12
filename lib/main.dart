// ignore_for_file: depend_on_referenced_packages
import 'dart:ui';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/repository/cart_data_repository.dart';
import 'package:glamcode/data/repository/coupon_repository.dart';
import 'package:glamcode/data/repository/shopping_repository.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'app.dart';
import 'blocs/bloc_observer.dart';
import 'data/model/auth.dart';
import 'data/repository/user_repository.dart';

Uuid uuid = const Uuid();
FacebookAppEvents facebookAppEvents = FacebookAppEvents();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print('Handling a background message ${message.messageId}');
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  Bloc.observer = SimpleBlocObserver();
  Auth auth = Auth.instance;
  DioClient dioClient = DioClient.instance;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UserRepository userRepository =
      UserRepository(auth: auth, dioClient: dioClient);
  ShoppingRepository shoppingRepository = ShoppingRepository(
      auth: auth, dioClient: dioClient, sharedPreferences: prefs);
  CouponRepository couponRepository = CouponRepository.instance;

  CartDataRepository cartDataRepository = CartDataRepository(
      auth: auth,
      dioClient: dioClient,
      // cartDataBloc: cartDataBloc,
      shoppingRepository: shoppingRepository,
      couponRepository: couponRepository);
  // CartDataBloc cartDataBloc = CartDataBloc(cartDataRepository);

  runApp(
    MyApp(
      userRepository: userRepository,
      auth: auth,
      dioClient: dioClient,
      shoppingRepository: shoppingRepository,
      cartDataRepository: cartDataRepository,
    ),
  );
}
//   ./keytool -genkey -v -keystore .\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description,
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
