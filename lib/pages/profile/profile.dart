import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/pages/screens.dart';
import 'package:nft_market_place/widget/column_builder.dart';
import 'package:page_transition/page_transition.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool recentlyListedTab = true;
  bool collectionsTab = false;
  bool activityTab = false;
  final recentlyListedList = [
    {
      'name': 'Wild Rhinoceros',
      'owner': 'cryptopenks',
      'image': 'assets/creator_profile/nft_1.png',
      'price': '2.20 ETH',
      'view': '269'
    },
    {
      'name': 'Painting',
      'owner': 'cryptopenks',
      'image': 'assets/creator_profile/nft_2.png',
      'price': '2.80 ETH',
      'view': '129'
    },
    {
      'name': 'Monaro',
      'owner': 'cryptopenks',
      'image': 'assets/creator_profile/nft_3.png',
      'price': '6.15 ETH',
      'view': '4048'
    },
    {
      'name': 'Landscape',
      'owner': 'cryptopenks',
      'image': 'assets/creator_profile/nft_4.png',
      'price': '5.60 ETH',
      'view': '5084'
    }
  ];

  final activityList = [
    {
      'image': 'assets/creator_profile/nft_1.png',
      'nftName': 'Wild Rhinoceros',
      'buyer': 'cryptopenks',
      'date': 'Feb 21, 2021',
      'time': '03:05 pm'
    },
    {
      'image': 'assets/creator_profile/nft_2.png',
      'nftName': 'Landscape',
      'buyer': 'subeworld',
      'date': 'Feb 19, 2021',
      'time': '12:52 pm'
    },
    {
      'image': 'assets/creator_profile/nft_3.png',
      'nftName': 'Monaro',
      'buyer': 'cubeworld',
      'date': 'Jan 29, 2021',
      'time': '10:23 pm'
    },
    {
      'image': 'assets/creator_profile/nft_4.png',
      'nftName': 'Painting',
      'buyer': 'cryptopenks',
      'date': 'Jan 24, 2021',
      'time': '08:09 pm'
    },
    {
      'image': 'assets/creator_profile/nft_5.png',
      'nftName': 'Wild Rhinoceros',
      'buyer': 'cryptopenks',
      'date': 'Jan 18, 2021',
      'time': '07:19 am'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: blackColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: blackColor,
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              userProfile(),
              tabBar(),
              (recentlyListedTab)
                  ? recentlyListed()
                  : (collectionsTab)
                      ? collectionsList()
                      : activity(),
            ],
          ),
        ),
      ),
    );
  }

  userProfile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 280.0,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/profile/profile_cover.png'),
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
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(1.0),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(fixPadding * 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Profile',
                        style: white18Bold,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const Settings()));
                        },
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.1),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/profile/setting.png',
                            width: 24.0,
                            height: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Hero(
                            tag: 'userImage',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35.0),
                              child: Image.asset(
                                'assets/user.png',
                                width: 70.0,
                                height: 70.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          widthSpace,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'JosephReese'.toUpperCase(),
                                style: white16Bold,
                              ),
                              height5Space,
                              const Text(
                                '@reesejoseph',
                                style: white14Medium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const EditProfile()));
                        },
                        borderRadius: BorderRadius.circular(7.0),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(fixPadding * 2.0,
                              fixPadding, fixPadding * 2.0, fixPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: primaryColor,
                            border: Border.all(width: 1.0, color: primaryColor),
                          ),
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 16.0,
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
                    const Text(
                      'ZqsdDsef6iuP0F00s',
                      style: grey14Normal,
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
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '10.0K',
                      style: white18Bold,
                    ),
                    heightSpace,
                    Text(
                      'Items',
                      style: grey14Medium,
                    ),
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '6.3K',
                      style: white18Bold,
                    ),
                    heightSpace,
                    Text(
                      'Owners',
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
                        Image.asset(
                          'assets/blue-eth.png',
                          width: 15.0,
                          fit: BoxFit.fitWidth,
                        ),
                        width5Space,
                        const Text(
                          '92',
                          style: white18Bold,
                        ),
                      ],
                    ),
                    heightSpace,
                    const Text(
                      'Floor Price',
                      style: grey14Medium,
                    ),
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '391.6K',
                      style: white18Bold,
                    ),
                    heightSpace,
                    Text(
                      'Traded',
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
                if (recentlyListedTab) {
                } else {
                  setState(() {
                    recentlyListedTab = true;
                    collectionsTab = false;
                    activityTab = false;
                  });
                }
              },
              borderRadius: BorderRadius.circular(7.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: fixPadding),
                width: (width - fixPadding * 5.0) / 3.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: (recentlyListedTab)
                      ? Colors.white.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: const Text(
                  'Recently Listed',
                  style: white14Bold,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (collectionsTab) {
                } else {
                  setState(() {
                    collectionsTab = true;
                    recentlyListedTab = false;
                    activityTab = false;
                  });
                }
              },
              borderRadius: BorderRadius.circular(7.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: fixPadding),
                width: (width - fixPadding * 5.0) / 3.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: (collectionsTab)
                      ? Colors.white.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: const Text(
                  'Collections',
                  style: white14Bold,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (activityTab) {
                } else {
                  setState(() {
                    activityTab = true;
                    collectionsTab = false;
                    recentlyListedTab = false;
                  });
                }
              },
              borderRadius: BorderRadius.circular(7.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: fixPadding),
                width: (width - fixPadding * 5.0) / 3.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: (activityTab)
                      ? Colors.white.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: const Text(
                  'Activity',
                  style: white14Bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  recentlyListed() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColumnBuilder(
            itemCount: recentlyListedList.length,
            itemBuilder: (context, index) {
              final item = recentlyListedList[index];
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
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 180.0,
                          padding: const EdgeInsets.all(fixPadding * 1.5),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                              image: AssetImage(item['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.favorite_border,
                                size: 20.0,
                                color: whiteColor,
                              ),
                              width5Space,
                              Text(
                                item['view']!,
                                style: white14Medium,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(fixPadding * 1.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name']!,
                                style: white16Bold,
                              ),
                              height5Space,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '@${item['owner']}',
                                    style: grey16Medium,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/white-eth.png',
                                        height: 20.0,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      width5Space,
                                      Text(
                                        item['price']!,
                                        style: white16Bold,
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
          ),
        ],
      ),
    );
  }

  collectionsList() {
    double width = MediaQuery.of(context).size.width;
    double distance = ((width - fixPadding * 6) / 2.0) - 100.0;
    double imagePadding = distance / 4.0;
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const NFTGrid()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: (width - fixPadding * 6) / 2.0,
                      height: 100.0,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 25.0,
                            right: 0.0,
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(
                                  width: 1.0,
                                  color: whiteColor,
                                ),
                                image: const DecorationImage(
                                  image: AssetImage('assets/profile/all/1.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 19.0,
                            right: imagePadding,
                            child: Container(
                              width: 62.0,
                              height: 62.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(
                                  width: 1.0,
                                  color: whiteColor,
                                ),
                                image: const DecorationImage(
                                  image: AssetImage('assets/profile/all/2.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 13.0,
                            right: imagePadding * 2.0,
                            child: Container(
                              width: 74.0,
                              height: 74.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(
                                  width: 1.0,
                                  color: whiteColor,
                                ),
                                image: const DecorationImage(
                                  image: AssetImage('assets/profile/all/3.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 7.0,
                            right: imagePadding * 3.0,
                            child: Container(
                              width: 86.0,
                              height: 86.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(
                                  width: 1.0,
                                  color: whiteColor,
                                ),
                                image: const DecorationImage(
                                  image: AssetImage('assets/profile/all/3.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0.0,
                            left: 0.0,
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(
                                  width: 1.0,
                                  color: whiteColor,
                                ),
                                image: const DecorationImage(
                                  image: AssetImage('assets/profile/all/5.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    heightSpace,
                    const Text(
                      'All',
                      style: white14Bold,
                    ),
                    height5Space,
                    const Text(
                      '26 NFTs',
                      style: grey12Normal,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const NFTGrid()));
                },
                child: nftCollectionItem(
                    'assets/profile/arts/1.png',
                    'assets/profile/arts/2.png',
                    'assets/profile/arts/3.png',
                    'Arts',
                    '18 NFTS'),
              ),
            ],
          ),
          heightSpace,
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const NFTGrid()));
                },
                child: nftCollectionItem(
                    'assets/profile/3d/1.png',
                    'assets/profile/3d/2.png',
                    'assets/profile/3d/3.png',
                    '3D',
                    '18 NFTS'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const NFTGrid()));
                },
                child: nftCollectionItem(
                    'assets/profile/landscapes/1.png',
                    'assets/profile/landscapes/2.png',
                    'assets/profile/landscapes/3.png',
                    'Landscapes',
                    '18 NFTS'),
              ),
            ],
          ),
          heightSpace,
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const NFTGrid()));
                },
                child: nftCollectionItem(
                    'assets/profile/gaming/1.png',
                    'assets/profile/gaming/2.png',
                    'assets/profile/gaming/3.png',
                    'Gaming',
                    '12 NFTS'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  nftCollectionItem(firstImage, secondImage, thirdImage, title, totalNFT) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100.0,
          width: (width - fixPadding * 6) / 2.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100.0,
                width: (((width - fixPadding * 6) / 2.0) / 2.0) -
                    (fixPadding * 0.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  image: DecorationImage(
                    image: AssetImage(firstImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: (((width - fixPadding * 6) / 2.0) / 2.0) -
                        (fixPadding * 0.5),
                    height: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      image: DecorationImage(
                        image: AssetImage(secondImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: (((width - fixPadding * 6) / 2.0) / 2.0) -
                        (fixPadding * 0.5),
                    height: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      image: DecorationImage(
                        image: AssetImage(thirdImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        heightSpace,
        Text(
          title,
          style: white14Bold,
        ),
        height5Space,
        Text(
          totalNFT,
          style: grey12Normal,
        ),
      ],
    );
  }

  activity() {
    return ColumnBuilder(
      itemCount: activityList.length,
      itemBuilder: (context, index) {
        final item = activityList[index];
        return Padding(
          padding: (index == 0)
              ? const EdgeInsets.all(fixPadding * 2.0)
              : const EdgeInsets.fromLTRB(
                  fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.asset(
                  item['image']!,
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              ),
              widthSpace,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: item['nftName']!,
                        style: white16Medium,
                        children: <TextSpan>[
                          const TextSpan(
                            text: ' sold to ',
                            style: grey14Normal,
                          ),
                          TextSpan(
                            text: '@${item['buyer']!}',
                            style: white16Medium,
                          ),
                        ],
                      ),
                    ),
                    height5Space,
                    Text(
                      '${item['date']!} at ${item['time']}',
                      style: grey14Medium,
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
