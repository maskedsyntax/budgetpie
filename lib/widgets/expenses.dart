import 'package:budgetpie/providers/export_provider.dart';
import 'package:budgetpie/widgets/analytics/analytics_screen.dart';
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
    final filteredExpensesAsync = ref.watch(filteredExpensesProvider);
    final currentFilter = ref.watch(categoryFilterProvider);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/budgetpie.png', height: 60),
                    const SizedBox(height: 12),
                    const Text(
                      "BudgetPie Premium",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Analytics"),
              subtitle: const Text("View spending breakdown"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => const AnalyticsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_download),
              title: const Text("Export to CSV"),
              subtitle: const Text("Backup your data"),
              onTap: () {
                Navigator.pop(context);
                ref.read(exportNotifierProvider.notifier).exportToCsv();
              },
            ),
            ListTile(
              leading: const Icon(Icons.sync),
              title: const Text("Cloud Sync"),
              subtitle: const Text("Sync data across devices"),
              trailing: Chip(
                label: const Text("Coming Soon", style: TextStyle(fontSize: 10)),
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active),
              title: const Text("Recurring Reminders"),
              subtitle: const Text("Never miss a bill"),
              trailing: Chip(
                label: const Text("Coming Soon", style: TextStyle(fontSize: 10)),
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text("AI Spending Insights"),
              subtitle: const Text("Smart patterns detection"),
              trailing: Chip(
                label: const Text("Coming Soon", style: TextStyle(fontSize: 10)),
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("v1.0.0", style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset('assets/budgetpie.png', height: 32),
            ),
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
        data: (allExpenses) {
          if (allExpenses.isEmpty) {
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

          final totalSpending = allExpenses.fold<double>(0, (sum, item) => sum + item.amount);

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
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (ctx) => const AnalyticsScreen()),
                          ),
                          icon: const Icon(Icons.bar_chart, size: 28),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const Icon(Icons.trending_down, color: Colors.red, size: 32),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: -0.2, end: 0),
              
              const SizedBox(height: 16),
              
              // Category Filter Bar
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: const Text("All"),
                        selected: currentFilter == null,
                        onSelected: (_) => ref.read(categoryFilterProvider.notifier).setFilter(null),
                      ),
                    ),
                    ...ExpenseCategory.values.map((cat) {
                      final isSelected = currentFilter == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          avatar: Icon(cat.icon, size: 14, color: isSelected ? Colors.white : null),
                          label: Text(cat.label),
                          selected: isSelected,
                          onSelected: (selected) {
                            ref.read(categoryFilterProvider.notifier).setFilter(selected ? cat : null);
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ).animate().fadeIn(delay: 100.ms),

              filteredExpensesAsync.when(
                data: (filteredExpenses) {
                  return Expanded(
                    child: Column(
                      children: [
                        if (width < 600) ...[
                          Chart(expenses: filteredExpenses).animate().fadeIn().scale(delay: 200.ms),
                          Expanded(
                            child: ExpensesList(
                              expenses: filteredExpenses,
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
                                Expanded(child: Chart(expenses: filteredExpenses)),
                                Expanded(
                                  child: ExpensesList(
                                    expenses: filteredExpenses,
                                    onDeleteExpense: (expense) => ref.read(expensesNotifierProvider.notifier).deleteExpense(expense),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
                loading: () => const Expanded(child: Center(child: CircularProgressIndicator())),
                error: (err, stack) => Center(child: Text("Error: $err")),
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
