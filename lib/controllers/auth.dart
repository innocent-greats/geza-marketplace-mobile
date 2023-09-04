import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/controllers/local_storage.dart';
import 'package:nft_market_place/controllers/main_controller.dart';
import 'package:nft_market_place/models/http_responses.dart';
import 'package:nft_market_place/models/locations.dart';
import 'package:nft_market_place/models/person.dart';
import 'package:nft_market_place/models/wallet.dart';
import 'package:nft_market_place/pages/auth/login.dart';
import 'package:nft_market_place/pages/auth/otpScreen.dart';
import 'package:nft_market_place/pages/bottom_bar.dart';

class AuthController extends GetxController {
  final _mainController = Get.find<MainController>();
  var selectedCity = ''.obs;
  var selectedNeighbourhood = ''.obs;
  var populatedNeighbourhoods = <Neighbourhood>[].obs;
  var person = Person(
    firstName: '',
    lastName: '',
    accountType: '',
    phone: '',
    city: '',
    neighbourhood: '',
    createdDate: DateTime.now().toString(),
  ).obs;
  String? response;
  var otpCode = ''.obs;
  var otpError = false.obs;
  var otpErrorMessage = ''.obs;
  var otp1 = ''.obs;
  var authPhone = ''.obs;
  var firstNameController = ''.obs;
  var lastNameController = ''.obs;
  bool showPassword = false, loading = false;
  bool confirmPassword = false;
  late List<String> accontTypes = [
    'customer',
    'hair_stylist',
    'skin_&_nail_care_specialist',
    'retailer'
  ];
  var selectedAccontType = 'customer'.obs;
  List<String> vendorSpecialization = [
    'hair_stylist',
    'skin_&_nail_care',
    'retail_store'
  ];

  var selectedVendorSpecialization = 'hair_stylist'.obs;
  late List<String> bookingTypes = ['direct', 'broadcast'];
  var selectedBookingType = 'direct'.obs;
  var showCalender = false.obs;

  var isLoggedIn = false.obs;
  var authToken = ''.obs;

  var wallet = Wallet(
          walletID: '',
          userID: '',
          walletName: '',
          walletAddress: '',
          currentBalance: 0,
          transactions: [],
          createdDate: null,
          deletedDate: null,
          updatedDate: null)
      .obs;

  void onSelectedCity(Object query) {
    debugPrint('selectedCity $query');
    selectedCity.value = query as String;

    for (Province province in locations) {
      debugPrint('provinces loop data ${province.name}');
      for (CityTown city in province.cities) {
        debugPrint('cities loop data ${city.name}');

        if (city.name == selectedCity.value.toLowerCase()) {
          debugPrint('matched City data ${city.name}');
          debugPrint('matched Areas data ${city.neighbourhoods}');

          populatedNeighbourhoods.value = city.neighbourhoods;
        }
        break;
      }
    }
    debugPrint('Selected selectedCity ${selectedCity.value}');
  }

  void onSelectedArea(Object area) {
    debugPrint('onSelectedArea $area');
    selectedNeighbourhood.value = area as String;
    debugPrint('Selected selectedNeighbourhood ${selectedNeighbourhood.value}');
  }

  void onSelectedAccontType(Object account) {
    debugPrint('onSelectedAccontType $account');
    selectedAccontType.value = account as String;
    debugPrint('Selected account $selectedAccontType');
  }

  void onSelectedBookingType(Object account) {
    debugPrint('onSelectedBookingType $account');
    selectedBookingType.value = account as String;
    debugPrint('Selected bookin $selectedAccontType');
  }

  void onSelectedVendorAccontTypes(String category) {
    debugPrint('onSelectedBeautyParlourType $category');
    selectedVendorSpecialization.value = category;
    debugPrint('Selected Specialty $selectedVendorSpecialization');
  }

  onVerify(String otpCode) async {
    debugPrint('onVerify Method $otpCode');
    try {
      _mainController.isLoading.value = true;
      Map body = {"otp": otpCode, "phone": authPhone.value};
      var response = await _mainController.getConnect
          .post('${_mainController.apiUrl}/auth/onVerifyOTP', body);
      debugPrint('onVerify res: $response');
      ResponseBody responseBody =
          await _mainController.processHttpResponse(response);
      await processUserData(responseBody);
      _mainController.isLoading.value = false;
    } catch (e) {
      _mainController.isLoading.value = false;
      _mainController.formErrors.value = true;
      // formErrorMessage.value = e.toString();
      otpError.value = true;
      otpErrorMessage.value = 'OTP or Phone not correct!';

      debugPrint('onVerify error $e');
    }
  }

  onLogin(String phone) async {
    debugPrint('onLogin Method $phone');
    try {
      _mainController.isLoading.value = true;
      Map body = {"phone": phone};
      debugPrint('onLogin error ${_mainController.apiUrl}');

      var response = await _mainController.getConnect
          .post('${_mainController.apiUrl}/auth/signin', body);
      debugPrint('/auth/signin response: $response');
      ResponseBody responseBody =
          await _mainController.processHttpResponse(response);
      _mainController.isLoading(false);

      if (responseBody.status == 500) {
        _mainController.errorMessage.value = 'No network connection';
        _mainController.formErrorMessage.value =
            'Connection Error, Check Network connection.';
        // errorMessage.value = responseBody.errorMessage!.capitalizeFirst!;
      } else {
        if (responseBody.data != '') {
          OTP otp = await decodeOTP(responseBody);
          Get.to(const OtpScreen(), arguments: {'otp': otp});
        }
      }
      _mainController.isLoading.value = false;
    } catch (e) {
      _mainController.isLoading(false);
      _mainController.formErrors.value = true;
      _mainController.formErrorMessage.value =
          'Connection Error, Check Network connection.';
      debugPrint('onLogin error $e');
    }
  }

  onHandleLogout() async {
    debugPrint('onHandleLogout CALLED');
    await LocalStorage.removeLoggedInUser();
    isLoggedIn.value = false;
    person.value = Person(
      firstName: '',
      lastName: '',
      accountType: '',
      phone: '',
      city: '',
      neighbourhood: '',
      createdDate: DateTime.now().toString(),
    );
    Get.offAll(const LoginScreen());
  }

  Future<void> onUserUpdate(
    String firstName,
    String lastName,
    String phone,
  ) async {
    try {
      _mainController.isLoading.value = true;

      var body = {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "neighbourhood": selectedNeighbourhood.value != ''
            ? selectedNeighbourhood.value
            : person.value.neighbourhood,
        "city":
            selectedCity.value != '' ? selectedCity.value : person.value.city,
        "accountType":
            selectedAccontType.value == 'client' ? 'client' : 'vendor',
        "specialization": selectedVendorSpecialization.value,
      };
      if (firstName != '') {
        Response<dynamic> response = await _mainController.getConnect
            .post('${_mainController.apiUrl}/auth/updateUser', body);
        ResponseBody responseBody =
            await _mainController.processHttpResponse(response);
        await processUserData(responseBody);
        _mainController.isLoading.value = false;
      }
    } catch (e) {
      _mainController.isLoading(false);
      _mainController.formErrors.value = true;
      _mainController.formErrorMessage.value = 'Error: ${e.toString()}';
      debugPrint(e.toString());
    }
  }

  Future<void> onHandleSignUp(
    String firstName,
    String lastName,
    String phone,
  ) async {
    try {
      _mainController.isLoading.value = true;
      var body = {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "neighbourhood": selectedNeighbourhood.value,
        "city": selectedCity.value,
        "accountType": selectedAccontType.value,
        "tradingAs": selectedAccontType.value,
      };
      debugPrint('onHandleSignUp $body');
      if (firstName != '') {
        Response<dynamic> response = await _mainController.getConnect
            .post('${_mainController.apiUrl}/auth/signup', body);
        ResponseBody responseBody =
            await _mainController.processHttpResponse(response);
        await processUserData(responseBody);
        _mainController.isLoading.value = false;
      }
    } catch (e) {
      _mainController.isLoading(false);
      _mainController.formErrors.value = true;
      _mainController.formErrorMessage.value = 'Error: ${e.toString()}';
      debugPrint(e.toString());
    }
  }

  processUserData(ResponseBody responseBody) async {
    try {
      if (responseBody.status == 200) {
        var jSonData = jsonDecode(responseBody.data);
        // debugPrint(' jSonData $jSonData');

        Person verifiedPerson = Person.fromJson(jSonData);
        person.value = verifiedPerson;
        // debugPrint(' verifiedPerson ${verifiedPerson.firstName}');
        await LocalStorage.setLoggedInUser(true);
        String rawJson = jsonEncode(verifiedPerson.toJson());
        LocalStorage.setLoggedInUserData(rawJson);

        if (verifiedPerson.wallet != null) {
          String walletRawJson = jsonEncode(verifiedPerson.wallet!.toJson());
          // debugPrint(' walletRawJson $walletRawJson');
          LocalStorage.setLoggedInUserWalletData(walletRawJson);
        }

        if (jSonData['token'] != null) {
          // debugPrint(' token ${jSonData['token']}');
          LocalStorage.setLoggedInUserToken(jSonData['token']);
        }

        person.refresh();
        if (person.value.firstName != '' && person.value.accountType != '') {
          _mainController.isLoading.value = false;

          debugPrint('Stored User ${person.value.firstName}');
          _mainController.isLoading.value = false;
          if (person.value.accountType != 'customer') {
            _mainController.isLoading.value = false;
            Get.to(const BottomBar());
          } else {
            _mainController.isLoading.value = false;
            Get.to(const BottomBar());
          }
        }
        _mainController.isLoading.value = false;
      }
      if (responseBody.status == 500) {
        _mainController.errorMessage.value = 'No network connection';
        _mainController.formErrorMessage.value =
            'Connection Error, Check Network connection.';
      }
    } catch (e) {
      _mainController.isLoading.value = false;
      _mainController.formErrors.value = true;
      debugPrint('processUserData error $e');
    }
  }

  decodeOTP(ResponseBody responseBody) async {
    var jSonData = jsonDecode(responseBody.data);
    OTP otp = OTP(otp: jSonData['otp'], phone: jSonData['phone']);
    otp1.value = otp.otp!;
    authPhone.value = otp.phone!;
    if (kDebugMode) {
      print('otp1.value');
    }
    if (kDebugMode) {
      print(otp1.value);
    }
    return otp;
  }
}
