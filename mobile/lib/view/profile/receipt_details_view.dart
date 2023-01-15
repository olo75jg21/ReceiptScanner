import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:mobile/product/model/receipt.dart';
import 'package:mobile/product/model/receipt_item.dart';
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

  void handleDeleteReceiptItem() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 234, 234),
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 83, 83, 83), size: 30),
        elevation: 0,
        title: appBarTitle(),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          displayReceiptItemsList(),
        ],
      )),
    ));
  }

  Row appBarTitle() => Row(children: [
        Text('${_receipt.shop} - ${_receipt.price} PLN'.toUpperCase(),
            style: const TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 83, 83, 83),
                fontWeight: FontWeight.w700))
      ]);

  GestureDetector receiptItems(ReceiptItem receiptItem,
          {Color oddColour = Colors.white}) =>
      GestureDetector(
          onLongPress: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    alignment: Alignment.center,
                    color: const Color.fromARGB(255, 212, 212, 212),
                    padding: const EdgeInsets.all(16.0),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.cancel_outlined),
                          iconSize: 30,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                          iconSize: 30,
                          onPressed: () {
                            receiptItem.deleteReceiptItem(
                                _receipt.sId.toString(),
                                receiptItem.sId.toString());

                            Navigator.pop(context);

                            setState(() {
                              var receiptIndex = _receipt.receiptItems
                                  ?.indexWhere((receipt) =>
                                      receipt.sId == receiptItem.sId);

                              _receipt.receiptItems?.removeAt(receiptIndex!);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                color: oddColour,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0)),
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(receiptItem.name.toString(),
                        style: const TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w900)),
                    Text(
                        "Total:  ${receiptItem.priceInvidual! * receiptItem.amount!} PLN",
                        style: const TextStyle(
                            fontSize: 19.0, fontWeight: FontWeight.w900))
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${receiptItem.amount} ${receiptItem.unit}',
                        style: const TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w900)),
                    Text('${receiptItem.priceInvidual} PLN/${receiptItem.unit}',
                        style: const TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w900))
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
                oddColour: const Color.fromARGB(255, 215, 222, 224))
        ],
      ),
    );
  }
}
