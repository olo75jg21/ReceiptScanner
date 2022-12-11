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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['amount'] = this.amount;
    data['priceInvidual'] = this.priceInvidual;
    data['category'] = this.category;
    data['_id'] = this.sId;
    return data;
  }
}
