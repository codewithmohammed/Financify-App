// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModelAdapter extends TypeAdapter<TransactionModel> {
  @override
  final int typeId = 5;

  @override
  TransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      id: fields[0] as String,
      amount: fields[1] as String,
      accountname: fields[2] as String,
      toaccountname: fields[3] as String,
      transactiondate: fields[4] as String,
      fromaccountname: fields[5] as String,
      categoryname: fields[6] as String,
      accountnote: fields[7] as String,
      type: fields[8] as TransactionCategoryType,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.accountname)
      ..writeByte(3)
      ..write(obj.toaccountname)
      ..writeByte(4)
      ..write(obj.transactiondate)
      ..writeByte(5)
      ..write(obj.fromaccountname)
      ..writeByte(6)
      ..write(obj.categoryname)
      ..writeByte(7)
      ..write(obj.accountnote)
      ..writeByte(8)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionCategoryTypeAdapter
    extends TypeAdapter<TransactionCategoryType> {
  @override
  final int typeId = 4;

  @override
  TransactionCategoryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionCategoryType.income;
      case 1:
        return TransactionCategoryType.expense;
      case 2:
        return TransactionCategoryType.transfer;
      default:
        return TransactionCategoryType.income;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionCategoryType obj) {
    switch (obj) {
      case TransactionCategoryType.income:
        writer.writeByte(0);
        break;
      case TransactionCategoryType.expense:
        writer.writeByte(1);
        break;
      case TransactionCategoryType.transfer:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionCategoryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
