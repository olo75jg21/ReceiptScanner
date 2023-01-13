import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:mobile/product/model/receipt.dart';
import 'package:path/path.dart';
import '../../core/constant/app_color.dart';

class ReceiptDetailView extends StatelessWidget {
  final Receipt receipt;
  ReceiptDetailView({Key? key, required this.receipt}) : super(key: key);

  Widget renderReceiptItems() {
    return Column(
      children: <Widget>[
        for (var item in receipt.receiptItems!)
          Card(
            child: Text(
              item.name!,
              style: TextStyle(fontSize: 25.0),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(receipt.shop.toString().toUpperCase()),
          backgroundColor: AppColors.loginColor,
        ),
        body: Center(child: renderReceiptItems()));
  }
}
