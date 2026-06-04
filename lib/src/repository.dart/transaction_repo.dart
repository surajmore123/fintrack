import 'dart:convert';

import 'package:fintrack/src/model/transaction_model.dart';
import 'package:flutter/services.dart';

class TransactionRepository {
  static List<TransactionModel> transactions = [];

  static Future<void> loadTransactions() async {
    final String jsonString = await rootBundle.loadString(
      'assets/json/transactions.json',
    );

    final List<dynamic> jsonData = json.decode(jsonString);

    transactions = jsonData
        .map((e) => TransactionModel.fromJson(e))
        .toList();
  }

  static List<TransactionModel> getAllTransactions() {
    return transactions;
  }
}