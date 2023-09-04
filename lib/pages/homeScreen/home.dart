import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/controllers/auth.dart';
import 'package:nft_market_place/controllers/main_controller.dart';
import 'package:nft_market_place/controllers/marketplace_controller.dart';
import 'package:nft_market_place/models/offerItem.dart';
import 'package:nft_market_place/pages/bottom_bar.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:nft_market_place/utils/utils.dart';
import 'package:nft_market_place/widget/column_builder.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MarketplaceController marketplaceController =
      Get.find<MarketplaceController>();
  final MainController mainController = Get.find<MainController>();
  final AuthController authController = Get.find<AuthController>();
  final liveAuctionList = [
    {
      'name': 'Spacio',
      'image': 'assets/nft/nft_1.png',
      'owner': 'samantha',
      'price': '2.20 ETH',
      'time': '4h 16m',
      'favorite': false
    },
    {
      'name': '3D Cube',
      'image': 'assets/nft/nft_2.png',
      'owner': 'subeworld',
      'price': '6.90 ETH',
      'time': '6h 49m',
      'favorite': false
    },
    {
      'name': 'Monaro',
      'image': 'assets/nft/nft_3.png',
      'owner': 'greeicy',
      'price': '18.90 ETH',
      'time': '8h 29m',
      'favorite': false
    },
    {
      'name': 'Spacio',
      'image': 'assets/nft/nft_1.png',
      'owner': 'samantha',
      'price': '2.20 ETH',
      'time': '4h 16m',
      'favorite': false
    },
    {
      'name': '3D Cube',
      'image': 'assets/nft/nft_2.png',
      'owner': 'subeworld',
      'price': '6.90 ETH',
      'time': '6h 49m',
      'favorite': false
    },
    {
      'name': 'Monaro',
      'image': 'assets/nft/nft_3.png',
      'owner': 'greeicy',
      'price': '18.90 ETH',
      'time': '8h 29m',
      'favorite': false
    }
  ];

  final topCreatorList = [
    {
      'name': 'CryptoPenks',
      'image': 'assets/creator/creator_1.png',
      'earning': '24.564 ETH'
    },
    {
      'name': 'Azuka',
      'image': 'assets/creator/creator_2.png',
      'earning': '94.752 ETH'
    },
    {
      'name': 'Moroson',
      'image': 'assets/creator/creator_3.png',
      'earning': '74.934 ETH'
    },
    {
      'name': 'Mary Akinyi',
      'image': 'assets/creator/creator_4.png',
      'earning': '155.592 ETH'
    },
    {
      'name': 'Jane Waw',
      'image': 'assets/creator/creator_5.png',
      'earning': '90.546 ETH'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          header(),
          slider(),
          // heightSpace,
          // liveAuctions(),
          heightSpace,
          topCreator(),
          heightSpace,
          following(),
        ],
      ),
    );
  }

  header() {
    return Container(
      width: double.infinity,
      height: 100.0,
      padding: const EdgeInsets.all(fixPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    // image: const DecorationImage(
                    //   image: AssetImage('assets/user.png'),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: Obx(() => authController.person.value.profileImage !=
                          null
                      ? ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(48), // Image radius
                            child: Image.network(
                              '${mainController.apiUrl}/users/avatars/${authController.person.value.profileImage}',
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.no_accounts,
                                  size: 70,
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : authController.person.value.inMemoryProfileImage != null
                          ? ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(48), // Image radius
                                child: Image.memory(
                                  authController
                                      .person.value.inMemoryProfileImage!
                                      .readAsBytesSync(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(48), // Image radius
                                child: const Icon(
                                  Icons.wallpaper,
                                  size: 50,
                                  color: primaryColor,
                                ),
                              ),
                            ))),
              widthSpace,
              widthSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Utils.trimp(
                        '${authController.person.value.firstName} ${authController.person.value.lastName}'),
                    style: grey14Medium,
                  ),
                  heightSpace,
                  Text(
                    Utils.trimp('${authController.person.value.accountType}'),
                    style: grey10Regular,
                  ),
                  heightSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   'assets/white-eth.png',
                      //   height: 20.0,
                      //   fit: BoxFit.cover,
                      // ),
                      width5Space,
                      Text(
                        '\$ ${authController.person.value.wallet!.currentBalance.toString()}',
                        style: black22Bold,
                      ),
                    ],
                  ),
                ],
              ),
            ],
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
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: secondaryColor,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icons/bell_pin.png',
                width: 24.0,
                height: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  slider() {
    return Obx(() => marketplaceController.offerItemList.isNotEmpty
        ? CarouselSlider(
            items: marketplaceController.offerItemList.map((offerItem) {
              return Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const CreatorProfile())),
                    borderRadius: BorderRadius.circular(10.0),
                    child: sliderItem(offerItem),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: 170.0,
              autoPlay: true,
            ),
          )
        : const Column(
            children: [
              Text(
                'No Items',
                style: TextStyle(color: blackColor),
              )
            ],
          ));
  }

  sliderItem(OfferItem offerItem) {
    return Container(
      padding: const EdgeInsets.only(bottom: fixPadding * 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(
              '${marketplaceController.apiUrl}/offer-items/offerItems/${offerItem.images![0].filename}'),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(
                  fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: primaryColor,
              ),
              child: Text(
                '${offerItem.itemName.toString().capitalize}',
                style: black16Bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  topCreator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Top Stylists',
                style: black18Bold,
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  'See all',
                  style: black14Medium,
                ),
              ),
            ],
          ),
        ),
        Obx(() => marketplaceController.topProviders.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                height: 60.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: marketplaceController.topProviders.length,
                    itemBuilder: (context, index) {
                      final item = marketplaceController.topProviders[index];
                      return Padding(
                        padding: (index == 0)
                            ? const EdgeInsets.fromLTRB(
                                fixPadding * 2.0, 0, fixPadding, 0)
                            : (index ==
                                    marketplaceController.topProviders.length -
                                        1)
                                ? const EdgeInsets.only(right: fixPadding * 2.0)
                                : const EdgeInsets.only(right: fixPadding),
                        child: InkWell(
                          onTap: () {
                            marketplaceController.selectedProvider.value = item;
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: const CreatorProfile()));
                          },
                          borderRadius: BorderRadius.circular(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              item.provider.profileImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(
                                            60), // Image radius
                                        child: Image.network(
                                          '${marketplaceController.apiUrl}/users/avatars/${item.provider.profileImage}',
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
                                          height: 60.0,
                                          width: 60.0,
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
                                    '${item.provider.firstName.capitalize} ${item.provider.firstName.capitalize}',
                                    style: primaryColor16Bold,
                                  ),
                                  height5Space,
                                  Text(
                                    'Orders ${item.provider.orders!.length.toString()}',
                                    style: black14Medium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            : const Center(
                child: Column(
                  children: [Text('No Stylist found')],
                ),
              ))
      ],
    );
  }

  following() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Padding(
        //   padding: EdgeInsets.all(fixPadding * 2.0),
        //   child: Text(
        //     'Feed',
        //     style: black18Bold,
        //   ),
        // ),
        // item.offerItems![0].createdDate != null
        //     ? Text(
        //         '${item.offerItems![-1].createdDate} ago',
        //         style: black16Medium,
        //       )
        //     :
        height5Space,
        height5Space,
        Padding(
          padding: const EdgeInsets.fromLTRB(
              fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
          child: Obx(() => marketplaceController.offerItemList.isNotEmpty
              ? ColumnBuilder(
                  itemCount: marketplaceController.offerItemList.length,
                  itemBuilder: (context, index) {
                    final offerItem =
                        marketplaceController.offerItemList[index];
                    return Padding(
                      padding: (index == 0)
                          ? const EdgeInsets.all(0.0)
                          : const EdgeInsets.only(top: fixPadding * 2.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {
                          marketplaceController.selectedOfferItem.value =
                              offerItem;
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const NFTScreen()));
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black.withOpacity(0.1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 250.0,
                                width: double.infinity,
                                padding: const EdgeInsets.all(fixPadding * 1.5),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10.0)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${marketplaceController.apiUrl}/offer-items/offerItems/${offerItem.images![0].filename}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: offerItem.provider!.profileImage !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: SizedBox.fromSize(
                                                size: const Size.fromRadius(
                                                    40), // Image radius
                                                child: Image.network(
                                                  '${marketplaceController.apiUrl}/offer-items/offerItems/${offerItem.images![0].filename}',
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
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
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(
                                                      Icons.no_accounts,
                                                      size: 70,
                                                    );
                                                  },
                                                  height: 40.0,
                                                  width: 40.0,
                                                  fit: BoxFit.cover,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: const Icon(
                                                Icons.wallpaper,
                                                size: 60,
                                                color: primaryColor,
                                              ),
                                            ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () =>
                                              saveToCollectionBottomsheet(),
                                          icon: Icon(
                                            (offerItem.provider!.onlineStatus ==
                                                    true)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: primaryColor,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.share,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(fixPadding * 1.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '@${offerItem.provider!.lastName}',
                                          style: primaryColor16Medium,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              fixPadding * 1.5,
                                              fixPadding * 0.7,
                                              fixPadding * 1.5,
                                              fixPadding * 0.7),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.0,
                                                color: primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            '${Utils.getTimeDifference(DateTime.parse(offerItem.createdDate.toString()))}',
                                            style: primaryColor14Medium,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.shopping_bag_sharp,
                                                color: primaryColor,
                                              ),
                                            ),
                                            // width5Space,
                                            const Text(
                                              // '${offerItem.provider!.orders!.length}',
                                              '0',
                                              style: primaryColor16Bold,
                                            ),
                                          ],
                                        )
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
              : const Center(
                  child: Column(
                    children: [Text('No Stylist found')],
                  ),
                )),
        ),
      ],
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
                        color: blackColor,
                      ),
                      // ignore: prefer_const_constructors
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
                          color: blackColor,
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
