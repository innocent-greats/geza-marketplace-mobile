import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/pages/bottom_bar.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:page_transition/page_transition.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        centerTitle: false,
        titleSpacing: 0.0,
        title: const Text(
          'Settings',
          style: white18Bold,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: whiteColor,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          about(),
          devider(),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const MyWallet()));
            },
            child: settingTile('assets/icons/profile/wallet.png', 'My Wallet'),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 1),
                child: const BottomBar(id: 4),
              ),
            ),
            child: settingTile(
                'assets/icons/profile/notification.png', 'Notifications'),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const FaqScreen()));
            },
            child: settingTile('assets/icons/profile/faq.png', 'FAQs'),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const ContactUs()));
            },
            child: settingTile(
                'assets/icons/profile/contact_us.png', 'Contact Us'),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const TermsAndCondition()));
            },
            child: settingTile(
                'assets/icons/profile/terms.png', 'Terms & Conditions'),
          ),
          InkWell(
            onTap: () => logoutDialog(),
            child: logout(),
          ),
        ],
      ),
    );
  }

  about() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Stack(
              children: [
                Hero(
                  tag: 'userImage',
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      image: const DecorationImage(
                          image: AssetImage('assets/user.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const EditProfile()));
                      },
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: primaryColor,
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 18.0,
                          color: whiteColor,
                        ),
                      ),
                    ))
              ],
            ),
          ),
          widthSpace,
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Joseph Reese',
                style: white16Bold,
              ),
              height5Space,
              Text(
                '@reesejoseph',
                style: grey14Medium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  devider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      height: 0.7,
      color: greyColor.withOpacity(0.55),
    );
  }

  settingTile(iconImage, title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 1.5,
              fixPadding * 2.0, fixPadding * 1.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: whiteColor.withOpacity(0.1),
                    ),
                    child: Image.asset(
                      iconImage,
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  widthSpace,
                  Text(
                    title,
                    style: white16Bold,
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: primaryColor,
              ),
            ],
          ),
        ),
        devider(),
      ],
    );
  }

  logout() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 1.5,
          fixPadding * 2.0, fixPadding * 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: whiteColor.withOpacity(0.1),
            ),
            child: Image.asset(
              'assets/icons/profile/logout.png',
              width: 24.0,
              height: 24.0,
              fit: BoxFit.cover,
            ),
          ),
          widthSpace,
          const Text(
            'Logout',
            style: white16Bold,
          ),
        ],
      ),
    );
  }

  logoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
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
                width: double.infinity,
                padding: const EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Are you sure want to logout?',
                      style: white16Bold,
                    ),
                    heightSpace,
                    heightSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(7.0),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                fixPadding, fixPadding, fixPadding, fixPadding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              border:
                                  Border.all(width: 1.0, color: primaryColor),
                            ),
                            child: const Text(
                              'Cancel',
                              style: primaryColor12Bold,
                            ),
                          ),
                        ),
                        widthSpace,
                        width5Space,
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const LoginScreen())),
                          borderRadius: BorderRadius.circular(7.0),
                          child: Container(
                            padding: const EdgeInsets.all(fixPadding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: primaryColor,
                              border:
                                  Border.all(width: 1.0, color: primaryColor),
                            ),
                            child: const Text(
                              'Yes, Logout',
                              style: white12Bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
