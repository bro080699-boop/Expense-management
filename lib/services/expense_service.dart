import 'package:shared_preferences/shared_preferences.dart';

import '../models/expense_model.dart';

class ExpenseService {
  static const String expenseKey = 'expense_list';

  Future<List<ExpenseModel>> getExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList(expenseKey) ?? [];

    return savedList.map((item) => ExpenseModel.fromJson(item)).toList();
  }

  Future<void> saveExpenses(List<ExpenseModel> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    final expenseJsonList = expenses.map((item) => item.toJson()).toList();

    await prefs.setStringList(expenseKey, expenseJsonList);
  }
}
