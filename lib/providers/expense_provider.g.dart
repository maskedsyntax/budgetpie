// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredExpensesHash() => r'c8b76d82fbd0c304396fc1c98e1bfd6daf70b864';

/// See also [filteredExpenses].
@ProviderFor(filteredExpenses)
final filteredExpensesProvider =
    AutoDisposeFutureProvider<List<Expense>>.internal(
      filteredExpenses,
      name: r'filteredExpensesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$filteredExpensesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredExpensesRef = AutoDisposeFutureProviderRef<List<Expense>>;
String _$expensesNotifierHash() => r'87e0a3335e65085ddb795edb18e2028812fccd78';

/// See also [ExpensesNotifier].
@ProviderFor(ExpensesNotifier)
final expensesNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ExpensesNotifier, List<Expense>>.internal(
      ExpensesNotifier.new,
      name: r'expensesNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$expensesNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ExpensesNotifier = AutoDisposeAsyncNotifier<List<Expense>>;
String _$categoryFilterHash() => r'35cdbc55983df7d507e1d7eda0c360800f47a332';

/// See also [CategoryFilter].
@ProviderFor(CategoryFilter)
final categoryFilterProvider =
    AutoDisposeNotifierProvider<CategoryFilter, ExpenseCategory?>.internal(
      CategoryFilter.new,
      name: r'categoryFilterProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$categoryFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CategoryFilter = AutoDisposeNotifier<ExpenseCategory?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
