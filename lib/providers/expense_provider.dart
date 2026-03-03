import 'package:budgetpie/models/expense.dart';
import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_provider.g.dart';

@riverpod
class ExpensesNotifier extends _$ExpensesNotifier {
  late Box<Expense> _box;

  @override
  Future<List<Expense>> build() async {
    _box = await Hive.openBox<Expense>('expenses_box');
    return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> addExpense(Expense expense) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _box.put(expense.id, expense);
      return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
    });
  }

  Future<void> deleteExpense(Expense expense) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _box.delete(expense.id);
      return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
    });
  }

  Future<void> undoDelete(Expense expense) async {
    await addExpense(expense);
  }
}
