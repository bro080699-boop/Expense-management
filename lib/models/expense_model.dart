import 'dart:convert';

class ExpenseModel {
  String id;
  String title;
  double amount;
  String category;
  DateTime date;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      title: map['title'],
      amount: (map['amount'] as num).toDouble(),
      category: map['category'],
      date: DateTime.parse(map['date']),
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory ExpenseModel.fromJson(String source) {
    return ExpenseModel.fromMap(jsonDecode(source));
  }
}
