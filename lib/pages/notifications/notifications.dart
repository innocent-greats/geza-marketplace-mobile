import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/widget/column_builder.dart';

class Notifaications extends StatefulWidget {
  const Notifaications({Key? key}) : super(key: key);

  @override
  State<Notifaications> createState() => _NotifaicationsState();
}

class _NotifaicationsState extends State<Notifaications> {
  List? notificationsList = [
    {
      'date': 'Today, March 15 2022',
      'data': [
        {
          'title': 'Place a bid Success!',
          'description':
              'Lorem ipsum dolor sit amet, consectetur elit. Sed etiam faucibus feugiat.',
          'type': 'success'
        },
        {
          'title': 'Payment Failed!',
          'description':
              'Lorem ipsum dolor sit amet, consectetur elit. Sed etiam faucibus feugiat.',
          'type': 'fail'
        },
      ]
    },
    {
      'date': 'Yesterday, March 14 2022',
      'data': [
        {
          'title': 'New NFTs for you!',
          'description':
              'Lorem ipsum dolor sit amet, consectetur elit. Sed etiam faucibus feugiat.',
          'type': 'notify'
        },
      ]
    },
    {
      'date': 'Monday, March 13 2022',
      'data': [
        {
          'title': 'Place a bid Success!',
          'description':
              'Lorem ipsum dolor sit amet, consectetur elit. Sed etiam faucibus feugiat.',
          'type': 'success'
        },
      ]
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blackColor,
        centerTitle: false,
        title: const Text(
          'Notifications',
          style: white18Bold,
        ),
      ),
      body: (notificationsList!.isEmpty)
          ? emptyNotification()
          : notificationContent(),
    );
  }

  emptyNotification() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/notification_empty.png',
            width: 100.0,
          ),
          const Text(
            'No new notifications yet!',
            style: white14Medium,
          ),
        ],
      ),
    );
  }

  notificationContent() {
    return ListView.builder(
        itemCount: notificationsList!.length,
        itemBuilder: (context, index) {
          final item = notificationsList![index];
          return Padding(
            padding: (index == 0)
                ? const EdgeInsets.only(
                    top: fixPadding * 2.0, bottom: fixPadding * 2.0)
                : const EdgeInsets.only(
                    top: fixPadding, bottom: fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: Text(
                    item['date'],
                    style: white16Medium,
                  ),
                ),
                ColumnBuilder(
                  itemCount: item['data']!.length,
                  itemBuilder: (context, dataIndex) {
                    final dataItem = item['data'][dataIndex];
                    return Padding(
                      padding: const EdgeInsets.only(top: fixPadding),
                      child: Dismissible(
                        background: Container(
                          color: Colors.red,
                        ),
                        key: Key('$dataItem'),
                        onDismissed: (direction) {
                          setState(() {
                            item['data'].removeAt(dataIndex);
                          });

                          if (item['data']!.length == 0) {
                            setState(() {
                              notificationsList!.removeAt(index);
                            });
                          }

                          // Then show a snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("${dataItem['title']} dismissed")));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(fixPadding * 2.0),
                          margin: const EdgeInsets.symmetric(
                              horizontal: fixPadding * 2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: secondaryColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 60.0,
                                height: 60.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: (dataItem['type'] == 'success')
                                      ? primaryColor
                                      : (dataItem['type'] == 'fail')
                                          ? Colors.red
                                          : Colors.orange,
                                ),
                                child: (dataItem['type'] == 'success')
                                    ? const Icon(Icons.check, color: whiteColor)
                                    : (dataItem['type'] == 'fail')
                                        ? const Icon(Icons.close,
                                            color: whiteColor)
                                        : const Icon(Icons.notifications,
                                            color: whiteColor),
                              ),
                              widthSpace,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataItem['title'],
                                      style: white16Medium,
                                    ),
                                    height5Space,
                                    Text(
                                      dataItem['description'],
                                      style: grey14Normal,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}
