// ignore_for_file: file_names, prefer_const_constructors
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:page_transition/page_transition.dart';

class SetPrice extends StatefulWidget {
  const SetPrice({Key? key}) : super(key: key);

  @override
  State<SetPrice> createState() => _SetPriceState();
}

class _SetPriceState extends State<SetPrice> {
  DateTime startDate = DateTime(2016, 10, 26);

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  bool fixPrice = true;
  bool auction = false;
  String startingDate = '';
  String endingDate = '';
  DateTime startingSelectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: whiteColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0.0,
        title: const Text(
          'Set Price',
          style: white18Bold,
        ),
      ),
      body: Column(
        children: [
          tabBar(),
          (fixPrice) ? fixPriceContent() : auctionContent(),
        ],
      ),
    );
  }

  tabBar() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 2.0,
        fixPadding * 2.0,
        0.0,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(fixPadding * 0.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: secondaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                if (fixPrice) {
                } else {
                  setState(() {
                    fixPrice = true;
                    auction = false;
                  });
                }
              },
              borderRadius: BorderRadius.circular(7.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: fixPadding),
                width: (width - fixPadding * 5.0) / 2.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: (fixPrice)
                      ? Colors.white.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: const Text(
                  'Fix Price',
                  style: white16Bold,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (auction) {
                } else {
                  setState(() {
                    auction = true;
                    fixPrice = false;
                  });
                }
              },
              borderRadius: BorderRadius.circular(7.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: fixPadding),
                width: (width - fixPadding * 5.0) / 2.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: (auction)
                      ? Colors.white.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: const Text(
                  'Auction',
                  style: white16Bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  fixPriceContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Price',
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
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.0),
                          hintText: 'Enter NFT Price in ETH',
                          hintStyle: grey14Medium,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    heightSpace,
                    heightSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'You will receive',
                          style: grey14Medium,
                        ),
                        Text(
                          '0.99 ETH',
                          style: white16Medium,
                        ),
                      ],
                    ),
                    heightSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Service fee',
                          style: grey14Medium,
                        ),
                        Text(
                          '0.01 ETH',
                          style: white16Medium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          publishButton(),
        ],
      ),
    );
  }

  auctionContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Price',
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
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.0),
                          hintText: 'Enter NFT Price in ETH',
                          hintStyle: grey14Medium,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    heightSpace,
                    heightSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'You will receive',
                          style: grey14Medium,
                        ),
                        Text(
                          '0.99 ETH',
                          style: white16Medium,
                        ),
                      ],
                    ),
                    heightSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Service fee',
                          style: grey14Medium,
                        ),
                        Text(
                          '0.01 ETH',
                          style: white16Medium,
                        ),
                      ],
                    ),
                    heightSpace,
                    heightSpace,
                    const DottedLine(
                      dashColor: greyColor,
                      dashGapLength: 8.0,
                      dashLength: 4.0,
                    ),
                    heightSpace,
                    heightSpace,

                    // Starting Date Start
                    const Text(
                      'Starting Date',
                      style: white14Bold,
                    ),
                    heightSpace,
                    InkWell(
                      onTap: () => _showDialog(
                        CupertinoDatePicker(
                          initialDateTime: DateTime(DateTime.now().year,
                              DateTime.now().day + 1, DateTime.now().month),
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          minimumDate: DateTime(DateTime.now().year,
                              DateTime.now().day, DateTime.now().month),
                          maximumDate: DateTime(2025, 31, 12),
                          showDayOfWeek: true,
                          onDateTimeChanged: (DateTime date) {
                            setState(() {
                              startingDate =
                                  '${date.day}/${date.month}/${date.year}';
                              startingSelectedDate = date;
                            });
                          },
                        ),
                      ),
                      borderRadius: BorderRadius.circular(7.0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(fixPadding * 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: secondaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (startingDate == '')
                                ? const Text(
                                    'Select auction starting date',
                                    style: grey14Medium,
                                  )
                                : Text(
                                    startingDate,
                                    style: white14Medium,
                                  ),
                            const Icon(
                              Icons.calendar_month,
                              color: greyColor,
                              size: 22.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Starting Date End

                    heightSpace,
                    heightSpace,

                    // Ending Date Start
                    const Text(
                      'Ending Date',
                      style: white14Bold,
                    ),
                    heightSpace,
                    InkWell(
                      onTap: () => _showDialog(
                        CupertinoDatePicker(
                          initialDateTime: startingSelectedDate,
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          // This shows day of week alongside day of month
                          showDayOfWeek: true,
                          // This is called when the user changes the date.
                          onDateTimeChanged: (DateTime date) {
                            setState(() {
                              endingDate =
                                  '${date.day}/${date.month}/${date.year}';
                            });
                          },
                          minimumDate: startingSelectedDate,
                          maximumDate: DateTime(2025, 31, 12),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(7.0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(fixPadding * 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: secondaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (endingDate == '')
                                ? const Text(
                                    'Select auction ending date',
                                    style: grey14Medium,
                                  )
                                : Text(
                                    endingDate,
                                    style: white14Medium,
                                  ),
                            const Icon(
                              Icons.calendar_month,
                              color: greyColor,
                              size: 22.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Endinng Date End
                  ],
                ),
              ),
            ],
          ),
          publishButton(),
        ],
      ),
    );
  }

  publishButton() {
    return SizedBox(
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
                    child: const PublishSuccess()));
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
              'Publish',
              style: white16Bold,
            ),
          ),
        ),
      ),
    );
  }
}
