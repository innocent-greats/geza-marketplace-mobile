import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/controllers/marketplace_controller.dart';
import 'package:nft_market_place/pages/createNFT/request_booking.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:nft_market_place/utils/extensions/string.dart';
import 'package:nft_market_place/utils/utils.dart';
import 'package:nft_market_place/widget/column_builder.dart';
import 'package:page_transition/page_transition.dart';

class NFTScreen extends StatefulWidget {
  const NFTScreen({Key? key}) : super(key: key);

  @override
  State<NFTScreen> createState() => _NFTScreenState();
}

class _NFTScreenState extends State<NFTScreen> {
  final MarketplaceController marketplaceController =
      Get.find<MarketplaceController>();
  int eth = 1;
  bool terms = false;

  final bidHistoryList = [
    {
      'image': 'assets/creator/creator_1.png',
      'name': 'Crypto Penks',
      'dateTime': 'Feb 21, 2021 at 03:05 pm',
      'price': '29.005 ETH'
    },
    {
      'image': 'assets/creator/creator_2.png',
      'name': 'Azuka',
      'dateTime': 'Jan 1, 2021 at 01:49 pm',
      'price': '28.002 ETH'
    },
    {
      'image': 'assets/creator/creator_3.png',
      'name': 'Moroson',
      'dateTime': 'Aug 18, 2021 at 04:12 pm',
      'price': '29.008 ETH'
    },
    {
      'image': 'assets/creator/creator_4.png',
      'name': 'Mary Akinyl',
      'dateTime': 'July 18, 2021 at 05:35 pm',
      'price': '29.005 ETH'
    },
    {
      'image': 'assets/creator/creator_5.png',
      'name': 'Jane Wewuds',
      'dateTime': 'May 13, 2021 at 08:05 pm',
      'price': '27.009 ETH'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        centerTitle: false,
        titleSpacing: 0.0,
        title: Obx(() => Text(
              marketplaceController.selectedOfferItem.value.itemName!
                  .toUpperCase(),
              style: black18Bold,
            )),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: blackColor,
          ),
          color: secondaryColor,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share_outlined,
              color: blackColor,
            ),
          ),
          IconButton(
            onPressed: () => saveToCollectionBottomsheet(),
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding),
          child: InkWell(
            onTap: () => Get.to(const RequestBooking()),
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
                'Request Booking',
                style: black16Bold,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          image(),
          aboutNFT(),
          historyOfBid(),
        ],
      ),
    );
  }

  image() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Obx(() => ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              marketplaceController.selectedOfferItemImagePath.value != ''
                  ? '${marketplaceController.apiUrl}/offer-items/offerItems/${marketplaceController.selectedOfferItemImagePath.value.toString()}'
                  : '${marketplaceController.apiUrl}/offer-items/offerItems/${marketplaceController.selectedOfferItem.value.images![0].filename}',
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          )),
    );
  }

  aboutNFT() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                marketplaceController.selectedOfferItem.value.itemName!
                    .toUpperCase(),
                style: black16Bold,
              ),
              Container(
                padding: const EdgeInsets.all(fixPadding * 0.7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    width: 1.0,
                    color: primaryColor,
                  ),
                ),
                child: Text(
                  '${Utils.getTimeDifference(DateTime.parse(marketplaceController.selectedOfferItem.value.createdDate.toString()))}',
                  style: primaryColor14Medium,
                ),
              ),
            ],
          ),
          heightSpace,
          offerItemImages(),
          heightSpace,
          const Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: grey14Normal,
            textAlign: TextAlign.justify,
          ),
          heightSpace,
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  marketplaceController
                              .selectedOfferItem.value.provider!.profileImage !=
                          null
                      ? Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${marketplaceController.apiUrl}/users/avatars/${marketplaceController.selectedOfferItem.value.provider!.profileImage}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: const Icon(
                            Icons.wallpaper,
                            size: 60,
                            color: primaryColor,
                          ),
                        ),
                  widthSpace,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${marketplaceController.selectedOfferItem.value.provider!.firstName} ${marketplaceController.selectedOfferItem.value.provider!.lastName}',
                        style: black16Bold,
                      ),
                      height5Space,
                      Text(
                        marketplaceController.selectedOfferItem.value.provider!
                                    .tradingAs !=
                                null
                            ? Utils.trimp(marketplaceController
                                .selectedOfferItem.value.provider!.tradingAs!)
                            : '',
                        style: grey14Normal,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_outline,
                    size: 20,
                    color: primaryColor,
                  ),
                  width5Space,
                  Text(
                    'Likes ${marketplaceController.selectedOfferItem.value.orders!.length.toString()}',
                    style: primaryColor16Bold,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  offerItemImages() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height5Space,
        Obx(() => marketplaceController.selectedOfferItem.value.images!.length >
                1
            ? SizedBox(
                width: double.infinity,
                height: 60.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: marketplaceController
                        .selectedOfferItem.value.images!.length,
                    itemBuilder: (context, index) {
                      final item = marketplaceController
                          .selectedOfferItem.value.images![index];
                      return Padding(
                        padding: (index == 0)
                            ? const EdgeInsets.fromLTRB(
                                fixPadding * 2.0, 0, fixPadding, 0)
                            : (index ==
                                    marketplaceController.selectedOfferItem
                                            .value.images!.length -
                                        1)
                                ? const EdgeInsets.only(right: fixPadding * 2.0)
                                : const EdgeInsets.only(right: fixPadding),
                        child: InkWell(
                          onTap: () {
                            marketplaceController
                                .onChangeImage(item.filename.toString());
                          },
                          borderRadius: BorderRadius.circular(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              item.filename != null
                                  ? ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(
                                            30), // Image radius
                                        child: Image.network(
                                          '${marketplaceController.apiUrl}/offer-items/offerItems/${item.filename}',
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.no_accounts,
                                              size: 70,
                                              color: primaryColor,
                                            );
                                          },
                                          height: 80.0,
                                          width: 80.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: const Icon(
                                        Icons.wallpaper,
                                        size: 60,
                                        color: primaryColor,
                                      ),
                                    ),
                              widthSpace,
                            ],
                          ),
                        ),
                      );
                    }),
              )
            : const Column())
      ],
    );
  }

  historyOfBid() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Opions',
            style: black16Bold,
          ),
          heightSpace,
          ColumnBuilder(
            itemCount: marketplaceController.topProviders.length,
            itemBuilder: (context, index) {
              final item = marketplaceController.topProviders[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: fixPadding * 2.0),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          item.provider.profileImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: Image.network(
                                    '${marketplaceController.apiUrl}/users/avatars/${item.provider.profileImage}',
                                    height: 50.0,
                                    width: 50.0,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: const Icon(
                                    Icons.wallpaper,
                                    size: 60,
                                    color: primaryColor,
                                  ),
                                ),
                          widthSpace,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${item.provider.firstName.capitalize} ${item.provider.firstName.capitalize}',
                                style: black14Bold,
                              ),
                              height5Space,
                              Text(
                                '${Utils.getTimeDifference(DateTime.parse(item.provider.createdDate.toString()))}',
                                style: grey14Normal,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Text(
                      //   item['price']!,
                      //   style: primaryColor14Medium,
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  placeABidBottomsheet() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(fixPadding * 2.0),
                  decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          'Place a Bid',
                          style: black16Bold,
                        ),
                      ),
                      heightSpace,
                      heightSpace,
                      RichText(
                        text: const TextSpan(
                          text: 'You are about to place a bid for ',
                          style: grey14Normal,
                          children: <TextSpan>[
                            TextSpan(
                              text: '3D Cube',
                              style: black14Bold,
                            ),
                          ],
                        ),
                      ),
                      heightSpace,
                      RichText(
                        text: const TextSpan(
                          text: 'by ',
                          style: grey14Normal,
                          children: <TextSpan>[
                            TextSpan(
                              text: '@cryptopenks',
                              style: black14Bold,
                            ),
                          ],
                        ),
                      ),
                      heightSpace,
                      heightSpace,
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(fixPadding * 2.0,
                            fixPadding, fixPadding * 2.0, fixPadding),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: Colors.black.withOpacity(0.07)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                if (eth > 1) {
                                  setState(() {
                                    eth = eth - 1;
                                  });
                                }
                              },
                              child: Container(
                                width: 36.0,
                                height: 36.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.0),
                                  border:
                                      Border.all(width: 1.5, color: blackColor),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: blackColor,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/blue-eth.png',
                                  height: 30.0,
                                  fit: BoxFit.fitHeight,
                                ),
                                widthSpace,
                                Text(
                                  '$eth ETH',
                                  style: primaryColor16Bold,
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  eth = eth + 1;
                                });
                              },
                              child: Container(
                                width: 36.0,
                                height: 36.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.0),
                                  border:
                                      Border.all(width: 1.5, color: blackColor),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: fixPadding * 2.0),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          'Balance: 29.005 ETH',
                          style: black14Bold,
                        ),
                      ),
                      const DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashGapLength: 5.0,
                        dashColor: greyColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: fixPadding * 2.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'You will pay',
                                  style: grey14Normal,
                                ),
                                Text(
                                  '1.2 ETH',
                                  style: black14Bold,
                                ),
                              ],
                            ),
                            heightSpace,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Service fee',
                                  style: grey14Normal,
                                ),
                                Text(
                                  '0.012 ETH',
                                  style: black14Bold,
                                ),
                              ],
                            ),
                            heightSpace,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total payment',
                                  style: grey14Normal,
                                ),
                                Text(
                                  '1.212 ETH',
                                  style: primaryColor14Bold,
                                ),
                              ],
                            ),
                            heightSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      terms = !terms;
                                    });
                                  },
                                  child: Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                          width: 1.0,
                                          color: (terms)
                                              ? primaryColor
                                              : blackColor),
                                      color: (terms)
                                          ? primaryColor
                                          : Colors.transparent,
                                    ),
                                    alignment: Alignment.center,
                                    child: (terms)
                                        ? const Icon(
                                            Icons.check,
                                            color: blackColor,
                                            size: 15.0,
                                          )
                                        : const SizedBox(
                                            height: 0.0,
                                            width: 0.0,
                                          ),
                                  ),
                                ),
                                widthSpace,
                                const Expanded(
                                  child: Text(
                                    'By checking this box, I agree to NFT\'s Terms of Service',
                                    style: black12Medium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const ConnectWallet())),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(fixPadding * 1.5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: primaryColor,
                          ),
                          child: const Text(
                            'Place a Bid',
                            style: black16Bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  saveToCollectionBottomsheet() {
    collectionItem(image, name) {
      return Padding(
        padding: const EdgeInsets.only(bottom: fixPadding),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.asset(
                  image,
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              ),
              widthSpace,
              Text(
                name,
                style: black16Medium,
              ),
            ],
          ),
        ),
      );
    }

    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(fixPadding * 2.0),
              decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Save to Collections',
                    style: black16Bold,
                  ),
                  heightSpace,
                  heightSpace,
                  collectionItem('assets/collection/collection_1.png', 'Arts'),
                  collectionItem('assets/collection/collection_2.png', '3D'),
                  collectionItem('assets/collection/collection_3.png', 'Music'),
                  collectionItem(
                      'assets/collection/collection_4.png', 'Landscapes'),
                  heightSpace,
                  InkWell(
                    onTap: () => createCollectionDialog(),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(fixPadding * 1.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: primaryColor,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: blackColor,
                          ),
                          width5Space,
                          Text(
                            'Create new',
                            style: black16Bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  createCollectionDialog() {
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Give name to your collection',
                          style: black14Bold,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.close,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    heightSpace,
                    heightSpace,
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: const TextField(
                        style: black14Normal,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.0),
                          hintText: 'Enter collection name',
                          hintStyle: grey14Normal,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    heightSpace,
                    heightSpace,
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(fixPadding * 1.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: primaryColor,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Create collection',
                          style: black16Bold,
                        ),
                      ),
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
