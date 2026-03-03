// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
