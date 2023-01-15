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
      Text('${date.day}-${date.month}-${date.year}',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900));

  @override
  Widget build(BuildContext context) {
    // add jwt check

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 234, 234),
      body: FutureBuilder<List<Receipt>>(
        future: futureReceipts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => InkWell(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                    // color: const Color(0xff97FFFF),
                    // border: Border.all(color: AppColors.loginColor, width: 2),
                    color: const Color.fromARGB(255, 215, 222, 224),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 45),
                          renderCreatedAtDate(DateTime.parse(
                              snapshot.data![index].createdAt.toString()))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 35,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  snapshot.data![index].shop
                                      .toString()
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  " - ${snapshot.data![index].price} PLN",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ]),
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              color: const Color.fromARGB(
                                                  255, 212, 212, 212),
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              height: 60,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.cancel_outlined,
                                                      size: 30,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons
                                                          .delete_forever_outlined,
                                                      size: 30,
                                                    ),
                                                    onPressed: () {
                                                      Receipt.deleteReceipt(
                                                          snapshot
                                                              .data![index].sId
                                                              .toString());

                                                      Navigator.pop(context);

                                                      setState(() {
                                                        futureReceipts = Receipt
                                                            .fetchReceipts();
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReceiptDetailView(
                                                      receipt: snapshot
                                                          .data![index])));
                                    },
                                    icon: const Icon(Icons.arrow_forward),
                                    iconSize: 30,
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
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
