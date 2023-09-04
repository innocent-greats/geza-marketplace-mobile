// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/controllers/marketplace_controller.dart';
import 'package:nft_market_place/pages/bottom_bar.dart';
import 'package:page_transition/page_transition.dart';

class BookingSuccess extends StatelessWidget {
  BookingSuccess({Key? key}) : super(key: key);
  final MarketplaceController marketplaceController =
      Get.find<MarketplaceController>();
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
                    'Booking Successfully Requested!',
                    style: white16Bold,
                  ),
                  heightSpace,
                  Text(
                    'You have successfully sent a booking request to ${marketplaceController.selectedOfferItem.value.provider!.lastName}.\nYou can see it in your profile',
                    style: grey14Normal,
                    textAlign: TextAlign.center,
                  ),
                  heightSpace,
                  heightSpace,

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
