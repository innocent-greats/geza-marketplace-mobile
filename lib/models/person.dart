import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:nft_market_place/models/order.dart';
import 'package:nft_market_place/models/wallet.dart';

class Person {
  Person({
    this.userID,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.accountType,
    this.city,
    this.neighbourhood,
    this.locationCoordinates,
    this.walletId,
    this.specialization,
    this.rating,
    this.searchTerm,
    this.profileImage,
    this.deploymentStatus,
    this.jobRole,
    this.streetAddress,
    this.department,
    this.createdDate,
    this.onlineStatus,
    this.salary,
    this.tradingAs,
    this.walletAddress,
    this.wallet,
    this.inMemoryProfileImage,
    this.orders,
  });

  String? userID;
  String? salary;
  String firstName;
  String lastName;
  String? phone;
  String? city;
  String? neighbourhood;
  String? locationCoordinates;
  String? walletId;
  String? specialization;
  double? rating;
  String? accountType;
  String? tradingAs;
  String? deploymentStatus;
  String? jobRole;
  String? streetAddress;
  String? department;
  String? searchTerm;
  String? profileImage;
  String? createdDate;
  bool? onlineStatus;
  String? walletAddress;
  Wallet? wallet;
  File? inMemoryProfileImage;
  List<Order>? orders;

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'salary': salary,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'city': city,
      'neighbourhood': neighbourhood,
      'locationCoordinates': locationCoordinates,
      'walletId': walletId,
      'specialization': specialization,
      'rating': rating,
      'accountType': accountType,
      'tradingAs': tradingAs,
      'deploymentStatus': deploymentStatus,
      'jobRole': jobRole,
      'streetAddress': streetAddress,
      'department': department,
      'searchTerm': searchTerm,
      'profileImage': profileImage,
      'createdDate': createdDate,
      'onlineStatus': onlineStatus,
      'inMemoryProfileImage': inMemoryProfileImage,
      'walletAddress': walletAddress,
      'wallet': wallet != null ? wallet!.toJson() : null,
      'orders': orders != null
          ? orders!.map((order) => order.toJson()).toList()
          : null,
    };
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    // debugPrint('Person.fromJson$json');
    return Person(
      userID: json['userID'],
      salary: json['salary'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      city: json['city'],
      neighbourhood: json['neighbourhood'],
      locationCoordinates: json['locationCoordinates'],
      walletId: json['walletId'],
      specialization: json['specialization'],
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : 0,
      accountType: json['accountType'],
      tradingAs: json['tradingAs'],
      deploymentStatus: json['deploymentStatus'],
      jobRole: json['jobRole'],
      streetAddress: json['streetAddress'],
      department: json['department'],
      searchTerm: json['searchTerm'],
      profileImage: json['profileImage'],
      createdDate: json['createdDate'],
      onlineStatus: json['onlineStatus'],
      inMemoryProfileImage: json['inMemoryProfileImage'],
      walletAddress: json['walletAddress'],
      wallet: json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null,
      orders: json['orders'] != null
          ? List<Order>.from(
              json['orders'].map((order) => Order.fromJson(order)))
          : <Order>[],
    );
  }
}
