import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/controllers/auth.dart';
import 'package:nft_market_place/controllers/file_service_controller.dart';
import 'package:nft_market_place/controllers/main_controller.dart';
import 'package:nft_market_place/controllers/rest_api_service_controller.dart';
import 'package:nft_market_place/controllers/sales_controller.dart';
import 'package:nft_market_place/controllers/socket_service_controller.dart';
import 'package:nft_market_place/models/http_responses.dart';
import 'package:nft_market_place/models/offerItem.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nft_market_place/models/person.dart';

import 'dart:convert' as convert;

import '../models/provider.dart';

class MarketplaceController extends MainController {
  final mainController = Get.find<MainController>();
  final authController = Get.find<AuthController>();
  final restApiServiceController = Get.find<RestApiServiceController>();
  final socketServiceController = Get.find<SocketServiceController>();
  final fileServiceController = Get.find<FileServiceController>();
  final salesController = Get.find<SalesController>();

  var offerItemList = <OfferItem>[].obs;
  int get totalOfferItemList => offerItemList.length;
  var selectedOfferItem =
      OfferItem(itemName: '', itemCategory: '', minimumPrice: '').obs;
  var selectedOfferItemImagePath = ''.obs;
  var topProviders = <Provider>[].obs;

  var selectedProvider = Provider(
      provider: Person(firstName: 'firstName', lastName: 'lastName'),
      offerItems: <OfferItem>[]).obs;
  int get totalTopProvider => topProviders.length;
  @override
  void onInit() async {
    super.onInit();
    errorMessage.value = '';
    await getOfferItems();
    await getProviders();
    debugPrint('MarketplaceController offerItemList, ${offerItemList.length}');
  }

  void onChangeImage(image) {
    selectedOfferItemImagePath.value = image;
  }

  Future<void> getProviders() async {
    try {
      debugPrint('getProviders() from ${mainController.apiUrl}');
      isLoading.value = true;
      var body = {
        "providerID": authController.person.value.userID,
      };
      // debugPrint('getAccountOfferItems body $body');
      Response<dynamic> response = await restApiServiceController.getConnect
          .post(
              '${mainController.apiUrl}/offer-items/get-marketplace-providers',
              body);
      debugPrint('getProviders() response $response');
      if (response.body == null) {
        errorMessage.value = 'No connection, Check internet connection';
      } else {
        ResponseBody responseBody = await processHttpResponse(response);
        List jsonDecodedHttpResponseBody = await jsonDecode(responseBody.data);
        if (jsonDecodedHttpResponseBody.isNotEmpty) {
          debugPrint('getProviders() is Not Empty');
          for (var req in jsonDecodedHttpResponseBody) {
            // debugPrint('jsonDecodedHttpResponseBody req $req');
            Provider user = Provider.fromJson(jsonEncode(req));

            var providerLoaded = topProviders.firstWhereOrNull(
                (vendr) => vendr.provider.userID == user.provider.userID);
            if (providerLoaded != null) {
              topProviders[topProviders.indexWhere((vendr) =>
                  vendr.provider.userID == user.provider.userID)] = user;
            } else {
              topProviders.value = [...topProviders, user];
            }
          }
          debugPrint('topProviders.length ${topProviders.length}');
        }
      }

      isLoading.value = false;
    } catch (e) {
      isLoading(false);
      formErrors.value = true;
      formErrorMessage.value = 'Error: ${e.toString()}';
      debugPrint(e.toString());
    }
  }

  Future<void> getOfferItems() async {
    try {
      debugPrint('getOfferItems from ${mainController.apiUrl}');
      isLoading.value = true;
      var body = {
        "providerID": authController.person.value.userID,
      };
      // debugPrint('getAccountOfferItems body $body');
      Response<dynamic> response = await restApiServiceController.getConnect
          .post(
              '${mainController.apiUrl}/offer-items/get-marketplace-offer-items',
              body);
      // debugPrint('getAccountOfferItems response $response');
      if (response.body == null) {
        errorMessage.value = 'No connection, Check internet connection';
      } else {
        ResponseBody responseBody = await processHttpResponse(response);
        // debugPrint('getAccountOfferItems responseBody $responseBody');
        // debugPrint(
        //     'getAccountOfferItems responseBody status ${responseBody.status}');
        isLoading.value = false;

        if (responseBody.status == 500) {
          // errorMessage.value = responseBody.errorMessage!.capitalizeFirst!;
        } else {
          List data = convert.jsonDecode(responseBody.data);
          // debugPrint('jsonDecoded data $data');
          // var jSonData = convert.jsonDecode(data);
          // debugPrint('jSonData  ${data[0]['itemID']}');

          if (data.isNotEmpty) {
            for (var item in data) {
              // debugPrint('getAccountOfferItems  $item');
              OfferItem offerItem = OfferItem.fromJson(item);
              offerItemList.value = [...offerItemList, offerItem];
              offerItemList.refresh();
            }
          }
        }
      }

      isLoading.value = false;
    } catch (e) {
      isLoading(false);
      formErrors.value = true;
      formErrorMessage.value = 'Error: ${e.toString()}';
      debugPrint(e.toString());
    }
  }

  void requestBookingToProvider() {
    debugPrint('requestBookingToprovider');
    var ordr = {
      "providerID": selectedProvider.value.provider.userID.toString(),
      "orderStatus": 'client-request',
      "budgettedAmount": budgettedAmount.value,
      "orderDate": bookingDate.value,
      "customer": authController.person.value,
      "offerItem": {
        "itemName": '',
        "itemCategory": selectedItemCategory.value,
      }
    };
    socketServiceController.socket.emit('place-order', {
      "bookingType": bookingType.value,
      "clientID": authController.person.value.userID.toString(),
      "clientPhone": authController.person.value.phone.toString(),
      "providerPhone": selectedProvider.value.provider.phone.toString(),
      "providerID": selectedProvider.value.provider.userID.toString(),
      "order": jsonEncode(ordr),
    });
  }
}
