import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/controllers/auth.dart';
import 'package:nft_market_place/controllers/local_storage.dart';
import 'package:nft_market_place/controllers/main_controller.dart';
import 'package:nft_market_place/models/order.dart';
import 'package:nft_market_place/models/provider.dart';
import 'package:nft_market_place/models/wallet.dart';

import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

class SocketServiceController extends MainController {
  final authController = Get.find<AuthController>();

  late IO.Socket socket;

  // String apiUrl = 'https://$endpointProd';
  late String apiUrl;

  var isSocketConnected = false.obs;
  var newSocketNotification = false.obs;
  var socketID = ''.obs;

  @override
  void onInit() async {
    initializeDateFormatting(Intl.defaultLocale);
    await LocalStorage.init();
    serverErrors.value = false;
    errorMessage.value = '';
    await dotenv.load();
    debugPrint(dotenv.get("ENV"));
    apiUrl = dotenv.get("ENV") == 'emulator'
        ? dotenv.get("EMMULATOR_API_URL")
        : dotenv.get("ENV") == 'device'
            ? dotenv.get("DEVICE_API_URL")
            : dotenv.get("PRODUCTION_API_URL");
    debugPrint('B4, $apiUrl');
    update();
    debugPrint(
        "check await LocalStorage.getAuthToken(), ${await LocalStorage.getAuthToken()}");
    socket = IO.io(
        apiUrl,
        OptionBuilder()
            .setAuth({'token': await LocalStorage.getAuthToken()})
            .setQuery(
                {'cookie': 'barrs', 'token': await LocalStorage.getAuthToken()})
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    await connectAndListen();
  }

  void changeOnlineState(bool status) {
    debugPrint('before change $status ${isSocketConnected.value}');
    if (status == true) {
      debugPrint(
          'changeOnlineState status == true ${authController.person.value.userID.toString()}');
      socket.emit('notify-online-status', {
        "status": 'online',
        "senderID": authController.person.value.userID.toString(),
        "senderPhone": authController.person.value.phone.toString(),
      });
    }
    if (status == false) {
      debugPrint(
          'changeOnlineState status == true ${authController.person.value.userID.toString()}');
      socket.emit('notify-online-status', {
        "status": 'offline',
        "senderID": authController.person.value.userID.toString(),
        "senderPhone": authController.person.value.phone.toString(),
      });
    }
    isSocketConnected.value = status;
    debugPrint('after change ${isSocketConnected.value}');
  }

// WEB SOCKETS LISTENERS
  connectAndListen() async {
    // socket.connect();
    socket.onConnect((_) {
      debugPrint('socket connected? ${socket.connected}');
      debugPrint('socket id ${socket.id}');
      isSocketConnected.value = true;
      socketID.value = socket.id!;
      print('connect');
      debugPrint(
          'isLoggedIn.value == true ${authController.person.value.userID.toString()}');
      if (authController.isLoggedIn.value == true) {
        debugPrint(
            'isLoggedIn.value == true ${authController.person.value.userID.toString()}');
        socket.emit('get-account-offer-items', {
          "senderID": authController.person.value.userID.toString(),
          "senderPhone": authController.person.value.phone.toString(),
          "accountType": authController.person.value.accountType.toString()
        });
        socket.emit('get-account-orders', {
          "senderID": authController.person.value.userID.toString(),
          "senderPhone": authController.person.value.phone.toString(),
          "accountType": authController.person.value.accountType.toString()
        });
        socket.emit('get-wallet-balance', {
          "userID": authController.person.value.userID.toString(),
        });
      }
    });

    //When an event recieved from server, data is added to the stream

//
    socket.on('update-online-status', (recievedData) async {
      debugPrint("update-online-status:  $recievedData");
      var data = await jsonDecode(recievedData);
      debugPrint('update-online-status data["data"] ${data["data"]}');
      if (data["socketID"] != null) {
        isSocketConnected.value = data['data']["isOnline"];
        socketID.value = data["socketID"];
      }
    });

    socket.on('recieve-wallet-update', (recievedData) async {
      debugPrint("recieve-wallet-balance:  $recievedData");

      var jSonData = await jsonDecode(recievedData);
      debugPrint('recieve-wallet-balance data["data"] ${jSonData}');
      Wallet walletUpdate = Wallet.fromJson(jSonData['data']);
      Wallet? storedBalance = await LocalStorage.getLoggedInUserWalletData();
      if (storedBalance != null) {
        if (walletUpdate.currentBalance != storedBalance.currentBalance) {
          authController.wallet.value = walletUpdate;
          String rawJson = jsonEncode(walletUpdate.toJson());
          await LocalStorage.setLoggedInUserWalletData(rawJson);
          newSocketNotification.value = true;
        }
      } else {
        String rawJson = jsonEncode(walletUpdate.toJson());
        await LocalStorage.setLoggedInUserWalletData(rawJson);
        newSocketNotification.value = true;
      }
    });

    socket.on('order-request-accepted', (recievedData) async {
      debugPrint("order-request-accepted recievedData:  $recievedData");
      var data = await jsonDecode(recievedData);
      debugPrint('order-request-accepted $data["order"]');
      var jsonDecodeOrder = await jsonDecode(data["order"]);
      Order order = Order.fromJson(jsonDecodeOrder);
      await processOrders(order);
    });

    socket.on('receive_message', (recievedData) {
      debugPrint("Socket _socketCall recievedData:  $recievedData");

      var data = jsonDecode(recievedData);
      var msg = data['message'];
      debugPrint("$msg");
    });
    socket.on('receive-providers', (recievedData) async {
      debugPrint("Socket receive_providers recievedData:  $recievedData");
      var data = await jsonDecode(recievedData);
      List jsonDecodedproviders = await jsonDecode(data['providers']);
      debugPrint('providers jsonDecode ${jsonDecodedproviders}');
      // List jsonDecodedproviders = jsonDecodedData['data'];
      if (jsonDecodedproviders.isNotEmpty) {
        for (var req in jsonDecodedproviders) {
          Provider provider = Provider.fromJson(req);
          debugPrint("${provider.provider.userID}");
          var providerLoaded = providers.firstWhereOrNull(
              (vendr) => vendr.provider.userID == provider.provider.userID);
          if (providerLoaded != null) {
            providers[providers.indexWhere((vendr) =>
                vendr.provider.userID == provider.provider.userID)] = provider;
          } else {
            providers.value = [...providers, provider];
            providers.refresh();
          }
        }
      } else {
        debugPrint('serviceRequest is empty');
      }
    });
    socket.on('receive-account_orders', (recievedData) async {
      debugPrint("Socket ::: receive account orders");
      var data = await jsonDecode(recievedData);
      // debugPrint('order jsonDecode $data["order"]');
      if (data["orders"] != null) {
        var jsonDecodeOrders = await jsonDecode(data["orders"]);
        // debugPrint("account orders ${data["orders"]}");

        for (var ord in jsonDecodeOrders) {
          Order order = Order.fromJson(ord);
          debugPrint("order order.customer!.userID ${order.customer}");
          debugPrint("order order orderID ${order.orderID}");
          await processOrders(order);
        }
      }
    });

    socket.on('receive-order-request', (recievedData) async {
      debugPrint("__________Socket receive_order-request____________________");
      var data = await jsonDecode(recievedData);

      var jsonDecodeOrder = await jsonDecode(data["order"]);

      Order order = Order.fromJson(jsonDecodeOrder);
      debugPrint("order order orderID ${order}");
      await processOrders(order);
    });
    socket.onDisconnect((_) => print('disconnect'));
  }
}
