import 'package:flutter/material.dart';

import 'package:mobile/product/model/receipt.dart';
import '../../core/constant/app_color.dart';

class ReceiptDetailView extends StatefulWidget {
  const ReceiptDetailView({super.key, required this.receipt});
  final Receipt receipt;

  @override
  State<ReceiptDetailView> createState() => _ReceiptDetailViewState();
}

class _ReceiptDetailViewState extends State<ReceiptDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        backgroundColor: AppColors.loginColor,
      ),
    );
  }
}
