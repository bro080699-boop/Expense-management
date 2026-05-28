import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/expense_controller.dart';
import '../controllers/theme_controller.dart';
import '../models/expense_model.dart';
import '../utils/app_colors.dart';
import '../widgets/analytics_card.dart';
import '../widgets/expense_card.dart';
import 'add_edit_expense_view.dart';

class ExpenseListView extends StatefulWidget {
  const ExpenseListView({super.key});

  @override
  State<ExpenseListView> createState() => _ExpenseListViewState();
}

class _ExpenseListViewState extends State<ExpenseListView> {
  final ExpenseController controller = Get.put(ExpenseController());
  final ThemeController themeController = Get.find<ThemeController>();
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  static const Color deleteDialogColor = Color(0xFFEF4444);

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void openExpenseForm({ExpenseModel? expense}) {
    Get.to(
      () => AddEditExpenseView(expense: expense),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> deleteExpense(String id) async {
    searchFocusNode.canRequestFocus = false;
    searchFocusNode.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();

    await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [deleteDialogColor, AppColors.primary],
                  ),
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Delete Expense?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Are you sure you want to remove this expense?',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textLight),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: deleteDialogColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        controller.deleteExpense(id);
                        Get.back();
                      },
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 100));

    if (mounted) {
      searchFocusNode.canRequestFocus = true;
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Expense Tracker'),
        actions: [
          Obx(
            () => IconButton(
              tooltip: 'Change Theme',
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: themeController.toggleTheme,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          final filteredExpenses = controller.filteredExpenses;

          return Column(
            children: [
              AnalyticsCard(controller: controller),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  onChanged: (value) {
                    controller.searchText.value = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Search expense',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.searchText.value.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              searchController.clear();
                              controller.searchText.value = '';
                            },
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonFormField<String>(
                  initialValue: controller.selectedCategory.value,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Filter by Category',
                    prefixIcon: Icon(Icons.filter_list),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                  items: controller.categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedCategory.value = value;
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: filteredExpenses.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 54,
                              color: AppColors.textLight,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'No expenses found',
                              style: TextStyle(
                                color: AppColors.textLight,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: filteredExpenses.length,
                        itemBuilder: (context, index) {
                          final expense = filteredExpenses[index];

                          return ExpenseCard(
                            expense: expense,
                            onEdit: () {
                              openExpenseForm(expense: expense);
                            },
                            onDelete: () {
                              deleteExpense(expense.id);
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Add',
        onPressed: () {
          openExpenseForm();
        },
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }
}
