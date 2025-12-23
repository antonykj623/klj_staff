import 'package:kljcafe_staff_new/generated/json/base/json_convert_content.dart';
import 'package:kljcafe_staff_new/domain/expense_data_entity.dart';

ExpenseDataEntity $ExpenseDataEntityFromJson(Map<String, dynamic> json) {
  final ExpenseDataEntity expenseDataEntity = ExpenseDataEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    expenseDataEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    expenseDataEntity.message = message;
  }
  final List<ExpenseDataData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ExpenseDataData>(e) as ExpenseDataData)
      .toList();
  if (data != null) {
    expenseDataEntity.data = data;
  }
  return expenseDataEntity;
}

Map<String, dynamic> $ExpenseDataEntityToJson(ExpenseDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ExpenseDataEntityExtension on ExpenseDataEntity {
  ExpenseDataEntity copyWith({
    int? status,
    String? message,
    List<ExpenseDataData>? data,
  }) {
    return ExpenseDataEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

ExpenseDataData $ExpenseDataDataFromJson(Map<String, dynamic> json) {
  final ExpenseDataData expenseDataData = ExpenseDataData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    expenseDataData.id = id;
  }
  final String? amount = jsonConvert.convert<String>(json['amount']);
  if (amount != null) {
    expenseDataData.amount = amount;
  }
  final String? purpose = jsonConvert.convert<String>(json['purpose']);
  if (purpose != null) {
    expenseDataData.purpose = purpose;
  }
  final String? addedEmployee = jsonConvert.convert<String>(
      json['added_employee']);
  if (addedEmployee != null) {
    expenseDataData.addedEmployee = addedEmployee;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    expenseDataData.description = description;
  }
  final String? enteredDate = jsonConvert.convert<String>(json['entered_date']);
  if (enteredDate != null) {
    expenseDataData.enteredDate = enteredDate;
  }
  final String? createdDate = jsonConvert.convert<String>(json['created_date']);
  if (createdDate != null) {
    expenseDataData.createdDate = createdDate;
  }
  final String? updatedDate = jsonConvert.convert<String>(json['updated_date']);
  if (updatedDate != null) {
    expenseDataData.updatedDate = updatedDate;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    expenseDataData.status = status;
  }
  final String? cIncId = jsonConvert.convert<String>(json['c_inc_id']);
  if (cIncId != null) {
    expenseDataData.cIncId = cIncId;
  }
  final String? cuId = jsonConvert.convert<String>(json['cu_id']);
  if (cuId != null) {
    expenseDataData.cuId = cuId;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    expenseDataData.name = name;
  }
  return expenseDataData;
}

Map<String, dynamic> $ExpenseDataDataToJson(ExpenseDataData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['amount'] = entity.amount;
  data['purpose'] = entity.purpose;
  data['added_employee'] = entity.addedEmployee;
  data['description'] = entity.description;
  data['entered_date'] = entity.enteredDate;
  data['created_date'] = entity.createdDate;
  data['updated_date'] = entity.updatedDate;
  data['status'] = entity.status;
  data['c_inc_id'] = entity.cIncId;
  data['cu_id'] = entity.cuId;
  data['name'] = entity.name;
  return data;
}

extension ExpenseDataDataExtension on ExpenseDataData {
  ExpenseDataData copyWith({
    String? id,
    String? amount,
    String? purpose,
    String? addedEmployee,
    String? description,
    String? enteredDate,
    String? createdDate,
    String? updatedDate,
    String? status,
    String? cIncId,
    String? cuId,
    String? name,
  }) {
    return ExpenseDataData()
      ..id = id ?? this.id
      ..amount = amount ?? this.amount
      ..purpose = purpose ?? this.purpose
      ..addedEmployee = addedEmployee ?? this.addedEmployee
      ..description = description ?? this.description
      ..enteredDate = enteredDate ?? this.enteredDate
      ..createdDate = createdDate ?? this.createdDate
      ..updatedDate = updatedDate ?? this.updatedDate
      ..status = status ?? this.status
      ..cIncId = cIncId ?? this.cIncId
      ..cuId = cuId ?? this.cuId
      ..name = name ?? this.name;
  }
}