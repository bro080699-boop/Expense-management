import 'package:flutter/material.dart';

import '../controllers/expense_controller.dart';
import '../utils/app_colors.dart';

class AnalyticsCard extends StatelessWidget {
  final ExpenseController controller;

  const AnalyticsCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final categoryTotals = controller.categoryTotals;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x222563EB),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Analytics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(
                'Total Expense: ₹${controller.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (categoryTotals.isEmpty)
              const Text(
                'No expense added yet',
                style: TextStyle(color: Colors.white),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categoryTotals.entries.map((item) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x26FFFFFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${item.key}: ₹${item.value.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
