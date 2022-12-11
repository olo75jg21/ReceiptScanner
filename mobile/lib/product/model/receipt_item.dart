class ReceiptItem {
  String name;
  num totalCost;
  num unitCost;
  int quantity;

  ReceiptItem(this.name, this.totalCost, this.unitCost, this.quantity);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "totalCost": totalCost,
      "unitCost": unitCost,
      "quantity": quantity,
    };
  }
}
