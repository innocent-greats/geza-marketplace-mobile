// ignore_for_file: file_names, prefer_const_constructors

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:page_transition/page_transition.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var firstController = TextEditingController();
  var secondController = TextEditingController();
  var thirdController = TextEditingController();
  var fourthController = TextEditingController();
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode fourthFocusNode = FocusNode();

  loadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          backgroundColor: secondaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    SpinKitRing(
                      color: primaryColor,
                      size: 40.0,
                      lineWidth: 1.2,
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      'Please Wait...',
                      style: white14Medium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const EnterPinScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: whiteColor,
                    )),
              ],
            ),
          ),
          verificationText(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          otpBox(),
          heightSpace,
          heightSpace,
          didntReceiveOtpText(),
          heightSpace,
          heightSpace,
          verifyButton(),
        ],
      ),
    );
  }

  verificationText() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'Verification',
            style: white22Bold,
          ),
          heightSpace,
          Text(
            'We have sent the verification code to',
            style: white14Normal,
          ),
          height5Space,
          Text(
            '+(444) 489-7896',
            style: white14Normal,
          ),
        ],
      ),
    );
  }

  otpBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 1 Start
          Container(
            width: 50.0,
            height: 50.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextField(
              controller: firstController,
              style: white14Medium,
              keyboardType: TextInputType.number,
              cursorColor: primaryColor,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(18.0),
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              onChanged: (v) {
                FocusScope.of(context).requestFocus(secondFocusNode);
              },
            ),
          ),
          // 1 End
          // 2 Start
          Container(
            width: 50.0,
            height: 50.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextField(
              focusNode: secondFocusNode,
              controller: secondController,
              style: white14Medium,
              keyboardType: TextInputType.number,
              cursorColor: primaryColor,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(18.0),
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              onChanged: (v) {
                FocusScope.of(context).requestFocus(thirdFocusNode);
              },
            ),
          ),
          // 2 End
          // 3 Start
          Container(
            width: 50.0,
            height: 50.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextField(
              focusNode: thirdFocusNode,
              controller: thirdController,
              style: white14Medium,
              keyboardType: TextInputType.number,
              cursorColor: primaryColor,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(18.0),
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              onChanged: (v) {
                FocusScope.of(context).requestFocus(fourthFocusNode);
              },
            ),
          ),
          // 3 End
          // 4 Start
          Container(
            width: 50.0,
            height: 50.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextField(
              focusNode: fourthFocusNode,
              controller: fourthController,
              style: white14Medium,
              keyboardType: TextInputType.number,
              cursorColor: primaryColor,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(18.0),
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              onChanged: (v) {
                loadingDialog();
              },
            ),
          ),
          // 4 End
        ],
      ),
    );
  }

  didntReceiveOtpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: 'Didn\'t receive any code? ',
            style: white14Bold,
            children: <TextSpan>[
              TextSpan(
                text: 'Resend New Code',
                style: primaryColor14Bold,
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  verifyButton() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        onTap: () => loadingDialog(),
        borderRadius: BorderRadius.circular(7.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(fixPadding * 1.5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: primaryColor,
          ),
          child: const Text(
            'Verify',
            style: white16Bold,
          ),
        ),
      ),
    );
  }
}
