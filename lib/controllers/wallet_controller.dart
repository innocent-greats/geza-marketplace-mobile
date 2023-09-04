import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/controllers/auth.dart';
import 'package:nft_market_place/controllers/local_storage.dart';
import 'package:nft_market_place/controllers/main_controller.dart';
import 'package:nft_market_place/controllers/rest_api_service_controller.dart';
import 'package:nft_market_place/controllers/sales_controller.dart';
import 'package:nft_market_place/controllers/socket_service_controller.dart';
import 'package:nft_market_place/models/order.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class WalletController extends MainController {
  final authController = Get.find<AuthController>();
  final restApiServiceController = Get.find<RestApiServiceController>();
  final socketServiceController = Get.find<SocketServiceController>();
  final salesController = Get.find<SalesController>();

  var isTransferringFunds = false.obs;

  @override
  void onInit() async {
    initializeDateFormatting(Intl.defaultLocale);
    serverErrors.value = false;

    super.onInit();
    errorMessage.value = '';

    debugPrint('isLoggedIn.value == false');
  }

  acceptOrder(Order order) {
    if (authController.isLoggedIn.value == true) {
      debugPrint('acceptOrder');
      socketServiceController.socket.emit('accept-order', {
        "providerID": authController.person.value.userID.toString(),
        "clientID": order.customer!.userID.toString(),
        "orderID": order.orderID.toString()
      });
    }
    debugPrint('accepted Order ${order.orderID.toString()}');
    showOrderBottomSheet.value = false;
    newServiceRequest.value = false;
    // Get.to(const FarmerAccountHomeScreen());
  }

  makeDirectTransfer(
    String receivingAccount,
    String minimumPrice,
    String itemCategory,
  ) async {
    // construct form data
    try {
      debugPrint('makeDirectTransfer method called');
      isLoading.value = true;
      var body = {
        "authToken": '${await LocalStorage.getAuthToken()}',
        "minimumPrice": minimumPrice,
        "itemCategory": itemCategory,
        "receivingAccount": receivingAccount,
        "publishStatus": 'invoked',
      };
      debugPrint('makeDirectTransfer body $body');

      isLoading.value = false;
      isTransferringFunds.value = true;
      Timer(const Duration(seconds: 1), () {
        isTransferringFunds.value = false;
        // Get.to(const WalletTransactionsHistoryScreen());
      });
      isLoading.value = false;

      // Do something with the response
    } catch (err) {
      // Handle errors
      isLoading.value = false;

      print(err);
    }
  }
}
