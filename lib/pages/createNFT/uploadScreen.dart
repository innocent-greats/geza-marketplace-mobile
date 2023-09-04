// ignore_for_file: file_names

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:page_transition/page_transition.dart';

class UploadNFTScreen extends StatefulWidget {
  const UploadNFTScreen({Key? key}) : super(key: key);

  @override
  State<UploadNFTScreen> createState() => _UploadNFTScreenState();
}

class _UploadNFTScreenState extends State<UploadNFTScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        centerTitle: false,
        title: const Text(
          'Upload',
          style: white18Bold,
        ),
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const SetPrice()));
            },
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
          Padding(
            padding: const EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                uploadFile(),
                heightSpace,
                heightSpace,
                titleDescription(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  uploadFile() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(10.0),
      color: whiteColor,
      strokeWidth: 1.0,
      strokeCap: StrokeCap.round,
      dashPattern: const [4, 4],
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: fixPadding * 4.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60.0,
              height: 60.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white.withOpacity(0.08),
              ),
              child: const Icon(
                Icons.cloud_upload,
                color: whiteColor,
              ),
            ),
            heightSpace,
            const Text(
              'Upload your file',
              style: white14Medium,
            ),
            heightSpace,
            Text(
              '(jpeg, png, webp)'.toUpperCase(),
              style: grey12Normal,
            ),
          ],
        ),
      ),
    );
  }

  titleDescription() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Title',
          style: white14Bold,
        ),
        heightSpace,
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: secondaryColor,
          ),
          child: const TextField(
            style: white14Medium,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Title of your NFT',
              hintStyle: grey14Medium,
              border: InputBorder.none,
            ),
          ),
        ),
        heightSpace,
        heightSpace,
        const Text(
          'Description',
          style: white14Bold,
        ),
        heightSpace,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: fixPadding * 1.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: secondaryColor,
          ),
          child: const TextField(
            style: white14Medium,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Description of your NFT',
              hintStyle: grey14Medium,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
