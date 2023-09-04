import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:page_transition/page_transition.dart';

class ConnectWallet extends StatefulWidget {
  const ConnectWallet({Key? key}) : super(key: key);

  @override
  State<ConnectWallet> createState() => _ConnectWalletState();
}

class _ConnectWalletState extends State<ConnectWallet> {
  String currentWallet = 'Metamask';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        title: const Text('Connect Wallet'),
        titleSpacing: 0.0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding),
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const BidSuccess())),
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: 40.0,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: primaryColor,
              ),
              child: const Text(
                'Continue',
                style: white16Bold,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(fixPadding * 2.0),
            child: Image.asset(
              'assets/wallet/wallet.png',
              width: 300.0,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: () {
                setState(() {
                  currentWallet = 'Metamask';
                });
              },
              child: walletItem('assets/wallet/metamask.png', 'Metamask'),
            ),
          ),
          heightSpace,
          heightSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: () {
                setState(() {
                  currentWallet = 'Coinbase';
                });
              },
              child: walletItem('assets/wallet/coinbase.png', 'Coinbase'),
            ),
          ),
          heightSpace,
          heightSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: () {
                setState(() {
                  currentWallet = 'Rainbow';
                });
              },
              child: walletItem('assets/wallet/rainbow.png', 'Rainbow'),
            ),
          ),
          heightSpace,
          heightSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: () {
                setState(() {
                  currentWallet = 'Others';
                });
              },
              child: walletItem('assets/wallet/others.png', 'Others'),
            ),
          ),
          heightSpace,
          heightSpace,
        ],
      ),
    );
  }

  walletItem(image, name) {
    return Container(
      padding: const EdgeInsets.all(fixPadding * 1.5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 30.0,
                fit: BoxFit.fitHeight,
              ),
              widthSpace,
              Text(
                name,
                style: white16Bold,
              ),
            ],
          ),
          (currentWallet == name)
              ? Container(
                  width: 30.0,
                  height: 30.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 1.0,
                      color: primaryColor,
                    ),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: primaryColor,
                  ),
                )
              : const SizedBox(
                  width: 0.0,
                  height: 0.0,
                ),
        ],
      ),
    );
  }
}
