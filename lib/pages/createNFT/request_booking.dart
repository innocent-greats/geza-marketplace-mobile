// ignore_for_file: file_names, prefer_const_constructors
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/controllers/marketplace_controller.dart';
import 'package:nft_market_place/pages/createNFT/bookingSucces.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:page_transition/page_transition.dart';

class RequestBooking extends StatefulWidget {
  const RequestBooking({Key? key}) : super(key: key);

  @override
  State<RequestBooking> createState() => _RequestBookingState();
}

class _RequestBookingState extends State<RequestBooking> {
  final MarketplaceController marketplaceController =
      Get.find<MarketplaceController>();
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
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0.0,
        title: const Text(
          'Stylist Booking',
          style: black18Bold,
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
          color: whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                width: (width - fixPadding * 9.0) / 2.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: (fixPrice)
                      ? primaryColor.withOpacity(1)
                      : primaryColor.withOpacity(0.1),
                ),
                child: Text(
                  '@${marketplaceController.selectedOfferItem.value.provider!.firstName}',
                  style: (fixPrice) ? white16Bold : black16Bold,
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
                width: (width - fixPadding * 9.0) / 2.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: (auction)
                      ? primaryColor.withOpacity(1)
                      : primaryColor.withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    width5Space,
                    Icon(
                      Icons.broadcast_on_home,
                      color: (auction) ? whiteColor : blackColor,
                      size: 22.0,
                    ),
                    width5Space,
                    width5Space,
                    Text(
                      '@broadcast',
                      style: (auction) ? white16Medium : black14Medium,
                    ),
                  ],
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
                      style: black14Bold,
                    ),
                    heightSpace,
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: whiteColor,
                      ),
                      child: const TextField(
                        style: black14Medium,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: blackColor, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: blackColor, width: 1)),
                          contentPadding: EdgeInsets.only(left: 20.0),
                          hintText: 'What is your offer price?',
                          hintStyle: grey14Medium,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    heightSpace,
                    heightSpace,
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
                      style: black14Bold,
                    ),
                    heightSpace,
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: whiteColor,
                      ),
                      child: const TextField(
                        style: black14Medium,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: blackColor, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: blackColor, width: 1)),
                          contentPadding: EdgeInsets.only(left: 20.0),
                          hintText: 'What is your offer price?',
                          hintStyle: grey14Medium,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    heightSpace,
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
                      'Booking available Date',
                      style: black14Bold,
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
                          color: primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (startingDate == '')
                                ? const Text(
                                    'Select earliest date',
                                    style: white14Medium,
                                  )
                                : Text(
                                    startingDate,
                                    style: white14Medium,
                                  ),
                            const Icon(
                              Icons.calendar_month,
                              color: blackColor,
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
                      'Latest Date',
                      style: black14Bold,
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
                          color: primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (endingDate == '')
                                ? const Text(
                                    'Select possible latest date',
                                    style: white14Medium,
                                  )
                                : Text(
                                    endingDate,
                                    style: white14Medium,
                                  ),
                            const Icon(
                              Icons.calendar_month,
                              color: blackColor,
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
                    child: BookingSuccess()));
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
              style: black16Bold,
            ),
          ),
        ),
      ),
    );
  }
}
