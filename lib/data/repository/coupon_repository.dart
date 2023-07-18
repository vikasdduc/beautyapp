import 'package:glamcode/data/model/coupons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CouponRepository {
  /// private constructor
  CouponRepository._() {
    _doneFuture = init();
  }

  late Future<CouponData> _doneFuture;

  Future<CouponData> init() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("coupon")) {
      return CouponData.fromJson(prefs.getString('coupon') ?? "");
    } else {
      return CouponData.empty;
    }
  }

  late SharedPreferences prefs;

  /// the one and only instance of this singleton
  static final instance = CouponRepository._();
  //ChatBloc chatBloc = ChatBloc(DatabaseApi.db);

  // Create a User instance. Actually it would be better if this is empty so I can notice if a user is valid or not and can react by checking if the user has values and
  // if not log the user out later on
  // User currentUser = User.empty;

  Future<CouponData> get currentCoupon => init();

  updateCurrentCouponInstance(CouponData? couponData) async {
    SharedPreferences.getInstance().then((sharedUser) {
      couponData == null
          ? clearCouponInstance()
          : sharedUser.setString("coupon", couponData.toJson());
    });
  }

  clearCouponInstance() {
    SharedPreferences.getInstance().then((sharedUser) {
      sharedUser.setString("coupon", const CouponData().toJson());
    });
  }
}
