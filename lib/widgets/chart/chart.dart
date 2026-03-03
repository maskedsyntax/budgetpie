import 'package:budgetpie/models/expense.dart';
import 'package:flutter/material.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return ExpenseCategory.values.map((category) {
      return ExpenseBucket.forCategory(expenses, category);
    }).toList();
  }

  double get maxTotalExpense {
    double max = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpense > max) {
        max = bucket.totalExpense;
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.15),
            Theme.of(context).colorScheme.primary.withOpacity(0.02),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  if (bucket.totalExpense > 0 || buckets.where((b) => b.totalExpense > 0).length < 5)
                  ChartBar(
                    fill: maxTotalExpense == 0 ? 0 : bucket.totalExpense / maxTotalExpense,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets.map((bucket) {
              if (bucket.totalExpense == 0 && buckets.where((b) => b.totalExpense > 0).length >= 5) {
                return const SizedBox.shrink();
              }
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Icon(
                    bucket.category.icon,
                    size: 18,
                    color: isDarkMode
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
