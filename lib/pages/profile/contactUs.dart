// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        centerTitle: false,
        titleSpacing: 0.0,
        title: const Text(
          'Contact Us',
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
          heightSpace,
          heightSpace,
          fullName(),
          heightSpace,
          heightSpace,
          emailAddress(),
          heightSpace,
          heightSpace,
          message(),
          heightSpace,
          heightSpace,
          sendButton(context),
        ],
      ),
    );
  }

  fullName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Full Name',
            style: white16Bold,
          ),
          heightSpace,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(fixPadding * 0.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: secondaryColor,
            ),
            child: const TextField(
              style: white14Medium,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.0),
                hintText: 'Enter your full name',
                hintStyle: grey14Medium,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  emailAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email Address',
            style: white16Bold,
          ),
          heightSpace,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(fixPadding * 0.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: secondaryColor,
            ),
            child: const TextField(
              style: white14Medium,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.0),
                hintText: 'Enter your email address',
                hintStyle: grey14Medium,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  message() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Message',
            style: white16Bold,
          ),
          heightSpace,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(fixPadding * 0.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: secondaryColor,
            ),
            child: const TextField(
              style: white14Medium,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'Write here',
                hintStyle: grey14Medium,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  sendButton(context) {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        onTap: () => Navigator.pop(context),
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
            'Send',
            style: white16Bold,
          ),
        ),
      ),
    );
  }
}
