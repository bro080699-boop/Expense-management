import 'package:get/get.dart';

import '../models/expense_model.dart';
import '../services/expense_service.dart';

class ExpenseController extends GetxController {
  final ExpenseService expenseService = ExpenseService();

  final expenses = <ExpenseModel>[].obs;
  final selectedCategory = 'All'.obs;
  final searchText = ''.obs;

  final List<String> categories = [
    'All',
    'Food',
    'Travel',
    'Shopping',
    'Recharge',
    'Other',
  ];

  @override
  void onInit() {
    super.onInit();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    expenses.value = await expenseService.getExpenses();
  }

  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
    required DateTime date,
  }) async {
    final expense = ExpenseModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      category: category,
      date: date,
    );

    expenses.add(expense);
    await saveData();
  }

  Future<void> updateExpense({
    required String id,
    required String title,
    required double amount,
    required String category,
    required DateTime date,
  }) async {
    final index = expenses.indexWhere((item) => item.id == id);

    if (index != -1) {
      expenses[index] = ExpenseModel(
        id: id,
        title: title,
        amount: amount,
        category: category,
        date: date,
      );

      await saveData();
    }
  }

  Future<void> deleteExpense(String id) async {
    expenses.removeWhere((item) => item.id == id);
    await saveData();
  }

  Future<void> saveData() async {
    await expenseService.saveExpenses(expenses);
  }

  List<ExpenseModel> get filteredExpenses {
    List<ExpenseModel> result = expenses;

    if (selectedCategory.value == 'All') {
      result = expenses;
    } else {
      result = expenses
          .where((item) => item.category == selectedCategory.value)
          .toList();
    }

    if (searchText.value.trim().isNotEmpty) {
      final search = searchText.value.toLowerCase();

      result = result.where((item) {
        return item.title.toLowerCase().contains(search) ||
            item.category.toLowerCase().contains(search);
      }).toList();
    }

    return result;
  }

  double get totalAmount {
    double total = 0;

    for (final expense in expenses) {
      total = total + expense.amount;
    }

    return total;
  }

  Map<String, double> get categoryTotals {
    final Map<String, double> totals = {};

    for (final expense in expenses) {
      totals[expense.category] =
          (totals[expense.category] ?? 0) + expense.amount;
    }

    return totals;
  }
}
