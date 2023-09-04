// ignore_for_file: avoid_print, file_names

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/pages/bottom_bar.dart';
import 'package:page_transition/page_transition.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({Key? key}) : super(key: key);

  @override
  _EnterPinScreenState createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  DateTime? currentBackPressTime;
  int? pin1, pin2, pin3, pin4;
  bool progress = false;
  final LocalAuthentication auth = LocalAuthentication();
  late bool _canCheckBiometrics;
  late List<BiometricType> _availableBiometrics;
  // ignore: unused_field
  String _authorized = '';
  bool tooManyAttempt = false;
  bool _isFingerPrintBiometricAvailable = false;
  bool? cancelTapOnFingerprintDialog;

  @override
  void initState() {
    super.initState();
    fingerPrintAuth();
  }

  fingerPrintAuth() async {
    await _checkBiometrics();
    if (!_canCheckBiometrics) {
      setState(() {
        _authorized = 'Fingerprint Sensor Not Available';
      });
    }

    if (_canCheckBiometrics) {
      await _getAvailableBiometrics();
      for (int i = 0; i < _availableBiometrics.length; i++) {
        if (_availableBiometrics[i] == BiometricType.strong) {
          setState(() {
            _isFingerPrintBiometricAvailable = true;
          });
        }
      }

      if (!_isFingerPrintBiometricAvailable) {
        setState(() {
          _authorized = 'Fingerprint Sensor Available but Fingerprint Not Set.';
        });
      }

      if (_isFingerPrintBiometricAvailable) {
        await _authenticate();
      }
    }
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    String? exceptionMsg;
    try {
      setState(() {
        _authorized = 'Authenticating';
        progress = true;
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true, biometricOnly: true),
      );
      setState(() {
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      exceptionMsg = e.message;
    }
    if (!mounted) return;

    final String message = authenticated
        ? 'Fingerprint Authentication Successful.'
        : (exceptionMsg != null)
            ? exceptionMsg
            : 'Not authorize';
    if (authenticated) {
      tooManyAttempt = false;
    }
    setState(() {
      _authorized = message;
      progress = false;
    });
    if (message == 'Fingerprint Authentication Successful.') {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade, child: const BottomBar()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: blackColor,
      body: WillPopScope(
        child: SafeArea(
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(fixPadding * 2.0),
                      width: width,
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Need Help?'.toUpperCase(),
                          style: primaryColor14Medium,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/icon.png',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    const Text(
                      'Enter your PIN',
                      style: white16Medium,
                    ),
                    height5Space,
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: fixPadding * 4.0),
                      child: Text(
                        'Enter the secure PIN to access your account.',
                        style: grey14Normal,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),

                // Pin point start
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        pinRoundedItem(pin1),
                        widthSpace,
                        pinRoundedItem(pin2),
                        widthSpace,
                        pinRoundedItem(pin3),
                        widthSpace,
                        pinRoundedItem(pin4),
                      ],
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    (progress)
                        ? const SpinKitRing(
                            color: primaryColor,
                            size: 20.0,
                            lineWidth: 1.5,
                          )
                        : InkWell(
                            onTap: () {},
                            child: const Text(
                              'Forgot PIN?',
                              style: primaryColor14Normal,
                            ),
                          ),
                    (_authorized != '' &&
                            _authorized != 'Not authorize' &&
                            _isFingerPrintBiometricAvailable == true)
                        ? Padding(
                            padding: const EdgeInsets.only(top: fixPadding),
                            child: Text(
                              _authorized,
                              style: red14MediumTextStyle,
                            ),
                          )
                        : Container(),
                    (_authorized != 'Fingerprint Authentication Successful.' &&
                            _isFingerPrintBiometricAvailable == true &&
                            progress == false)
                        ? Padding(
                            padding: const EdgeInsets.only(top: fixPadding),
                            child: InkWell(
                              onTap: () => fingerPrintAuth(),
                              child: const Icon(
                                Icons.fingerprint,
                                size: 60.0,
                                color: primaryColor,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                // Pin point end

                // KeyPad Start
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    horizontalLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        keyPadButton(1),
                        verticalLine(),
                        keyPadButton(2),
                        verticalLine(),
                        keyPadButton(3),
                      ],
                    ),
                    horizontalLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        keyPadButton(4),
                        verticalLine(),
                        keyPadButton(5),
                        verticalLine(),
                        keyPadButton(6),
                      ],
                    ),
                    horizontalLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        keyPadButton(7),
                        verticalLine(),
                        keyPadButton(8),
                        verticalLine(),
                        keyPadButton(9),
                      ],
                    ),
                    horizontalLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: (width - 2.0) / 3,
                          height: 30.0,
                          alignment: Alignment.center,
                        ),
                        verticalLine(),
                        keyPadButton(0),
                        verticalLine(),
                        InkWell(
                          onTap: () {
                            if (progress) {
                            } else {
                              if (pin4 != null) {
                                setState(() {
                                  pin4 = null;
                                });
                              } else if (pin3 != null) {
                                setState(() {
                                  pin3 = null;
                                });
                              } else if (pin2 != null) {
                                setState(() {
                                  pin2 = null;
                                });
                              } else if (pin1 != null) {
                                setState(() {
                                  pin1 = null;
                                });
                              } else {}
                            }
                          },
                          child: Container(
                            width: (width - 2.0) / 3,
                            height: 50.0,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.backspace,
                              color: blackColor,
                              size: 25.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // KeyPad End
              ],
            ),
          ),
        ),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  pinRoundedItem(pin) {
    return Container(
      width: 22.0,
      height: 22.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.0),
        border: Border.all(
          width: 1.5,
          color: (pin == null) ? greyColor : whiteColor,
        ),
        color: (pin == null) ? Colors.transparent : whiteColor,
      ),
    );
  }

  horizontalLine() {
    return Container(
      height: 1.0,
      width: double.infinity,
      color: greyColor.withOpacity(0.25),
    );
  }

  verticalLine() {
    return Container(
      height: 50.0,
      width: 1.0,
      color: greyColor.withOpacity(0.25),
    );
  }

  keyPadButton(number) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        if (progress) {
        } else {
          if (pin1 == null) {
            setState(() {
              pin1 = number;
            });
          } else if (pin2 == null) {
            setState(() {
              pin2 = number;
            });
          } else if (pin3 == null) {
            setState(() {
              pin3 = number;
            });
          } else if (pin4 == null) {
            setState(() {
              pin4 = number;
              progress = true;
              Timer(
                  const Duration(seconds: 3),
                  () => Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 600),
                          type: PageTransitionType.fade,
                          child: const BottomBar())));
            });
          } else {}
        }
      },
      child: Container(
        width: (width - 2.0) / 3,
        height: 50.0,
        alignment: Alignment.center,
        child: Text(
          '$number',
          style: white18Medium,
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
}
