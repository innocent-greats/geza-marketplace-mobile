import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/controllers/sales_controller.dart';
import 'package:nft_market_place/models/order.dart';
import 'package:nft_market_place/models/person.dart';
import 'package:nft_market_place/models/wallet.dart';
import 'package:nft_market_place/controllers/auth.dart';
import 'package:nft_market_place/pages/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _loggedInUserKey = "user";
  static SharedPreferences? _preferencesInstance;

  static SharedPreferences get preferences {
    if (_preferencesInstance == null) {
      throw ("Call LocalStorage.init() to initialize local storage");
    }
    return _preferencesInstance!;
  }

  static Future<void> init() async {
    _preferencesInstance = await SharedPreferences.getInstance();
    await initData();
  }

  static Future<void> initData() async {
    File? inMemoryProfileImage;
    final authController = Get.find<AuthController>();
    final salesController = Get.find<SalesController>();

    debugPrint(
        'SharedPreferences initData isLoggedIn ${authController.isLoggedIn.value} ');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var authUser = await getAuthUser();
    var authToken = await getAuthToken();
    var profile = await getProfileImageBytes();
    if (profile != null) {
      inMemoryProfileImage =
          File(jsonDecode(await getProfileImageBytes() as String));
    }

    if (authUser != null) {
      debugPrint("authUser != null");
      authController.person.value = authUser;
      authController.person.value.inMemoryProfileImage = inMemoryProfileImage;
      authController.authToken.value = authToken ?? authToken!;
      authController.isLoggedIn.value =
          preferences.getBool(_loggedInUserKey) ?? false;
      authController.person.refresh();
      if (authUser.firstName != '' && authUser.accountType != '') {
        debugPrint('authUser.accountType==== ${authUser.accountType}');
        if (authUser.accountType == 'vendor') {
          debugPrint('Logged rauthUser.accountType ${authUser.accountType}');
          Get.to(const BottomBar());
          await salesController.getAccountOfferItems();
        }
        if (authUser.accountType == 'client') {
          debugPrint('logged authUser.accountType ${authUser.accountType}');
          Get.to(const BottomBar());
        }
      }
    } else {
      debugPrint('No Stored User');
      // authController.onHandleLogout();
    }
  }

  static Future<bool?> setAccountOrders(String orders) async {
    return preferences.setString('accountOrders', orders);
  }

  static Future<bool?> setCurrentSelectedOrder(String order) async {
    return preferences.setString('currentSelectedOrder', order);
  }

  static Future<Order?> getCurrentSelectedOrder() async {
    var storedData = preferences.getString("currentSelectedOrder");
    debugPrint('storedData $storedData');
    if (storedData != null) {
      final rawJson = preferences.getString("currentSelectedOrder");
      Map<String, dynamic> map = jsonDecode(rawJson!);
      Order order = Order.fromJson(map);
      return order;
    } else {
      return null;
    }
  }

  static Future<List<Order>?> getOrders() async {
    var storedData = preferences.getString("accountOrders");
    if (storedData != null) {
      List<Order> orders = jsonDecode(storedData);
      return orders;
    } else {
      return null;
    }
  }

  static Future<bool> setLoggedInUser(bool loggedIn) async {
    return preferences.setBool(_loggedInUserKey, loggedIn);
  }

  static Future<bool> setLoggedInUserData(String loggedInUser) async {
    debugPrint('setLoggedInUser $loggedInUser');

    preferences.setString("authUser", loggedInUser.toString());
    await preferences.setBool('isLoggedIn', true);
    return preferences.setBool(_loggedInUserKey, true);
  }

  static Future<bool> setLoggedInUserToken(String token) async {
    return preferences.setString("authToken", token);
  }

  static Future<String?> getAuthToken() async {
    var storedData = preferences.getString("authToken");
    if (storedData != null) {
      return storedData;
    } else {
      return null;
    }
  }

  static Future<Person?> getAuthUser() async {
    final rawJson = preferences.getString("authUser");
    if (rawJson != null) {
      Map<String, dynamic> map = jsonDecode(rawJson);
      final user = Person.fromJson(map);
      return user;
    }
    return null;
  }

  static Future<bool> setAuthenticatedUser(Person user) {
    return preferences.setString("authUser", user.toString());
  }

  static Future<bool> setProfileImageBytes(String imageBytes) async {
    debugPrint('setLoggedInUser $imageBytes');
    preferences.remove("profileImageBytes");
    return preferences.setString("profileImageBytes", imageBytes);
  }

  static Future<String?> getProfileImageBytes() async {
    var storedData = preferences.getString("profileImageBytes");
    if (storedData != null) {
      return storedData.toString();
    } else {
      return null;
    }
  }

  static Future<bool> setLoggedInUserWalletData(
      String loggedInUserWalletData) async {
    debugPrint('setLoggedInUserWalletData $loggedInUserWalletData');
    return preferences.setString(
        "loggedInUserWalletData", loggedInUserWalletData.toString());
  }

  static Future<Wallet?> getLoggedInUserWalletData() async {
    final rawJson = preferences.getString("loggedInUserWalletData");
    if (rawJson != null) {
      Map<String, dynamic> map = jsonDecode(rawJson);
      final wallet = Wallet.fromJson(map);
      return wallet;
    }
    return null;
  }

  static Future<bool> removeLoggedInUser() async {
    await preferences.remove("authUser");
    await preferences.remove("authToken");
    await preferences.remove(_loggedInUserKey);
    var cleared = await preferences.clear();
    debugPrint('App Storage Cleared $cleared');

    return cleared;
  }

  static Future<bool> removeUserToken() async {
    return preferences.remove("authToken");
  }

  Future<void> resetStorage() async {
    await preferences.clear();
  }

  static readSelectedOrder() {
    debugPrint('readSelectedOrder from Storage');

    final order = jsonDecode(preferences.getString('selectedOrder') as String);
    if (order != null) {
      var oderID = order.id;
      debugPrint('readSelectedOrder $oderID');
      return order;
    } else {
      return null;
    }
  }
}
