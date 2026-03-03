import 'package:budgetpie/models/expense.dart';
import 'package:budgetpie/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onDeleteExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense) onDeleteExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        final expense = expenses[index];
        return Dismissible(
          key: ValueKey(expense.id),
          background: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white, size: 30),
          ),
          onDismissed: (direction) => onDeleteExpense(expense),
          child: ExpenseItem(expense: expense)
              .animate(delay: (index * 50).ms)
              .fadeIn(duration: 400.ms)
              .slideX(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
        );
      },
    );
  }
}
