import 'package:flutter/material.dart';

import 'package:mobile/product/model/receipt.dart';
import '../../core/constant/app_color.dart';

class ReceiptDetailView extends StatelessWidget {
  final Receipt receipt;
  ReceiptDetailView({Key? key, required this.receipt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(receipt.shop.toString().toUpperCase()),
          backgroundColor: AppColors.loginColor,
        ),
        body: Center(
          child: Text(receipt.price.toString()),
        ));
  }
}
