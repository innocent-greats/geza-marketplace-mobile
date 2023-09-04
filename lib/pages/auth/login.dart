// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/controllers/auth.dart';
import 'package:nft_market_place/controllers/main_controller.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mainController = Get.find<MainController>();
  final _authController = Get.find<AuthController>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DateTime? currentBackPressTime;
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        bool backStatus = onWillPop();
        if (backStatus) {
          exit(0);
        }
        return false;
      },
      child: Container(
        color: blackColor,
        child: Scaffold(
          backgroundColor: blackColor,
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: height -
                    MediaQuery.of(context).padding.top -
                    fixPadding * 2.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        welcomeText(),
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        phoneTextField(),
                        heightSpace,
                        heightSpace,
                        passwordTextField(),
                        heightSpace,
                        forgotPassword(),
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        loginButton(),
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        socialLogin(),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        heightSpace,
                        dontHaveAccountText(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: whiteColor,
        textColor: blackColor,
      );
      return false;
    } else {
      return true;
    }
  }

  welcomeText() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'Let\'s sign you in.',
            style: white22Bold,
          ),
          heightSpace,
          Text(
            'Welcome Back. You\'ve been missed!',
            style: white14Normal,
          ),
        ],
      ),
    );
  }

  phoneTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(fixPadding * 0.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: secondaryColor,
        ),
        child: const TextField(
          style: white14Medium,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20.0, top: 14.0),
            hintText: 'Enter your mobile number',
            hintStyle: grey14Medium,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.local_phone_outlined,
              color: whiteColor,
            ),
          ),
        ),
      ),
    );
  }

  passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(fixPadding * 0.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: secondaryColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: white14Medium,
                keyboardType: TextInputType.visiblePassword,
                obscureText: obsecure,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0, top: 14.0),
                  hintText: 'Enter your password here',
                  hintStyle: grey14Medium,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    obsecure = !obsecure;
                  });
                },
                child: Icon(
                  (obsecure) ? Icons.visibility : Icons.visibility_off,
                  color: whiteColor,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  forgotPassword() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {},
        child: const Text(
          'Forgot password?',
          style: primaryColor14Bold,
        ),
      ),
    );
  }

  loginButton() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const SignupScreen()));
        },
        borderRadius: BorderRadius.circular(7.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(fixPadding * 1.5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: primaryColor,
          ),
          child: Obx(
            () => _mainController.isLoading.value == true
                ? Wrap(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(fixPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[
                            SpinKitRing(
                              color: whiteColor,
                              size: 20.0,
                              lineWidth: 1,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'Please Wait...',
                              style: white14Medium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const Text(
                    'Login',
                    style: white16Bold,
                  ),
          ),
        ),
      ),
    );
  }

  socialLogin() {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'OR',
          style: white14Medium,
        ),
        heightSpace,
        heightSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(7.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: fixPadding * 1.5),
                  width: (width - fixPadding * 5.0) / 2.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: secondaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google.png',
                        height: 22.0,
                        width: 22.0,
                        fit: BoxFit.fill,
                      ),
                      widthSpace,
                      const Text(
                        'Google',
                        style: white14Medium,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(7.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: fixPadding * 1.5),
                  width: (width - fixPadding * 5.0) / 2.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: secondaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/facebook.png',
                        height: 22.0,
                        width: 22.0,
                        fit: BoxFit.fill,
                      ),
                      widthSpace,
                      const Text(
                        'Facebook',
                        style: white14Medium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  dontHaveAccountText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account?',
          style: white14Medium,
        ),
        width5Space,
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const SignupScreen()));
          },
          child: const Text(
            'Sign up',
            style: primaryColor14Bold,
          ),
        ),
      ],
    );
  }
}
