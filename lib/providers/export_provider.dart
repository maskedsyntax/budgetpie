import 'dart:io';
import 'package:budgetpie/models/expense.dart';
import 'package:budgetpie/providers/expense_provider.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'export_provider.g.dart';

@riverpod
class ExportNotifier extends _$ExportNotifier {
  @override
  void build() {}

  Future<void> exportToCsv() async {
    final expenses = await ref.read(expensesNotifierProvider.future);
    
    if (expenses.isEmpty) return;

    List<List<dynamic>> rows = [];
    
    // Header
    rows.add(["ID", "Date", "Title", "Amount", "Category", "Note"]);

    for (var expense in expenses) {
      rows.add([
        expense.id,
        expense.formattedDate,
        expense.title,
        expense.amount,
        expense.expenseCategory.label,
        expense.note ?? ""
      ]);
    }

    String csvData = const ListToCsvConverter().convert(rows);
    
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/budgetpie_export.csv');
    
    await file.writeAsString(csvData);
    
    final xFile = XFile(file.path);
    await Share.shareXFiles([xFile], text: 'My BudgetPie Expense Export');
  }
}
