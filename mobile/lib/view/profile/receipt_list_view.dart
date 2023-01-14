import 'package:flutter/material.dart';
import 'package:mobile/core/constant/app_color.dart';
import 'package:mobile/view/profile/receipt_details_view.dart';

import 'package:mobile/product/model/receipt.dart';

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

  Text renderCreatedAtDate(DateTime date) =>
      Text('${date.day}-${date.month}-${date.year}');

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data![index].shop.toString().toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          renderCreatedAtDate(DateTime.parse(
                              snapshot.data![index].createdAt.toString()))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${snapshot.data![index].price} zl",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(16.0),
                                        height: 60,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                Receipt.deleteReceipt(snapshot
                                                    .data![index].sId
                                                    .toString());

                                                Navigator.pop(context);

                                                setState(() {
                                                  futureReceipts =
                                                      Receipt.fetchReceipts();
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red)
                        ],
                      ),
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
