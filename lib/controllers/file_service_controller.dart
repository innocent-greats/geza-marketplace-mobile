import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

import '../models/http_responses.dart';
import '../models/person.dart';
import 'auth.dart';
import 'local_storage.dart';
import 'main_controller.dart';
import 'rest_api_service_controller.dart';

class FileServiceController extends MainController {
  final authController = Get.find<AuthController>();
  final restApiServiceController = Get.find<RestApiServiceController>();

  XFile? pickedXFile;
  var xProfileImageFiles = <XFile>[].obs;
  var xImageFiles = <XFile>[].obs;
  File? pickedIMageFile;
  List<File>? pickedFiles = [];
  String uploadedImageUrl = '';
  var uploadedProfileImage = ProfileImage(filename: '').obs;
  var uploadedImages = <ProfileImage>[];
  var isImageAdded = false.obs;
  var isProfileImageAdded = false.obs;
  var isSavingSuccess = false.obs;
  var pickedProfileFile = File('').obs;
  var selectedOfferItemImagePath = ''.obs;
  late File file;
  @override
  void onInit() async {
    initializeDateFormatting(Intl.defaultLocale);
    serverErrors.value = false;

    super.onInit();
    errorMessage.value = '';

    debugPrint('isLoggedIn.value == false');
  }

  void onChangeImage(String image) {
    selectedOfferItemImagePath.value = image;
  }

  pickImageFromLocalStorage(String source) async {
    debugPrint('Image $source');
    ImagePicker imagePicker = ImagePicker();
    if (source == 'camera') {
      pickedXFile = await imagePicker.pickImage(source: ImageSource.camera);
    }
    if (source == 'gallery') {
      pickedXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    }
    authController.person.value.inMemoryProfileImage =
        File(pickedXFile!.path.toString());
    authController.person.refresh();
    List<int> imgBytes = File(pickedXFile!.path.toString()).readAsBytesSync();
    debugPrint('pickedXFile  $imgBytes');
    LocalStorage.setProfileImageBytes(imgBytes.toString());

    update();

    pickedProfileFile.value = File(pickedXFile!.path.toString());
    if (pickedProfileFile.value.path != '') {
      isProfileImageAdded.value = true;
      await uploadFile();
      update();
    }
  }

  pickOfferItemImagesFromLocalStorage() async {
    xImageFiles.clear();
    ImagePicker imagePicker = ImagePicker();
    List<XFile> xFiles = await imagePicker.pickMultiImage(
        maxWidth: 600, maxHeight: 600, imageQuality: 50);
    if (xFiles.isNotEmpty) {
      xImageFiles.addAll(xFiles);
      selectedOfferItemImagePath.value = xFiles[0].path.toString();
      update();
      debugPrint('$xFiles');
      debugPrint('xFiles Not Null ${xFiles[0].path}');
      isImageAdded.value = true;

      // await uploadFiles();
    }

    update();
  }

  uploadFile() async {
    // construct form data
// Send FormData in POST request to upload file
    try {
      isLoading.value = true;
      List<int> imgBytes = File(pickedXFile!.path.toString()).readAsBytesSync();
      debugPrint('pickedXFile  $imgBytes');

      final multipartFile = http.MultipartFile.fromBytes('file', imgBytes,
          contentType: MediaType('image', 'jpeg'),
          filename: pickedXFile!.path.toString());
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${restApiServiceController.apiUrl}/users/avatar'),
      )
        ..files.add(multipartFile)
        ..fields['owner'] = authController.person.value.userID.toString();
      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        'Authorization': '${await LocalStorage.getAuthToken()}',
        'cookie': '${await LocalStorage.getAuthToken()}'
      });

      final responseStream = await request.send();
      final response = await http.Response.fromStream(responseStream);

      var decodedResponse = jsonDecode(response.body);
      var jSonData = jsonDecode(decodedResponse['data']);
      Person verifiedPerson = Person.fromJson(jSonData);
      authController.person.value = verifiedPerson;
      // await LocalStorage.setLoggedInUser(true);
      String rawJson = jsonEncode(verifiedPerson.toJson());
      LocalStorage.setLoggedInUserData(rawJson);
      authController.person.value.profileImage =
          File(pickedXFile!.path.toString()).toString();
      authController.person.refresh();
      isLoading.value = true;
      isProfileImageAdded.value = false;
      isSavingSuccess.value = true;
      Timer(const Duration(seconds: 15), () {
        isSavingSuccess.value = false;
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
