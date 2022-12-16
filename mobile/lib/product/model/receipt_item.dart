class ReceiptItem {
  String? name;
  String? unit;
  num? amount;
  num? priceInvidual;
  String? category;
  String? sId;

  ReceiptItem(
      {this.name,
      this.unit,
      this.amount,
      this.priceInvidual,
      this.category,
      this.sId});

  ReceiptItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    unit = json['unit'];
    amount = json['amount'];
    priceInvidual = json['priceInvidual'];
    category = json['category'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['unit'] = unit;
    data['amount'] = amount;
    data['priceInvidual'] = priceInvidual;
    data['category'] = category;
    data['_id'] = sId;
    return data;
  }
}
