// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';

class NFTGrid extends StatefulWidget {
  const NFTGrid({Key? key}) : super(key: key);

  @override
  State<NFTGrid> createState() => _NFTGridState();
}

class _NFTGridState extends State<NFTGrid> {
  final nftList = [
    {
      'image': 'assets/profile/arts/1.png',
    },
    {
      'image': 'assets/profile/arts/2.png',
    },
    {
      'image': 'assets/profile/arts/3.png',
    },
    {
      'image': 'assets/profile/all/1.png',
    },
    {
      'image': 'assets/profile/all/2.png',
    },
    {
      'image': 'assets/profile/all/3.png',
    },
    {
      'image': 'assets/profile/all/4.png',
    },
    {
      'image': 'assets/profile/all/5.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        title: const Text(
          'Arts',
          style: white18Bold,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(fixPadding * 2.0),
            padding: const EdgeInsets.all(fixPadding * 0.5),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(
                fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: nftList.length,
                itemBuilder: (BuildContext context, index) {
                  final item = nftList[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      item['image']!,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
