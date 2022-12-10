import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/model/receipt.dart';

class ReceiptListView extends StatefulWidget {
  const ReceiptListView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReceiptListState createState() => _ReceiptListState();
}

class _ReceiptListState extends State<ReceiptListView> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Receipt>> fetchReceipts() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      List<Receipt> receipts = [];

      List<dynamic> receiptsJson = jsonDecode(response.body);

      receiptsJson.forEach(
        (oneReceipt) {
          Receipt album = Receipt.fromJson(oneReceipt);
          receipts.add(album);
        },
      );

      return receipts;
    } else {
      // If the call was not successful, throw an error
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    // add jwt check

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your receipts'),
      ),
      body: Center(
          child: FutureBuilder<List<Receipt>>(
        future: fetchReceipts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Receipt>? resData = snapshot.data;
            return ListView.builder(
                itemCount: resData != null ? resData.length : 0,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(resData?[index].name ?? ""),
                    ),
                  );
                });
          }

          // if (snapshot.hasData) {
          //   return Text(snapshot.data!.title);
          // } else if (snapshot.hasError) {
          //   return Text('${snapshot.error}');
          // }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      )),
    );
  }
}
