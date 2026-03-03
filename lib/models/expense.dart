import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'expense.g.dart';

const uuid = Uuid();
final dateFormatter = DateFormat.yMd();

@HiveType(typeId: 1)
enum ExpenseCategory {
  @HiveField(0)
  essentials,
  @HiveField(1)
  foodDining,
  @HiveField(2)
  transportation,
  @HiveField(3)
  healthFitness,
  @HiveField(4)
  educationSubscriptions,
  @HiveField(5)
  entertainmentLeisure,
  @HiveField(6)
  shopping,
  @HiveField(7)
  travel,
  @HiveField(8)
  workBusiness,
  @HiveField(9)
  financeSavings,
  @HiveField(10)
  giftsDonations,
  @HiveField(11)
  miscellaneous,
}

extension ExpenseCategoryExtension on ExpenseCategory {
  String get label {
    switch (this) {
      case ExpenseCategory.essentials: return "Essentials";
      case ExpenseCategory.foodDining: return "Food & Dining";
      case ExpenseCategory.transportation: return "Transportation";
      case ExpenseCategory.healthFitness: return "Health & Fitness";
      case ExpenseCategory.educationSubscriptions: return "Education & Subscriptions";
      case ExpenseCategory.entertainmentLeisure: return "Entertainment & Leisure";
      case ExpenseCategory.shopping: return "Shopping";
      case ExpenseCategory.travel: return "Travel";
      case ExpenseCategory.workBusiness: return "Work / Business";
      case ExpenseCategory.financeSavings: return "Finance & Savings";
      case ExpenseCategory.giftsDonations: return "Gifts & Donations";
      case ExpenseCategory.miscellaneous: return "Miscellaneous";
    }
  }

  IconData get icon {
    switch (this) {
      case ExpenseCategory.essentials: return Icons.home_rounded;
      case ExpenseCategory.foodDining: return Icons.restaurant_rounded;
      case ExpenseCategory.transportation: return Icons.directions_car_rounded;
      case ExpenseCategory.healthFitness: return Icons.fitness_center_rounded;
      case ExpenseCategory.educationSubscriptions: return Icons.school_rounded;
      case ExpenseCategory.entertainmentLeisure: return Icons.movie_rounded;
      case ExpenseCategory.shopping: return Icons.shopping_cart_rounded;
      case ExpenseCategory.travel: return Icons.flight_takeoff_rounded;
      case ExpenseCategory.workBusiness: return Icons.work_rounded;
      case ExpenseCategory.financeSavings: return Icons.account_balance_wallet_rounded;
      case ExpenseCategory.giftsDonations: return Icons.card_giftcard_rounded;
      case ExpenseCategory.miscellaneous: return Icons.category_rounded;
    }
  }

  Color get color {
    switch (this) {
      case ExpenseCategory.essentials: return const Color(0xFF1E88E5);
      case ExpenseCategory.foodDining: return const Color(0xFFFFC107);
      case ExpenseCategory.transportation: return const Color(0xFF4CAF50);
      case ExpenseCategory.healthFitness: return const Color(0xFFE91E63);
      case ExpenseCategory.educationSubscriptions: return const Color(0xFF9C27B0);
      case ExpenseCategory.entertainmentLeisure: return const Color(0xFFFF5722);
      case ExpenseCategory.shopping: return const Color(0xFF795548);
      case ExpenseCategory.travel: return const Color(0xFF00BCD4);
      case ExpenseCategory.workBusiness: return const Color(0xFF607D8B);
      case ExpenseCategory.financeSavings: return const Color(0xFF43A047);
      case ExpenseCategory.giftsDonations: return const Color(0xFFFF80AB);
      case ExpenseCategory.miscellaneous: return const Color(0xFF9E9E9E);
    }
  }
}

@HiveType(typeId: 0)
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.expenseCategory,
    String? id,
    this.note,
  }) : id = id ?? uuid.v4();

  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final double amount;
  
  @HiveField(3)
  final DateTime date;
  
  @HiveField(4)
  final ExpenseCategory expenseCategory;
  
  @HiveField(5)
  final String? note;

  String get formattedDate {
    return dateFormatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses =
          allExpenses
              .where((expense) => expense.expenseCategory == category)
              .toList();

  final ExpenseCategory category;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
