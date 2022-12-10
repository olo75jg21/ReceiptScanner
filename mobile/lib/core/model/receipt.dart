class Receipt {
  final int id;
  final String name;
  final String email;

  Receipt({required this.id, required this.name, required this.email});

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
