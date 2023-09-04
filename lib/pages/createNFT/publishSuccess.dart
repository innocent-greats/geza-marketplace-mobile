// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/pages/bottom_bar.dart';
import 'package:page_transition/page_transition.dart';

class PublishSuccess extends StatelessWidget {
  const PublishSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => await Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade, child: const BottomBar())),
      child: Scaffold(
        backgroundColor: blackColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height - 80.0,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/bid_success.png',
                    width: 180.0,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(height: 40.0),
                  const Text(
                    'Publish Successfully!',
                    style: white16Bold,
                  ),
                  heightSpace,
                  const Text(
                    'You have successfully listed a NFT for sale.\nYou can see it in your profile',
                    style: grey14Normal,
                    textAlign: TextAlign.center,
                  ),
                  heightSpace,
                  heightSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'https://nft.io/0xd010d263ax48...',
                        style: white14Normal,
                      ),
                      width5Space,
                      InkWell(
                        onTap: () {
                          Fluttertoast.showToast(
                            msg: 'URL Copied to Clipboard.',
                            backgroundColor: whiteColor,
                            textColor: blackColor,
                          );
                        },
                        child: const Icon(
                          Icons.copy,
                          color: whiteColor,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 80.0,
              width: double.infinity,
              alignment: Alignment.center,
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: const BottomBar())),
                child: const Text(
                  'Back to Home',
                  style: primaryColor16Bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
