import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:mobile/product/model/receipt.dart';
import 'package:mobile/product/model/receipt_item.dart';
// import 'package:path/path.dart';
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
        child: Container(
            color: const Color.fromARGB(255, 235, 232, 232),
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
                              fontSize: 26.0, fontWeight: FontWeight.w400)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 10.0, bottom: 15.0, right: 10.0),
                      child: Text(
                          '${_receiptCreatedAt.day.toString()}-${_receiptCreatedAt.month.toString()}-${_receiptCreatedAt.year.toString()}',
                          style: const TextStyle(fontSize: 17.0)),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      margin: const EdgeInsets.only(left: 10.0),
                      child: Text('Total: ${_receipt.price} zl',
                          style: const TextStyle(fontSize: 22.0)),
                    )
                  ],
                ),
                const SizedBox(height: 12.0),
              ],
            )),
      );

  GestureDetector receiptItems(ReceiptItem receiptItem,
          {Color oddColour = Colors.white}) =>
      GestureDetector(
          onLongPress: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.0),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            receiptItem.deleteReceiptItem(
                                _receipt.sId.toString(),
                                receiptItem.sId.toString());
                          },
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Container(
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
          ));

  displayReceiptItemsList() {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          for (var receiptItem in _receipt.receiptItems!.asMap().entries)
            receiptItems(receiptItem.value,
                oddColour: receiptItem.key % 2 == 0
                    ? const Color(0xFFF7F7F9)
                    : Colors.white)
        ],
      ),
    );
  }
}
