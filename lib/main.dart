import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nft_market_place/pages/bottom_bar.dart';
import 'constant/constant.dart';
import 'controllers/marketplace_controller.dart';
import 'package:get/get.dart';
import 'services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/auth.dart';
import 'controllers/file_service_controller.dart';
import 'controllers/local_storage.dart';
import 'controllers/main_controller.dart';
import 'controllers/rest_api_service_controller.dart';
import 'controllers/sales_controller.dart';
import 'controllers/socket_service_controller.dart';
import 'controllers/wallet_controller.dart';

bool? isLoggedIn;
void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MainController());
  Get.put(RestApiServiceController());
  Get.put(AuthController());
  Get.put(FileServiceController());
  Get.put(SocketServiceController());
  Get.put(SalesController());
  Get.put(MarketplaceController());
  Get.put(WalletController());
  await LocalStorage.init();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = (prefs.getBool('isLoggedIn') == null)
      ? false
      : prefs.getBool('isLoggedIn');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.black, statusBarBrightness: Brightness.dark),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat',
          iconTheme: const IconThemeData(
            color: whiteColor,
          ),
        ),
        home: const BottomBar(),
      ),
    );
  }
}
