// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/controllers/marketplace_controller.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:nft_market_place/utils/utils.dart';
import 'package:nft_market_place/widget/column_builder.dart';
import 'package:page_transition/page_transition.dart';

class CreatorProfile extends StatefulWidget {
  const CreatorProfile({Key? key}) : super(key: key);

  @override
  State<CreatorProfile> createState() => _CreatorProfileState();
}

class _CreatorProfileState extends State<CreatorProfile> {
  final MarketplaceController marketplaceController =
      Get.find<MarketplaceController>();
  bool follow = false;

  final recentlyListedList = [
    {
      'name': 'Wild Rhinoceros',
      'owner': 'cryptopenks',
      'image': 'assets/creator_profile/nft_1.png',
      'price': '2.20 ETH',
      'time': '4h 16m'
    },
    {
      'name': 'Painting',
      'owner': 'cryptopenks',
      'image': 'assets/creator_profile/nft_2.png',
      'price': '2.80 ETH',
      'time': '8h 19m'
    },
    {
      'name': 'Monaro',
      'owner': 'cryptopenks',
      'image': 'assets/creator_profile/nft_3.png',
      'price': '6.15 ETH',
      'time': '9h 05m'
    },
    {
      'name': 'Landscape',
      'owner': 'cryptopenks',
      'image': 'assets/creator_profile/nft_4.png',
      'price': '5.60 ETH',
      'time': '3h 02m'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: blackColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: whiteColor,
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              creatorProfile(),
              recentlyListed(),
            ],
          ),
        ),
      ),
    );
  }

  creatorProfile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 280.0,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: marketplaceController
                      .selectedProvider.value.offerItems.isNotEmpty
                  ? AssetImage('assets/creator_profile/bg_image.png')
                  : AssetImage('assets/creator_profile/bg_image.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: 280.0,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(1.0),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(fixPadding * 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black.withOpacity(0.1),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new,
                          size: 24.0, color: blackColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          marketplaceController.selectedProvider.value.provider
                                      .profileImage !=
                                  null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(35.0),
                                  child: Image.network(
                                    '${marketplaceController.apiUrl}/users/avatars/${marketplaceController.selectedProvider.value.provider.profileImage}',
                                    width: 70.0,
                                    height: 70.0,
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
                                '${marketplaceController.selectedProvider.value.provider.firstName} ${marketplaceController.selectedProvider.value.provider.lastName}'
                                    .toUpperCase(),
                                style: black16Bold,
                              ),
                              height5Space,
                              Text(
                                Utils.trimp(
                                    '@${marketplaceController.selectedProvider.value.provider.tradingAs} '),
                                style: grey10Regular,
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            follow = !follow;
                          });
                        },
                        borderRadius: BorderRadius.circular(7.0),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(
                              fixPadding, fixPadding, fixPadding, fixPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: (follow) ? Colors.transparent : primaryColor,
                            border: Border.all(
                                width: 1.0,
                                color: (follow) ? blackColor : primaryColor),
                          ),
                          child: Text(
                            (follow) ? 'UnSubscribe' : 'Subscribe',
                            style: const TextStyle(
                              color: blackColor,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(fixPadding * 2.0),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ullamcorper non sit pharetra diam eget.',
            style: grey14Normal,
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(
                    fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(width: 1.0, color: greyColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      marketplaceController
                                  .selectedProvider.value.provider.wallet !=
                              null
                          ? marketplaceController.selectedProvider.value
                              .provider.wallet!.walletAddress!
                              .substring(0, 10)
                          : '',
                      style: grey10Normal,
                    ),
                    width5Space,
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.copy,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/social/facebook.png'),
                  Image.asset('assets/icons/social/instagram.png'),
                  Image.asset('assets/icons/social/twitter.png'),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(fixPadding * 2.0),
          child: Container(
            padding: const EdgeInsets.all(fixPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(color: primaryColor, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '10',
                      style: black18Bold,
                    ),
                    heightSpace,
                    Text(
                      'Styles',
                      style: grey14Medium,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '6.3K',
                      style: black18Bold,
                    ),
                    heightSpace,
                    Text(
                      'Book/WK',
                      style: grey14Medium,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.monetization_on_outlined),
                        width5Space,
                        Text(
                          '92',
                          style: black18Bold,
                        ),
                      ],
                    ),
                    heightSpace,
                    Text(
                      'Avg Earning',
                      style: grey14Medium,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '391.6K',
                      style: black18Bold,
                    ),
                    heightSpace,
                    Text(
                      'Tags',
                      style: grey14Medium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  recentlyListed() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recently Listed  (${marketplaceController.selectedProvider.value.offerItems.length})',
                style: black16Bold,
              ),
              marketplaceController.selectedProvider.value.offerItems.isNotEmpty
                  ? ColumnBuilder(
                      itemCount: marketplaceController
                          .selectedProvider.value.offerItems.length,
                      itemBuilder: (context, index) {
                        final offerItem = marketplaceController
                            .selectedProvider.value.offerItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: fixPadding * 2.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () => Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: const NFTScreen())),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.black.withOpacity(0.1),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 180.0,
                                    padding:
                                        const EdgeInsets.all(fixPadding * 1.5),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10.0),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          '${marketplaceController.apiUrl}/offer-items/offerItems/${offerItem.images![0].filename}',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              fixPadding * 2.0,
                                              fixPadding * 0.8,
                                              fixPadding * 2.0,
                                              fixPadding * 0.8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            color: primaryColor,
                                          ),
                                          child: Text(
                                            '${Utils.getTimeDifference(DateTime.parse(offerItem.createdDate.toString()))}',
                                            style: black16Medium,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () =>
                                                  saveToCollectionBottomsheet(),
                                              icon: const Icon(
                                                Icons.favorite_border,
                                                color: blackColor,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.share,
                                                color: blackColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.all(fixPadding * 1.5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          offerItem.itemName.toString(),
                                          style: black16Bold,
                                        ),
                                        height5Space,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '@${offerItem.provider!.lastName.toString()}',
                                              style: grey16Medium,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/black-eth.png',
                                                  height: 20.0,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                                width5Space,
                                                Text(
                                                  offerItem.minimumPrice
                                                      .toString(),
                                                  style: black16Bold,
                                                ),
                                              ],
                                            ),
                                          ],
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
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No Styles added in this account',
                          style: black14Bold,
                        ),
                      ),
                    ),
            ],
          )),
    );
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
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
