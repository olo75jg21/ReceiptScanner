import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> el = {
      'test': '\$5.11',
      'asddas': '7.00zl',
      'a': '15.3',
    };
    return MaterialApp(
      title: 'Successfully logged in!',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Successfully logged in!'),
        ),
        body: Center(
          child: Column(
            children: [
              // const Text('Successfully logged in!'),
              TextButton(
                child: const Text(
                  'click',
                ),
                onPressed: () {
                  showDialog(
                    // barrierColor: Colors.amber,
                    context: context,
                    builder: (_) {
                      var singleChildScrollView = SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        child: Table(
                          defaultColumnWidth: const FixedColumnWidth(120.0),
                          border: TableBorder.all(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                          children: <TableRow>[
                            const TableRow(
                              children: [
                                Text('Name', textAlign: TextAlign.center),
                                Text('Price', textAlign: TextAlign.center),
                              ],
                            ),
                            ...el.entries.map(
                              (e) => TableRow(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(8)),
                                    initialValue: e.key,
                                  ),
                                  TextFormField(
                                    textAlign: TextAlign.right,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(8)),
                                    initialValue: e.value,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                      return AlertDialog(
                        contentPadding: const EdgeInsets.all(1),
                        backgroundColor: Colors.white70,
                        // backgroundColor: Colors.transparent,
                        content: singleChildScrollView,
                      );
                    },
                  );

                  // Navigator.push(
                  //   context,
                  //   // MaterialPageRoute(
                  //       // builder: (context) => CameraView(camera: _firstCamera)),
                  // );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
