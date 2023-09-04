import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:nft_market_place/models/offerItem.dart';
import 'package:nft_market_place/models/person.dart';

class Provider {
  final Person provider;
  final List<OfferItem> offerItems;

  Provider({
    required this.provider,
    required this.offerItems,
  });

  // Serialize the object to a JSON string
  String toJson() {
    return jsonEncode({
      'provider': provider.toJson(),
      'offerItems': offerItems.map((item) => item.toJson()).toList(),
    });
  }

  // Deserialize a JSON string to create a Provider object
  factory Provider.fromJson(String jsonStr) {
    // debugPrint('Provider.fromJson jsonStr $jsonStr');
    final Map<String, dynamic> jsonData = jsonDecode(jsonStr);
    return Provider(
      provider: Person.fromJson(jsonData),
      offerItems: jsonData['offerItems'] != null
          ? (jsonData['offerItems'] as List<dynamic>)
              .map((itemData) => OfferItem.fromJson(itemData))
              .toList()
          : <OfferItem>[],
    );
  }
  // Deserialize a JSON List to create a List of VendorOfferItems
  List<Provider> listFromJson(String jsonStr) {
    final List<dynamic> jsonDataList = jsonDecode(jsonStr);
    return jsonDataList.map((jsonItem) => Provider.fromJson(jsonItem)).toList();
  }
}
