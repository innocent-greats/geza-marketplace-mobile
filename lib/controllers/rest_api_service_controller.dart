import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/controllers/main_controller.dart';
import 'package:nft_market_place/models/http_responses.dart';
import 'package:nft_market_place/models/provider.dart';

class RestApiServiceController extends MainController {
  final getConnect = GetConnect(timeout: const Duration(seconds: 30));
  var isLoadingServerConnection = false.obs;
  var isRestServerConnected = false.obs;
  late String apiUrl;
  var isServerLive = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await dotenv.load();
    debugPrint(dotenv.get("ENV"));

    String serverUrl = dotenv.get("ENV") == 'emulator'
        ? dotenv.get("EMMULATOR_API_URL")
        : dotenv.get("ENV") == 'device'
            ? dotenv.get("DEVICE_API_URL")
            : dotenv.get("PRODUCTION_API_URL");
    apiUrl = serverUrl;
    await _callAPiServer();
  }

  _callAPiServer() async {
    try {
      debugPrint('calling http server.');

      isLoadingServerConnection.value = true;
      Map body = {"data": 'testing server'};
      var res = await getConnect.post('$apiUrl/postConnection', body);
      if (res.statusCode == 201) {
        isLoading.value = false;
        isServerLive.value = true;
        isRestServerConnected.value = true;
        isServerLive.refresh();
        isRestServerConnected.refresh();
      } else {
        isRestServerConnected.value = false;
        isServerLive.value = false;

        debugPrint(
            '_callAPiServer Request failed with status: ${res.statusCode}.');
      }

      update();
      isLoadingServerConnection.value = false;
    } on Exception catch (e) {
      isLoadingServerConnection.value = false;
      isServerLive.value = false;
      serverErrors.value = true;
      serverErrorMessage.value = 'No connection to server';
      debugPrint("Server Exception:  $e");
      update();
    }
  }

  getOfferItemsNamesByCategory(String category) async {
    try {
      Map body = {"category": category};
      debugPrint('getOfferItemsNamesByCategory apiUrl: $apiUrl');

      var response = await getConnect.post(
          '$apiUrl/offer-items/get-offer-items-names-by-category', body);
      debugPrint('getConnect http jsonResponse: $response');
      if (response.body == null) {
        errorMessage.value = 'No connection, Check internet connection';
        isLoading.value = false;
      } else {
        ResponseBody responseBody = await processHttpResponse(response);

        if (responseBody.status == 200) {
          List jsonDecodedofferItemsNamesByCategories =
              await jsonDecode(responseBody.data);
          offerItemsNamesByCategories.value =
              jsonDecodedofferItemsNamesByCategories;
          offerItemsNamesByCategories.refresh();
        } else {
          debugPrint(
              'getOfferItemsNamesByCategory getConnect status: ${response.statusCode}.');
        }

        update();
      }
    } on Exception catch (e) {
      errorMessage.value = '$e';
      debugPrint("Server Exception:  $e");
      update();
    }
  }

  searchForServiceProvider(String text) async {
    try {
      debugPrint('searchForServiceProvider');
      isLoading.value = true;
      Map body = {"text": text};
      var response = await getConnect.post(
          '$apiUrl/offer-items/search-for-stylists', body);
      // debugPrint('searchForStylist res: $response');
      if (response.body == null) {
        errorMessage.value = 'No connection, Check internet connection';
        isLoading.value = false;
      } else {
        ResponseBody responseBody = await processHttpResponse(response);

        if (responseBody.status == 200) {
          debugPrint(
              'searchForStylist responseBody.status == 200 ${responseBody.data} ');
          List jsonDecodedServiceProvider = await jsonDecode(responseBody.data);
          // debugPrint('searchForStylist jsonDecode $jsonDecodedServiceProvider');
          debugPrint(
              'jsonDecodedServiceProvider  ${jsonDecodedServiceProvider}');
          var searchResults = <Provider>[];
          if (jsonDecodedServiceProvider.isNotEmpty) {
            debugPrint('searchForStylist is Not Empty');
            for (var req in jsonDecodedServiceProvider) {
              Provider user = Provider.fromJson(req);
              debugPrint('provider userID ${user.provider.userID}');

              var providerLoaded = searchResults.firstWhereOrNull(
                  (vendr) => vendr.provider.userID == user.provider.userID);
              if (providerLoaded != null) {
                searchResults[searchResults.indexWhere((vendr) =>
                    vendr.provider.userID == user.provider.userID)] = user;
              } else {
                searchResults = [...searchResults, user];
              }
              queriedProviders.value = searchResults;
              queriedProviders.refresh();
              debugPrint('providers length ${queriedProviders.length}');
            }
          } else {
            queriedProviders.value = searchResults;
            queriedProviders.refresh();
            debugPrint('searchForStylist is empty');
          }
        }
        isLoading.value = false;
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  requestGrading(String trade) async {
    try {
      await getTradeProviders(trade);
      Get.toNamed('/requestGrading');
    } catch (e) {}
  }

  getTradeProviders(String trade) async {
    try {
      debugPrint('getTradeProviders trade $trade');
      isLoading.value = true;
      Map body = {"tradingAs": trade};
      if (trade == 'warehouse') {
        if (providers.isEmpty) {
          Get.put(MainController()).warehouseProviders.value =
              (await processRequest(body))!;
          Get.put(MainController()).warehouseProviders.refresh();
        }
        debugPrint('warehouseProviders length ${warehouseProviders.length}');
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<List<Provider>?> processRequest(Map body) async {
    try {
      var response = await getConnect.post(
          '$apiUrl/offer-items/get-trade-providers', body);
      if (response.body == null) {
        errorMessage.value = 'No connection, Check internet connection';
        isLoading.value = false;
        return null;
      } else {
        ResponseBody responseBody = await processHttpResponse(response);
        if (responseBody.status == 200) {
          List jsonDecodedHttpResponseBody =
              await jsonDecode(responseBody.data);
          // debugPrint('searchForStylist jsonDecode $jsonDecodedHttpResponseBody');
          debugPrint(
              'jsonDecodedHttpResponseBody  $jsonDecodedHttpResponseBody');
          var searchResults = <Provider>[];
          if (jsonDecodedHttpResponseBody.isNotEmpty) {
            debugPrint('getWarehouseHttpResponses is Not Empty');
            for (var req in jsonDecodedHttpResponseBody) {
              // debugPrint('jsonDecodedHttpResponseBody req $req');
              Provider user = Provider.fromJson(jsonEncode(req));
              debugPrint(
                  'processRequest provider userID ${user.provider.userID}');
              var providerLoaded = searchResults.firstWhereOrNull(
                  (vendr) => vendr.provider.userID == user.provider.userID);
              if (providerLoaded != null) {
                searchResults[searchResults.indexWhere((vendr) =>
                    vendr.provider.userID == user.provider.userID)] = user;
              } else {
                searchResults = [...searchResults, user];
              }
            }
          }
          debugPrint('processRequest searchResults ${searchResults.length}');
          return searchResults;
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
