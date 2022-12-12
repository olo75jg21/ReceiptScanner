import 'package:flutter/material.dart';
import 'package:mobile/core/constant/app_color.dart';
import 'package:mobile/view/profile/receipt_details_view.dart';

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
        backgroundColor: AppColors.loginColor,
      ),
      body: FutureBuilder<List<Receipt>>(
        future: futureReceipts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReceiptDetailView(
                              receipt: snapshot.data![index])));
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    // color: const Color(0xff97FFFF),
                    border: Border.all(color: AppColors.loginColor, width: 2),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        snapshot.data![index].shop.toString().toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(snapshot.data![index].createdAt.toString()),
                      const SizedBox(height: 10),
                      Text(
                        "${snapshot.data![index].price}zl",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
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
