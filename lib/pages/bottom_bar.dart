import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/pages/createNFT/createNewScreen.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:page_transition/page_transition.dart';

class BottomBar extends StatefulWidget {
  final int? id;
  const BottomBar({Key? key, this.id}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  DateTime? currentBackPressTime;
  int? currentIndex = 1;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      setState(() {
        currentIndex = widget.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool backStatus = onWillPop();
        if (backStatus) {
          exit(0);
        }
        return false;
      },
      child: Scaffold(
        body: (currentIndex == 1)
            ? const HomeScreen()
            : (currentIndex == 2)
                ? const SearchScreen()
                : (currentIndex == 4)
                    ? const Notifaications()
                    : const Profile(),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 80.0,
          color: whiteColor,
          padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 2.0,
              fixPadding * 2.0, fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              bottomBarItem('assets/icons/bottombar/home.png',
                  'assets/icons/bottombar/home_active.png', 1),
              bottomBarItem('assets/icons/bottombar/search.png',
                  'assets/icons/bottombar/search_active.png', 2),
              bottomBarItem('assets/icons/bottombar/add.png',
                  'assets/icons/bottombar/add_active.png', 3),
              bottomBarItem('assets/icons/bottombar/notification.png',
                  'assets/icons/bottombar/notification_active.png', 4),
              bottomBarItem('assets/icons/bottombar/profile.png',
                  'assets/icons/bottombar/profile_active.png', 5),
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

  bottomBarItem(icon, activeIcon, index) {
    return InkWell(
      borderRadius: BorderRadius.circular(7.0),
      onTap: () {
        if (index == 3) {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 1),
              child: const CreateNewScreen(),
            ),
          );
        } else {
          setState(() {
            currentIndex = index;
          });
        }
      },
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: (currentIndex == index)
              ? primaryColor
              : Colors.white.withOpacity(0.1),
        ),
        alignment: Alignment.center,
        child: Image.asset(
          (currentIndex == index) ? activeIcon : icon,
          width: 25.0,
          height: 25.0,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
