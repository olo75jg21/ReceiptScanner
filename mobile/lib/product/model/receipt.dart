import 'dart:convert';

import 'package:gallery_saver/files.dart';
import 'package:mobile/product/model/receipt_item.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/service/storage_service.dart';

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
        receiptItems!.add(ReceiptItem.fromJson(v));
      });
    }
    data = json['data'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['shop'] = shop;
    data['price'] = price;
    if (receiptItems != null) {
      data['receiptItems'] = receiptItems!.map((v) => v.toJson()).toList();
    }
    data['data'] = this.data;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }

  static Future<List<Receipt>> fetchReceipts() async {
    // String userId = (await StorageService.readSecureData('user'))!;

    String userId = '639b97244b307b2646ba6548';
    // String token = (await StorageService.readSecureData('jwt'))!;

    // var response =
    //     await HttpClient.get('receipt/$userId', headers: {'token': token});

    var response =
        await http.get(Uri.parse('http://10.0.2.2:3000/receipt/' + userId));
    print(response.statusCode);
    print(userId);
    // print(token);

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

  static Future<http.Response> deleteReceipt(String receiptId) async {
    try {
      final response = await http
          .delete(Uri.parse('http://10.0.2.2:3000/receipt/${receiptId}'));
      print(response.body);

      return response;
    } catch (e) {
      throw Exception('Failed to delete');
    }
  }
}
