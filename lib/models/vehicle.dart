import 'package:nft_market_place/models/offerItemImage.dart';
import 'package:nft_market_place/models/order.dart';
import 'package:nft_market_place/models/person.dart';

class CommercialLogisticsVehicle {
  final String? vehicleID;
  final String? createdDate;
  final String? updatedDate;
  final String? name;
  final String? type;
  final String? description;
  final String? bookID;
  final String? category;
  final String? brand;
  final String? regPlateID;
  final bool? onSale;
  final String? carryingWeightMax;
  final String? carryingWeightMin;
  final String? minimumPrice;
  final String? engineNumber;
  final bool? routesActive;
  final Person? provider;
  final Person? driver;
  final List<Order>? orders;
  final List<OfferItemImage>? images;

  CommercialLogisticsVehicle({
    this.vehicleID,
    this.createdDate,
    this.updatedDate,
    this.name,
    this.type,
    this.description,
    this.bookID,
    this.category,
    this.brand,
    this.regPlateID,
    this.onSale,
    this.carryingWeightMax,
    this.carryingWeightMin,
    this.minimumPrice,
    this.engineNumber,
    this.routesActive,
    this.provider,
    this.driver,
    this.orders,
    this.images,
  });

  // Convert object to JSON map
  Map<String, dynamic> toJson() {
    return {
      'vehicleID': vehicleID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'name': name,
      'type': type,
      'description': description,
      'bookID': bookID,
      'category': category,
      'brand': brand,
      'regPlateID': regPlateID,
      'onSale': onSale,
      'carryingWeightMax': carryingWeightMax,
      'carryingWeightMin': carryingWeightMin,
      'minimumPrice': minimumPrice,
      'engineNumber': engineNumber,
      'routesActive': routesActive,
      'provider': provider?.toJson(), // Assuming Person has a toJson method
      'driver': driver?.toJson(), // Assuming Person has a toJson method
      'orders': orders
          ?.map((order) => order.toJson())
          .toList(), // Assuming Order has a toJson method
      'images': images
          ?.map((image) => image.toJson())
          .toList(), // Assuming OfferItemImage has a toJson method
    };
  }

  // Create object from JSON map
  factory CommercialLogisticsVehicle.fromJson(Map<String, dynamic> json) {
    return CommercialLogisticsVehicle(
      vehicleID: json['vehicleID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      bookID: json['bookID'],
      category: json['category'],
      brand: json['brand'],
      regPlateID: json['regPlateID'],
      onSale: json['onSale'],
      carryingWeightMax: json['carryingWeightMax'],
      carryingWeightMin: json['carryingWeightMin'],
      minimumPrice: json['minimumPrice'],
      engineNumber: json['engineNumber'],
      routesActive: json['routesActive'],
      provider: json['provider'] != null
          ? Person.fromJson(json['provider'])
          : null, // Assuming Person has a fromJson method
      driver: json['driver'] != null
          ? Person.fromJson(json['driver'])
          : null, // Assuming Person has a fromJson method
      orders: json['orders'] != null
          ? (json['orders'] as List<dynamic>)
              .map((order) => Order.fromJson(order))
              .toList() // Assuming Order has a fromJson method
          : null,
      images: json['images'] != null
          ? (json['images'] as List<dynamic>)
              .map((image) => OfferItemImage.fromJson(image))
              .toList() // Assuming OfferItemImage has a fromJson method
          : null,
    );
  }
}
