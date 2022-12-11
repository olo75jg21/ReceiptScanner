import 'dart:convert';

List<Receipt> receiptFromJson(String str) =>
    List<Receipt>.from(json.decode(str).map((x) => Receipt.fromMap(x)));

class Receipt {
  String id;
  String userId;
  String shop;
  int price;

  Receipt(
      {required this.id,
      required this.userId,
      required this.shop,
      required this.price});

  factory Receipt.fromMap(Map<String, dynamic> json) => Receipt(
      id: json['_id'],
      userId: json['userId'],
      shop: json['shop'],
      price: json['price']);
}
