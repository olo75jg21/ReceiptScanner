import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/model/receipt.dart';

class ReceiptListView extends StatefulWidget {
  const ReceiptListView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReceiptListState createState() => _ReceiptListState();
}

class _ReceiptListState extends State<ReceiptListView> {
  late Future<List<Receipt>> futureReceipts;

  @override
  void initState() {
    super.initState();
    futureReceipts = Receipt.fetchReceipts();
  }

  @override
  Widget build(BuildContext context) {
    // add jwt check

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your receipts'),
      ),
      body: FutureBuilder<List<Receipt>>(
        future: futureReceipts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => Container(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xff97FFFF),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data![index].sId.toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(snapshot.data![index].shop.toString()),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
