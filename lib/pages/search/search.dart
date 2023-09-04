import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';
import 'package:nft_market_place/pages/bottom_bar.dart';
import 'package:nft_market_place/widget/column_builder.dart';
import 'package:page_transition/page_transition.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String status = '';
  String sortBy = '';
  final categoryList = [
    {
      'image': 'assets/icons/search/all.png',
      'name': 'All',
    },
    {
      'image': 'assets/icons/search/art.png',
      'name': 'Art',
    },
    {
      'image': 'assets/icons/search/gaming.png',
      'name': 'Gaming',
    },
    {
      'image': 'assets/icons/search/videos.png',
      'name': 'Videos',
    },
    {
      'image': 'assets/icons/search/music.png',
      'name': 'Music',
    },
    {
      'image': 'assets/icons/search/sport.png',
      'name': 'Sport',
    },
    {
      'image': 'assets/icons/search/illustration.png',
      'name': 'Illustration',
    }
  ];

  final searchHistoryList = [
    {'name': '3D character'},
    {'name': 'Pikachu gif'},
    {'name': 'Thunder bolt'},
    {'name': 'Anime'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          header(),
          searchField(),
          category(),
          searchHistory(),
        ],
      ),
    );
  }

  header() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Search',
            style: white22Bold,
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

  searchField() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width - (fixPadding * 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: secondaryColor,
            ),
            child: const TextField(
              style: white14Medium,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.0),
                hintText: 'Search',
                hintStyle: grey14Medium,
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () => filterBottomsheet(),
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: secondaryColor,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.sort,
                color: whiteColor,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  category() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
      child: SizedBox(
        height: 50.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              final item = categoryList[index];
              return Padding(
                padding: (index == 0)
                    ? const EdgeInsets.symmetric(horizontal: fixPadding * 2.0)
                    : const EdgeInsets.only(right: fixPadding * 2.0),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(7.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(width: 1.0, color: primaryColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          item['image']!,
                          width: 24.0,
                          height: 24.0,
                          fit: BoxFit.fill,
                        ),
                        widthSpace,
                        Text(
                          item['name']!,
                          style: primaryColor16Medium,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  searchHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Search',
            style: white18Bold,
          ),
          ColumnBuilder(
            itemCount: searchHistoryList.length,
            itemBuilder: (context, index) {
              final item = searchHistoryList[index];
              return Padding(
                padding: (index == 0)
                    ? const EdgeInsets.symmetric(vertical: fixPadding * 2.0)
                    : const EdgeInsets.only(bottom: fixPadding * 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.history,
                          color: greyColor,
                        ),
                        widthSpace,
                        Text(
                          item['name']!,
                          style: grey16Medium,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          searchHistoryList.removeAt(index);
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        color: greyColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  filterBottomsheet() {
    double width = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          statusItem(title) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                  0.0, fixPadding, fixPadding, fixPadding),
              child: InkWell(
                onTap: () {
                  setState(() {
                    status = title;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(fixPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Colors.white.withOpacity(0.06),
                    border: Border.all(
                        width: 0.7,
                        color: (status == title)
                            ? primaryColor
                            : Colors.transparent),
                  ),
                  child: Text(
                    title,
                    style: (status == title) ? primaryColor14Bold : white14Bold,
                  ),
                ),
              ),
            );
          }

          sortByItem(title) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                  0.0, fixPadding, fixPadding, fixPadding),
              child: InkWell(
                onTap: () {
                  setState(() {
                    sortBy = title;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(fixPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Colors.white.withOpacity(0.06),
                    border: Border.all(
                        width: 0.7,
                        color: (sortBy == title)
                            ? primaryColor
                            : Colors.transparent),
                  ),
                  child: Text(
                    title,
                    style: (sortBy == title) ? primaryColor14Bold : white14Bold,
                  ),
                ),
              ),
            );
          }

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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Select Filter',
                      style: white18Bold,
                    ),
                  ),
                  heightSpace,
                  heightSpace,
                  // Status Start
                  const Text(
                    'Status',
                    style: white16Bold,
                  ),
                  heightSpace,
                  Wrap(
                    children: [
                      statusItem('Buy now'),
                      statusItem('Has offer'),
                      statusItem('New product'),
                    ],
                  ),
                  // Status End
                  heightSpace,
                  // Price Start
                  const Text(
                    'Price',
                    style: white16Bold,
                  ),
                  heightSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: ((width - (fixPadding * 8)) / 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: Colors.white.withOpacity(0.06),
                        ),
                        child: const TextField(
                          style: white14Medium,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Min',
                            hintStyle: grey14Medium,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Text(
                        'to',
                        style: grey14Medium,
                      ),
                      Container(
                        width: ((width - (fixPadding * 8)) / 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: Colors.white.withOpacity(0.06),
                        ),
                        child: const TextField(
                          style: white14Medium,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Min',
                            hintStyle: grey14Medium,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Price End

                  heightSpace,
                  heightSpace,
                  // Sort By Start
                  const Text(
                    'Sort By',
                    style: white16Bold,
                  ),
                  heightSpace,
                  Wrap(
                    children: [
                      sortByItem('Most viewed'),
                      sortByItem('Bitcoin'),
                      sortByItem('Ending soon'),
                      sortByItem('Price: Low to High'),
                      sortByItem('Price: High to Low'),
                      sortByItem('Recently created'),
                      sortByItem('Oldest'),
                      sortByItem('Ethereum'),
                    ],
                  ),
                  // Sort By End
                  heightSpace,
                  // Apply Reset Start
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          'Reset',
                          style: primaryColor16Bold,
                        ),
                      ),
                      widthSpace,
                      widthSpace,
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
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
                              'Apply',
                              style: white16Bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Apply Reset End
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
