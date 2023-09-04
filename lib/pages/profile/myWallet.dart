// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/widget/column_builder.dart';

class MyWallet extends StatelessWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recentActivityList = [
      {
        'image': 'assets/creator_profile/nft_1.png',
        'name': 'Wild Rhinoceros',
        'price': '1.259 ETH',
        'date': 'Feb 21, 2021',
        'time': '03:05 pm',
        'type': 'Sell'
      },
      {
        'image': 'assets/creator_profile/nft_2.png',
        'name': 'Landscape',
        'price': '1.589 ETH',
        'date': 'Aug 18, 2021',
        'time': '04:12 pm',
        'type': 'Buy'
      },
      {
        'image': 'assets/creator_profile/nft_3.png',
        'name': 'Monaro',
        'price': '0.258 ETH',
        'date': 'Nov 4, 2021',
        'time': '12:13 am',
        'type': 'Buy'
      },
      {
        'image': 'assets/creator_profile/nft_4.png',
        'name': 'Painting',
        'price': '1.255 ETH',
        'date': 'Jan 11, 2021',
        'time': '01:49 pm',
        'type': 'Sell'
      },
      {
        'image': 'assets/creator_profile/nft_1.png',
        'name': 'Wild Rhinoceros',
        'price': '1.259 ETH',
        'date': 'Feb 21, 2021',
        'time': '03:05 pm',
        'type': 'Sell'
      },
      {
        'image': 'assets/creator_profile/nft_2.png',
        'name': 'Landscape',
        'price': '1.589 ETH',
        'date': 'Aug 18, 2021',
        'time': '04:12 pm',
        'type': 'Buy'
      },
      {
        'image': 'assets/creator_profile/nft_3.png',
        'name': 'Monaro',
        'price': '0.258 ETH',
        'date': 'Nov 4, 2021',
        'time': '12:13 am',
        'type': 'Buy'
      },
      {
        'image': 'assets/creator_profile/nft_4.png',
        'name': 'Painting',
        'price': '1.255 ETH',
        'date': 'Jan 11, 2021',
        'time': '01:49 pm',
        'type': 'Sell'
      }
    ];

    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        centerTitle: false,
        titleSpacing: 0.0,
        title: const Text(
          'My Wallet',
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
          walletBalance(),
          recentActivity(context, recentActivityList),
        ],
      ),
    );
  }

  walletBalance() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(fixPadding * 2.0),
      padding: const EdgeInsets.all(fixPadding * 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coinbase Wallet',
                    style: white12Bold,
                  ),
                  height5Space,
                  Text(
                    '29.005 ETH',
                    style: white18Bold,
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.more_vert,
                  color: whiteColor,
                ),
              ),
            ],
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '0xd010d2ax48...0ljkof4fgd',
                style: white14Normal,
              ),
              width5Space,
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.copy,
                  color: whiteColor,
                  size: 18.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  recentActivity(context, activityList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Text(
            'Recent Activities',
            style: white16Bold,
          ),
        ),
        ColumnBuilder(
          itemCount: activityList.length,
          itemBuilder: (context, index) {
            final item = activityList[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(fixPadding * 2.0,
                      fixPadding * 1.5, fixPadding * 2.0, fixPadding * 1.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: Image.asset(
                          item['image']!,
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      widthSpace,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  item['name']!,
                                  style: white14Bold,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    (item['type'] == 'Sell')
                                        ? const Text(
                                            'Sell',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : const Text(
                                            'Buy',
                                            style: primaryColor14Medium,
                                          ),
                                    width5Space,
                                    Icon(
                                      (item['type'] == 'Sell')
                                          ? Icons.call_made_outlined
                                          : Icons.call_received,
                                      color: (item['type'] == 'Sell')
                                          ? Colors.red
                                          : primaryColor,
                                      size: 18.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            height5Space,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  item['price'],
                                  style: white12Medium,
                                ),
                                Text(
                                  '${item['date']} at ${item['time']}',
                                  style: grey12Normal,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                (index != activityList.length - 1)
                    ? devider()
                    : const SizedBox(
                        width: 0.0,
                        height: 0.0,
                      ),
              ],
            );
          },
        ),
      ],
    );
  }

  devider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      height: 0.7,
      color: greyColor.withOpacity(0.55),
    );
  }
}
