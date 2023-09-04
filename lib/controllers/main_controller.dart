import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/models/http_responses.dart';
import 'package:nft_market_place/models/offerItem.dart';
import 'package:nft_market_place/models/order.dart';
import 'package:nft_market_place/models/person.dart';
import 'package:nft_market_place/models/provider.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

var serverErrors = false.obs;
var serverErrorMessage = ''.obs;

class MainController extends GetxController {
  late String apiUrl;
  late IO.Socket socket;

  // String apiUrl = 'https://$endpointProd';

  final getConnect = GetConnect(timeout: const Duration(seconds: 30));
  var isServerLive = false.obs;
  var isLoading = false.obs;
  var isLoadingServerConnection = false.obs;
  var isonline = true.obs;
  var showSearchBox = true.obs;
  var isShowMore = false.obs;
  var showOrderBottomSheet = false.obs;
  var offerItemsNamesByCategories = [].obs;
  var selectedofferItemsNamesByCategory = ''.obs;

  String? resultMessage;
  var errorMessage = ''.obs;
  var formErrors = false.obs;
  var formErrorMessage = ''.obs;

  var newServiceRequest = false.obs;

  var currentOrderRequest = Order().obs;
  var selectedOrderRequest = Order().obs;

  var orderRequests = <Order>[].obs;
  int get totalOrderRequests => orderRequests.length;

  var selectedOrder = Order().obs;
  var orders = <Order>[].obs;
  int get totalOrders => orders.length;

  var vendors = <Person>[].obs;
  int get totalVendors => vendors.length;
  var vendor = Person(
    firstName: '',
    lastName: '',
    accountType: '',
    phone: '',
    createdDate: DateTime.now().toString(),
  ).obs;
  var offerItem =
      OfferItem(itemName: '', itemCategory: '', minimumPrice: '').obs;
  List<String> itemCategories = [
    'hair style',
    'skin & nail treatment',
    'product'
  ];
  var selectedItemCategory = 'hair style'.obs;
  var budgettedAmount = '10'.obs;
  var bookingType = 'direct'.obs;

  final now = DateTime.now();
  late BookingService mockBookingService = BookingService(
      serviceName: 'Mock Service',
      serviceDuration: 30,
      bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
      bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
  List<DateTimeRange> converted = [];
  var bookingDate = ''.obs;

//
  var queriedProviders = <Provider>[].obs;
  int get totalQueriedProviders => queriedProviders.length;

  var providers = <Provider>[].obs;
  int get totalProvider => providers.length;


  var warehouseProviders = <Provider>[].obs;
  int get totalWarehouseProviders => warehouseProviders.length;

  @override
  void onInit() async {
    initializeDateFormatting(Intl.defaultLocale);
    await dotenv.load();
    debugPrint(dotenv.get("DEVICE_API_URL"));

    String serverUrl = dotenv.get("ENV") == 'emulator'
        ? dotenv.get("EMMULATOR_API_URL")
        : dotenv.get("ENV") == 'device'
            ? dotenv.get("DEVICE_API_URL")
            : dotenv.get("PRODUCTION_API_URL");
    apiUrl = serverUrl;
    socket =
        IO.io(serverUrl, OptionBuilder().setTransports(['websocket']).build());
    super.onInit();
  }





  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    bookingDate.value = newBooking.toJson().toString();
    print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    DateTime tomorrow = now.add(Duration(days: 1));
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 50))));

    //book whole day example
    converted.add(DateTimeRange(
        start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
        end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

  void showViewOrderState(bool status) {
    debugPrint(
        'showViewOrderState before change ${showOrderBottomSheet.value}');

    showOrderBottomSheet.value = status;
    debugPrint('showViewOrderState after change ${showOrderBottomSheet.value}');
  }

  void showViewOrderMore(bool status) {
    debugPrint('showViewOrderState before change ${isShowMore.value}');
    isShowMore.value = status;
    debugPrint('showViewOrderState after change ${isShowMore.value}');
  }

  void showSearchBar(bool status) {
    debugPrint('before change ${isonline.value}');
    showSearchBox.value = status;
    debugPrint('after change ${isonline.value}');
  }

  void onSelectItemCategory(String query) {
    debugPrint('onSelectItemCategory $query');
    selectedItemCategory.value = query;
    debugPrint('onSelectItemCategory ${selectedItemCategory.value}');
  }

  void onSelectedOffer(String query) {
    debugPrint('onSelectedOffer $query');
    selectedofferItemsNamesByCategory.value = query;
    debugPrint(
        'Selected selectedCity ${selectedofferItemsNamesByCategory.value}');
  }

  processOrders(Order order) async {
    bool foundInOrders =
        orders.contains((Order ord) => ord.orderID == order.orderID);

    debugPrint("order $foundInOrders");
    if (foundInOrders) {
      debugPrint("orderID != null");
      orders[orders.indexWhere((ord) => ord.orderID == order.orderID)] = order;
      orders.refresh();
    } else {
      debugPrint("orderID == null");
      // orders.clear();
      orders.value = [...orders, order];
      orders.refresh();
    }

    if (order.orderStatus == 'request' ||
        order.orderStatus == 'client-request' ||
        order.orderStatus == 'vendor-accepted') {
      bool foundInOrderRequest =
          orderRequests.contains((ord) => ord.orderID == order.orderID);
      debugPrint("order orderRequestLoaded $foundInOrderRequest");
      if (foundInOrderRequest) {
        debugPrint("orderRequestLoaded.orderID != null");
        orderRequests[orderRequests
            .indexWhere((ord) => ord.orderID == order.orderID)] = order;
        orderRequests.refresh();
      } else {
        debugPrint("orderRequestLoaded.orderID == null");
        // orderRequests.clear();
        orderRequests.value = [...orderRequests, order];
        orderRequests.refresh();
        // newServiceRequest.value = true;
        // newServiceRequest.refresh();
      }
    }

    debugPrint("orderRequests.length ${orderRequests.length}");
    debugPrint("orders.length ${orders.length}");
  }

  processHttpResponse(Response<dynamic> response) async {
    Response responseData = Response(body: response.body);

    ResponseBody responseBody = ResponseBody(
        status: responseData.body['status'],
        data: responseData.body['data'],
        error: responseData.body['err'],
        errorMessage: responseData.body['errorMessage'],
        successMessage: responseData.body['successMessage']);
    debugPrint('processHttpResponse responseData  ${responseBody.data}');

    return responseBody;
  }

  String formatDateTime(DateTime dateTime) {
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = getMonthName(dateTime.month);
    String year = dateTime.year.toString();
    String time =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

    return "$day $month $year, $time";
  }

  String getMonthName(int month) {
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    return months[month - 1];
  }
}
