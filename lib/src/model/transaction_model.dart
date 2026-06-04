class TransactionModel {
  final String id;
  final String title;
  final String category;
  final double amount;
  final String date;
  final String note;

  TransactionModel({
    required this.id,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.note,
  });

  factory TransactionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      amount: (json['amount'] as num).toDouble(),
      date: json['date'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "category": category,
      "amount": amount,
      "date": date,
      "note": note,
    };
  }
}