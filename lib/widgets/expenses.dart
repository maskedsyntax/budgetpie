import 'package:budgetpie/providers/expense_provider.dart';
import 'package:budgetpie/widgets/chart/chart.dart';
import 'package:budgetpie/widgets/expenses_list/expenses_list.dart';
import 'package:budgetpie/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/expense.dart';

class Expenses extends ConsumerWidget {
  const Expenses({super.key});

  void _openAddExpenseOverlay(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => const NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expensesNotifierProvider);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/budgetpie.png', height: 32),
            const SizedBox(width: 12),
            const Text("BudgetPie"),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => _openAddExpenseOverlay(context),
              icon: const Icon(Icons.add),
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ).animate().scale(delay: 400.ms, duration: 400.ms, curve: Curves.easeOutBack),
        ],
      ),
      body: expensesAsync.when(
        data: (expenses) {
          if (expenses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "No expenses yet. Start tracking!",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ).animate().fadeIn().scale(),
            );
          }

          final totalSpending = expenses.fold<double>(0, (sum, item) => sum + item.amount);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Total Balance", style: TextStyle(color: Colors.grey)),
                        Text(
                          "\$${totalSpending.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.trending_down, color: Colors.red, size: 32),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: -0.2, end: 0),
              
              if (width < 600) ...[
                Chart(expenses: expenses).animate().fadeIn().scale(delay: 200.ms),
                Expanded(
                  child: ExpensesList(
                    expenses: expenses,
                    onDeleteExpense: (expense) {
                      ref.read(expensesNotifierProvider.notifier).deleteExpense(expense);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Expense Deleted"),
                          action: SnackBarAction(
                            label: "Undo",
                            onPressed: () => ref.read(expensesNotifierProvider.notifier).undoDelete(expense),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ] else
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Chart(expenses: expenses)),
                      Expanded(
                        child: ExpensesList(
                          expenses: expenses,
                          onDeleteExpense: (expense) => ref.read(expensesNotifierProvider.notifier).deleteExpense(expense),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
