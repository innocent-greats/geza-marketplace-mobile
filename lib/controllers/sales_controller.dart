import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/controllers/auth.dart';
import 'package:nft_market_place/controllers/file_service_controller.dart';
import 'package:nft_market_place/controllers/local_storage.dart';
import 'package:nft_market_place/controllers/main_controller.dart';
import 'package:nft_market_place/controllers/rest_api_service_controller.dart';
import 'package:nft_market_place/controllers/socket_service_controller.dart';
import 'package:nft_market_place/models/http_responses.dart';
import 'package:nft_market_place/models/offerItem.dart';
import 'package:nft_market_place/models/order.dart';
import 'package:nft_market_place/models/person.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:nft_market_place/pages/bottom_bar.dart';

class SalesController extends MainController {
  final authController = Get.find<AuthController>();
  final restApiServiceController = Get.find<RestApiServiceController>();
  final socketServiceController = Get.find<SocketServiceController>();
  final fileServiceController = Get.find<FileServiceController>();
  var accountOfferItemList = <OfferItem>[].obs;
  var selectedAccountOfferItem =
      OfferItem(itemName: '', itemCategory: '', minimumPrice: '').obs;
  int get totalAccountOfferItemList => accountOfferItemList.length;

  var selectedWarehouse = 'Umoja-Warehouse'.obs;
  var selectedWarehouseID = ''.obs;
  var serverUrl = ''.obs;

  List<String> offerCategories = [
    'hair_style',
    'skin_&_nail_care_service',
    'retail_store_product'
  ];

  var selectedOfferCategory = 'hair_style'.obs;
  @override
  void onInit() async {
    initializeDateFormatting(Intl.defaultLocale);
    serverErrors.value = false;

    super.onInit();
    errorMessage.value = '';

    debugPrint('isLoggedIn.value == false');
    // await getAccountOfferItems();
  }

  void onSelectedOfferCategory(String category) {
    debugPrint('onSelectedBeautyParlourType $category');
    selectedOfferCategory.value = category;
    debugPrint('Selected Specialty $selectedOfferCategory');
  }

  void onSelectedWarehouse(Person account) {
    debugPrint('onSelectedWarehouse $account');
    selectedWarehouse.value = account.firstName;
    selectedWarehouseID.value = account.userID!;
    selectedWarehouseID.refresh();
    debugPrint('Selected bookin ${selectedWarehouseID.value}');
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
    Get.to(const BottomBar());
  }

  Future<void> getAccountOfferItems() async {
    try {
      debugPrint('getAccountOfferItems Method');
      isLoading.value = true;
      var body = {
        "providerID": authController.person.value.userID,
      };
      debugPrint('getAccountOfferItems body $body');
      Response<dynamic> response = await restApiServiceController.getConnect
          .post(
              'http://10.0.2.2:4001/offer-items/get-account-offer-items', body);
      debugPrint('getAccountOfferItems response $response');
      if (response.body == null) {
        errorMessage.value = 'No connection, Check internet connection';
      } else {
        ResponseBody responseBody = await processHttpResponse(response);
        debugPrint('getAccountOfferItems responseBody $responseBody');
        debugPrint(
            'getAccountOfferItems responseBody status ${responseBody.status}');
        isLoading.value = false;

        if (responseBody.status == 500) {
          // errorMessage.value = responseBody.errorMessage!.capitalizeFirst!;
        } else {
          List data = convert.jsonDecode(responseBody.data);
          debugPrint('jsonDecoded data $data');
          // var jSonData = convert.jsonDecode(data);
          debugPrint('jSonData  ${data[0]['itemID']}');

          if (data.isNotEmpty) {
            for (var item in data) {
              debugPrint('getAccountOfferItems  $item');
              OfferItem offerItem = OfferItem.fromJson(item);
              accountOfferItemList.value = [...accountOfferItemList, offerItem];
              accountOfferItemList.refresh();
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

  createNewOfferItem(
    String name,
    String minimumPrice,
    String itemDescription,
  ) async {
    try {
      debugPrint('create-new-offer-item method called');
      isLoading.value = true;
      var body = {
        "authToken": '${await LocalStorage.getAuthToken()}',
        "itemName": name,
        "price": minimumPrice,
        "itemCategory": selectedOfferCategory.value,
        "quantity": "0",
        "offeringStatus": "new-item",
        "description": itemDescription,
        "trendingStatus": 'false',
        "publishStatus": 'unproved',
      };
      debugPrint('onAddNewItem body $body');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${restApiServiceController.apiUrl}/offer-items/create-new-offer-item'),
      );
      for (XFile file in fileServiceController.xImageFiles) {
        debugPrint('file.path.toString()  ${file.path.toString()}');

        List<int> imgBytes = File(file.path.toString()).readAsBytesSync();
        debugPrint('pickedXFile  $imgBytes');
        final multipartFile = http.MultipartFile.fromBytes('file', imgBytes,
            contentType: MediaType('image', 'jpeg'),
            filename: file.path.toString());
        request.files.add(multipartFile);
      }
      // debugPrint('multipartFile  ${request.files}');

      request.fields['owner'] = authController.person.value.userID.toString();
      request.fields['offer-item'] = jsonEncode(body);
      debugPrint('request.fields  ${request.fields}');

      request.headers.addAll(
          {"Content-Type": "multipart/form-data", 'cookie': jsonEncode(body)});

      final responseStream = await request.send();

      final response = await http.Response.fromStream(responseStream);

      var decodedResponse = jsonDecode(response.body);
      debugPrint('decodedResponse  $decodedResponse');

      var jSonData = jsonDecode(decodedResponse['data']);
      debugPrint('jSonData  $jSonData');

      OfferItem decodeOfferItem = OfferItem.fromJson(jSonData);
      debugPrint('decodeOfferItem  $decodeOfferItem');

      var decodeOfferItemExist = accountOfferItemList
          .firstWhereOrNull((offer) => offer.itemID == decodeOfferItem.itemID);
      debugPrint('newOfferItem  $decodeOfferItemExist');

      if (decodeOfferItemExist != null) {
        debugPrint('newOfferItem != null');
        accountOfferItemList[accountOfferItemList.indexWhere(
                (offer) => offer.itemID == decodeOfferItem.itemID)] =
            decodeOfferItem;
      } else {
        debugPrint('newOfferItem == null');
        accountOfferItemList.value = [...accountOfferItemList, decodeOfferItem];
      }
      debugPrint('decodeOfferItem  ${accountOfferItemList.length}');

      isLoading.value = false;
      fileServiceController.isSavingSuccess.value = true;
      Timer(const Duration(seconds: 1), () {
        fileServiceController.isSavingSuccess.value = false;
        Get.to(const BottomBar());
      });
      isLoading.value = false;

      // Do something with c:\src\flutter-projects\umoja\main-ui\app\lib\pages\buyer\account_commodities_home.dartthe response
    } catch (err) {
      // Handle errors
      isLoading.value = false;

      print(err);
    }
  }
}
