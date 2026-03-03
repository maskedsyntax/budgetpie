// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final typeId = 0;

  @override
  Expense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expense(
      title: fields[1] as String,
      amount: (fields[2] as num).toDouble(),
      date: fields[3] as DateTime,
      expenseCategory: fields[4] as ExpenseCategory,
      id: fields[0] as String?,
      note: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.expenseCategory)
      ..writeByte(5)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExpenseCategoryAdapter extends TypeAdapter<ExpenseCategory> {
  @override
  final typeId = 1;

  @override
  ExpenseCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseCategory.essentials;
      case 1:
        return ExpenseCategory.foodDining;
      case 2:
        return ExpenseCategory.transportation;
      case 3:
        return ExpenseCategory.healthFitness;
      case 4:
        return ExpenseCategory.educationSubscriptions;
      case 5:
        return ExpenseCategory.entertainmentLeisure;
      case 6:
        return ExpenseCategory.shopping;
      case 7:
        return ExpenseCategory.travel;
      case 8:
        return ExpenseCategory.workBusiness;
      case 9:
        return ExpenseCategory.financeSavings;
      case 10:
        return ExpenseCategory.giftsDonations;
      case 11:
        return ExpenseCategory.miscellaneous;
      default:
        return ExpenseCategory.essentials;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseCategory obj) {
    switch (obj) {
      case ExpenseCategory.essentials:
        writer.writeByte(0);
      case ExpenseCategory.foodDining:
        writer.writeByte(1);
      case ExpenseCategory.transportation:
        writer.writeByte(2);
      case ExpenseCategory.healthFitness:
        writer.writeByte(3);
      case ExpenseCategory.educationSubscriptions:
        writer.writeByte(4);
      case ExpenseCategory.entertainmentLeisure:
        writer.writeByte(5);
      case ExpenseCategory.shopping:
        writer.writeByte(6);
      case ExpenseCategory.travel:
        writer.writeByte(7);
      case ExpenseCategory.workBusiness:
        writer.writeByte(8);
      case ExpenseCategory.financeSavings:
        writer.writeByte(9);
      case ExpenseCategory.giftsDonations:
        writer.writeByte(10);
      case ExpenseCategory.miscellaneous:
        writer.writeByte(11);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
