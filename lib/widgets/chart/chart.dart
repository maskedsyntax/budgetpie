import 'package:budgetpie/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  // Create buckets for the last 7 days
  List<Map<String, dynamic>> get dailyBuckets {
    final now = DateTime.now();
    final List<Map<String, dynamic>> buckets = [];

    for (int i = 6; i >= 0; i--) {
      final day = now.subtract(Duration(days: i));
      final dayStart = DateTime(day.year, day.month, day.day);
      
      double total = 0;
      for (final expense in expenses) {
        if (expense.date.year == day.year &&
            expense.date.month == day.month &&
            expense.date.day == day.day) {
          total += expense.amount;
        }
      }
      
      buckets.add({
        'day': DateFormat.E().format(day), // Mon, Tue, etc.
        'total': total,
        'isToday': i == 0,
      });
    }
    return buckets;
  }

  double get maxTotalExpense {
    double max = 0;
    for (final bucket in dailyBuckets) {
      if (bucket['total'] > max) {
        max = bucket['total'];
      }
    }
    return max == 0 ? 1 : max; // Avoid division by zero
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final buckets = dailyBuckets;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
                  ChartBar(
                    fill: bucket['total'] / maxTotalExpense,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets.map((bucket) {
              final isToday = bucket['isToday'] as bool;
              return Expanded(
                child: Center(
                  child: Text(
                    bucket['day'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      color: isToday 
                          ? Theme.of(context).colorScheme.primary 
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
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
