import 'package:nft_market_place/models/offerItemImage.dart';
import 'package:nft_market_place/models/order.dart';
import 'package:nft_market_place/models/person.dart';

class OfferItem {
  final String? itemID;
  final String? createdDate;
  final String? updatedDate;
  final String? itemName;
  final String? itemCategory;
  final String? commodityWeight;
  final String? minimumPrice;
  final List<OfferItemImage>? images;
  final List<Order>? orders;
  final String? providerID;
  final String? clientID;
  final String? offeringStatus;
  final Person? provider;
  final Person? client;

  OfferItem({
    this.itemID,
    this.createdDate,
    this.updatedDate,
    required this.itemName,
    required this.itemCategory,
    required this.minimumPrice,
    this.commodityWeight,
    this.images,
    this.providerID,
    this.clientID,
    this.offeringStatus,
    this.provider,
    this.client,
    this.orders,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemID': itemID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'itemName': itemName,
      'itemCategory': itemCategory,
      'commodityWeight': commodityWeight,
      'minimumPrice': minimumPrice,
      'images': images?.map((image) => image.toJson()).toList(),
      'providerID': providerID,
      'clientID': clientID,
      'offeringStatus': offeringStatus,
      'provider': provider?.toJson(),
      'client': client?.toJson(),
    };
  }

  factory OfferItem.fromJson(Map<String, dynamic> json) {
    return OfferItem(
      itemID: json['itemID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      itemName: json['itemName'],
      itemCategory: json['itemCategory'],
      commodityWeight: json['commodityWeight'],
      minimumPrice: json['minimumPrice'],
      images: (json['images'] as List<dynamic>?)
          ?.map((imageJson) => OfferItemImage.fromJson(imageJson))
          .toList(),
      providerID: json['providerID'],
      clientID: json['clientID'],
      offeringStatus: json['offeringStatus'],
      orders: json['orders'] != null
          ? List<Order>.from(
              json['orders'].map((order) => Order.fromJson(order)))
          : null,
      provider:
          json['provider'] != null ? Person.fromJson(json['provider']) : null,
      client: json['client'] != null ? Person.fromJson(json['client']) : null,
    );
  }
}
