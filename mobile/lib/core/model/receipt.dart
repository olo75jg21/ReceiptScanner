import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:mobile/core/model/ReceiptItem.dart';

class Receipt {
  String? sId;
  String? userId;
  String? shop;
  int? price;
  List<ReceiptItem>? receiptItems;
  String? data;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Receipt(
      {this.sId,
      this.userId,
      this.shop,
      this.price,
      this.receiptItems,
      this.data,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Receipt.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    shop = json['shop'];
    price = json['price'];
    if (json['receiptItems'] != null) {
      receiptItems = <ReceiptItem>[];
      json['receiptItems'].forEach((v) {
        receiptItems!.add(new ReceiptItem.fromJson(v));
      });
    }
    data = json['data'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['shop'] = this.shop;
    data['price'] = this.price;
    if (this.receiptItems != null) {
      data['receiptItems'] = this.receiptItems!.map((v) => v.toJson()).toList();
    }
    data['data'] = this.data;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }

  static Future<List<Receipt>> fetchReceipts() async {
    String userId = "6395ec2a0e9d4e3f03aee8fc";

    var response =
        await http.get(Uri.parse("http://10.0.2.2:3000/receipt/$userId"));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      return parsed['response']['docs']
          .map<Receipt>((json) => Receipt.fromJson(json))
          .toList();
    } else {
      // If the call was not successful, throw an error
      throw Exception('Failed to load users');
    }
  }
}
