import 'dart:convert';

import 'package:glamcode/data/model/addon_model/addon_datum.dart';
import 'package:glamcode/data/model/packages_model/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_helper.dart';
import '../model/auth.dart';

class ShoppingRepository {
  Auth auth = Auth.instance;
  DioClient dioClient = DioClient.instance;
  SharedPreferences sharedPreferences;

  ShoppingRepository(
      {required this.auth,
      required this.dioClient,
      required this.sharedPreferences});

  Future<Map<ServicePackage, int>> loadCartItems() async {
    Map<ServicePackage, int> cart = {};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("cart")) {
        cart = cartDecode(prefs.getString("cart") ?? "{}");
      } else {
        cart = {};
        prefs.setString("cart", cartEncode(cart));
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return cart;
  }

  Future<void> addItemToCart(ServicePackage servicePackage) async {
    Map<ServicePackage, int> cart = {};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("cart")) {
        cart = cartDecode(prefs.getString("cart") ?? "{}");
        final mapCartCopy = Map<ServicePackage, int>.from(
            Map<ServicePackage, int>.unmodifiable(cart));
        if (cart.containsKey(servicePackage)) {
          mapCartCopy[servicePackage] = (cart[servicePackage] ?? 0) + 1;
        } else {
          mapCartCopy[servicePackage] = 1;
        }
        cart = mapCartCopy;
        prefs.setString("cart", cartEncode(cart));
      } else {
        cart = {};
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> removeItemFromCart(ServicePackage servicePackage) async {
    Map<ServicePackage, int> cart = {};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("cart")) {
        cart = cartDecode(prefs.getString("cart") ?? "{}");
        if (cart.containsKey(servicePackage) && cart[servicePackage]! > 1) {
          cart[servicePackage] = (cart[servicePackage] ?? 1) - 1;
        } else if (cart.containsKey(servicePackage) &&
            cart[servicePackage]! == 1) {
          cart.remove(servicePackage);
        }
        prefs.setString("cart", cartEncode(cart));
      } else {
        cart = {};
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> clearCart() async {
    Map<ServicePackage, int> cart = {};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("cart", cartEncode(cart));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<AddonDatum>> clearSharePrefs() async {
    List<AddonDatum> addonList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList("addons", addonListEncode(addonList));
    } catch (e) {
      print(e);
      rethrow;
    }
    return addonList;
  }

  Future<List<AddonDatum>> loadAddonItems() async {
    List<AddonDatum> addonList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("addons")) {
        prefs.setStringList("addons", addonListEncode(addonList));
        List<String> addonStringList = prefs.getStringList("addons") ?? [];
        addonList = addonListDecode(addonStringList);
      } else {
        prefs.setStringList("addons", addonListEncode(addonList));
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return addonList;
  }

  Future<void> addAddonToCart(AddonDatum? addonDatum) async {
    List<AddonDatum> addonList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (addonDatum != null) {
        if (prefs.containsKey("addons")) {
          prefs.setStringList("addons", addonListEncode(addonList));
          addonList = addonListDecode(prefs.getStringList("addons") ?? []);
          if (addonList.contains(addonDatum) == false) {
            addonList.add(addonDatum);
          }
          prefs.setStringList("addons", addonListEncode(addonList));
        } else {
          addonList = [];
        }
      } else {
        prefs.setStringList("addons", []);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> removeAddonFromCart(AddonDatum addonDatum) async {
    List<AddonDatum> addonList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("addons")) {
        addonList = addonListDecode(prefs.getStringList("addons") ?? []);
        if (addonList.contains(addonDatum)) {
          addonList.remove(addonDatum);
        }
        prefs.setStringList("addons", addonListEncode(addonList));
      } else {
        addonList = [];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  num getTotalPrice() {
    Map<ServicePackage, int> cart = {};
    num total = 0;
    try {
      if (sharedPreferences.containsKey("cart")) {
        cart = cartDecode(sharedPreferences.getString("cart") ?? "{}");
        cart.forEach((key, value) {
          total += key.discountedPrice! * value;
        });
      } else {
        cart = {};
        sharedPreferences.setString("cart", cartEncode(cart));
      }
    } catch (e) {
      print(e);
      rethrow;
    }

    List<AddonDatum> addonList = [];
    try {
      if (sharedPreferences.containsKey("addons")) {
        List<String> addonStringList =
            sharedPreferences.getStringList("addons") ?? [];
        addonList = addonListDecode(addonStringList);
        for (var element in addonList) {
          total += num.parse(element.price ?? "0");
        }
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return total;
  }

  num getTotalDiscount() {
    Map<ServicePackage, int> cart = {};
    num total = 0;
    try {
      if (sharedPreferences.containsKey("cart")) {
        cart = cartDecode(sharedPreferences.getString("cart") ?? "{}");
        cart.forEach((key, value) {
          total += key.discountedPrice! * value;
        });
      } else {
        cart = {};
        sharedPreferences.setString("cart", cartEncode(cart));
      }
    } catch (e) {
      print(e);
      rethrow;
    }

    List<AddonDatum> addonList = [];
    try {
      if (sharedPreferences.containsKey("addons")) {
        List<String> addonStringList =
            sharedPreferences.getStringList("addons") ?? [];
        addonList = addonListDecode(addonStringList);
        for (var element in addonList) {
          total += num.parse(element.price ?? "0");
        }
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return total;
  }
}

String cartEncode(Map<ServicePackage, int> cart) {
  Map<String, dynamic> res = {};
  cart.forEach((key, value) {
    res[jsonEncode(key.toMap())] = value;
  });
  return jsonEncode(res);
}

Map<ServicePackage, int> cartDecode(String cart) {
  Map<String, dynamic> mp = jsonDecode(cart);
  Map<ServicePackage, int> res = {};
  mp.forEach((key, value) {
    res[ServicePackage.fromMap(jsonDecode(key))] = value as int;
  });
  return res;
}

List<String> addonListEncode(List<AddonDatum> addonList) {
  List<String> addonStringList = [];
  for (var element in addonList) {
    try {
      addonStringList.add(element.toJson());
    } catch (e) {
      print(e);
    }
  }
  return addonStringList;
}

List<AddonDatum> addonListDecode(List<String> addonStringList) {
  List<AddonDatum> addonList = [];
  for (var element in addonStringList) {
    try {
      addonList.add(AddonDatum.fromJson(element));
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  return addonList;
}
