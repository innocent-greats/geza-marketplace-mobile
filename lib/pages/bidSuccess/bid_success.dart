import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/pages/bottom_bar.dart';
import 'package:page_transition/page_transition.dart';

class BidSuccess extends StatelessWidget {
  const BidSuccess({Key? key}) : super(key: key);

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
                    'Place Bid Success!',
                    style: white16Bold,
                  ),
                  heightSpace,
                  const Text(
                    'You have successfully bid on the item\nit will be on the list',
                    style: grey14Normal,
                    textAlign: TextAlign.center,
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
