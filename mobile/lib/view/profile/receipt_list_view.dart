import 'dart:convert';
import 'package:dio/dio.dart';

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
  String userId = "6395ec2a0e9d4e3f03aee8fc";
  late Future<List<Receipt>> futureReceipts;

  @override
  void initState() {
    super.initState();
    futureReceipts = fetchReceipts();
  }

  Future<List<Receipt>> fetchReceipts() async {
    var response =
        await http.get(Uri.parse("http://10.0.2.2:3000/receipt/$userId"));

    print("XD");
    print(response.body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Receipt>((json) => Receipt.fromMap(json)).toList();
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
                        snapshot.data![index].id,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(snapshot.data![index].shop),
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
