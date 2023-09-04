import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:nft_market_place/constant/constant.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final faqList = [
      {
        'title': 'How to upload NFTs?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
      {
        'title': 'How to logout from this app?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
      {
        'title': 'How to create collection in this app?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
      {
        'title': 'Is this app is free to use?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
      {
        'title': 'How to buy NFTs?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
      {
        'title': 'How to sell NFTs?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
      {
        'title': 'How to withraw amout?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
      {
        'title': 'How to close account from this app?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
      {
        'title': 'Is this legal to buy and sell NFTs in india?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
      {
        'title': 'How this is differ from cryptocurrency?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
      {
        'title': 'How we can use your data?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
      {
        'title': 'What user data we store in our server?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
      {
        'title': 'How to contact us?',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis fames temper.',
      },
    ];
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        centerTitle: false,
        titleSpacing: 0.0,
        title: const Text(
          'FAQs',
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
      body: ListView.builder(
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          final item = faqList[index];
          return Padding(
            padding: (index == 0)
                ? const EdgeInsets.all(fixPadding * 2.0)
                : const EdgeInsets.fromLTRB(
                    fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
            child: Container(
              padding: const EdgeInsets.all(fixPadding * 1.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: secondaryColor,
              ),
              child: Theme(
                data: ThemeData(
                    iconTheme: const IconThemeData(
                  color: whiteColor,
                )),
                child: ExpandablePanel(
                  header: Text(
                    item['title']!,
                    style: white14Bold,
                  ),
                  collapsed: Text(
                    item['description']!,
                    style: white12Medium,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Text(
                    item['description']!,
                    softWrap: true,
                    style: white12Medium,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
