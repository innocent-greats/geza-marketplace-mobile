import 'package:flutter/cupertino.dart';
import 'package:nft_market_place/models/order.dart';

class Wallet {
  String walletID;
  String? createdDate;
  String? updatedDate;
  String? deletedDate;
  String? userID;
  String? walletName;
  String? walletAddress;
  double? currentBalance;
  List<Order>? transactions;
  // Person? user;

  Wallet({
    required this.walletID,
    required this.createdDate,
    required this.updatedDate,
    required this.deletedDate,
    required this.userID,
    required this.walletName,
    required this.walletAddress,
    required this.currentBalance,
    required this.transactions,
    // required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'walletID': walletID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'deletedDate': deletedDate,
      'userID': userID,
      'walletName': walletName,
      'walletAddress': walletAddress,
      'currentBalance': currentBalance,
      'transactions': transactions != null ?
          transactions!.map((transaction) => transaction.toJson()).toList(): null,
      // 'user': user!.toJson(),
    };
  }

  factory Wallet.fromJson(Map<String, dynamic> json) {
    // debugPrint('Wallet ||| fromJson${json}');
    Wallet wallet = Wallet(
      walletID: json['walletID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      deletedDate: json['deletedDate'],
      userID: json['userID'],
      walletName: json['walletName'],
      walletAddress: json['walletAddress'],
      currentBalance: (json['currentBalance'] as num).toDouble(),
      transactions: json['transactions'] != null
          ? List<Order>.from(json['transactions']
              .map((transaction) => Order.fromJson(transaction)))
          : null,
      // user: Person.fromJson(json['user']),
    );
    // debugPrint('Wallet --- fromJson wallet  ${wallet.userID}');

    return wallet;
  }
}
