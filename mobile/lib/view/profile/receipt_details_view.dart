import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:mobile/product/model/receipt.dart';
import 'package:mobile/product/model/receipt_item.dart';
import 'package:path/path.dart';
import '../../core/constant/app_color.dart';

class ReceiptDetailView extends StatefulWidget {
  final Receipt receipt;
  const ReceiptDetailView({super.key, required this.receipt});

  @override
  State<ReceiptDetailView> createState() => _ReceiptDetailViewState();
}

class _ReceiptDetailViewState extends State<ReceiptDetailView> {
  late Receipt _receipt;
  late DateTime _receiptCreatedAt;

  @override
  void initState() {
    _receipt = widget.receipt;
    _receiptCreatedAt = DateTime.parse(_receipt.createdAt.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: AppColors.loginColor,
      ),
      body: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  topArea(),
                  displayReceiptItemsList(),
                ],
              ))),
    ));
  }

  Card topArea() => Card(
        margin: const EdgeInsets.all(10.0),
        elevation: 1.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        child: Container(
            decoration: const BoxDecoration(
                gradient: RadialGradient(
                    colors: [Color(0xFF015FFF), Color(0xFF015FFF)])),
            // color: Color(0xFF015FFF),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0, bottom: 15.0),
                      child: Text(_receipt.shop.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w400)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 10.0, bottom: 15.0, right: 10.0),
                      child: Text(
                          '${_receiptCreatedAt.day.toString()}-${_receiptCreatedAt.month.toString()}-${_receiptCreatedAt.year.toString()}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17.0)),
                    )
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text('${_receipt.price} zl',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 24.0)),
                  ),
                ),
                const SizedBox(height: 12.0),
              ],
            )),
      );

  Container accountItems(ReceiptItem receiptItem,
          {Color oddColour = Colors.white}) =>
      Container(
        decoration: BoxDecoration(color: oddColour),
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(receiptItem.name.toString(),
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w500)),
                Text(
                    "Total:  ${receiptItem.priceInvidual! * receiptItem.amount!} zl",
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w500))
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${receiptItem.amount} ${receiptItem.unit}',
                    style: const TextStyle(fontSize: 14.0)),
                Text('${receiptItem.priceInvidual} zl/${receiptItem.unit}',
                    style: const TextStyle(fontSize: 14.0))
              ],
            ),
          ],
        ),
      );

  displayReceiptItemsList() {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          for (var receiptItem in _receipt.receiptItems!.asMap().entries)
            accountItems(receiptItem.value,
                oddColour: receiptItem.key % 2 == 0
                    ? const Color(0xFFF7F7F9)
                    : Colors.white)
        ],
      ),
    );
  }
}
