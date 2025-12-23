import 'package:kljcafe_staff_new/generated/json/base/json_convert_content.dart';
import 'package:kljcafe_staff_new/domain/income_data_entity.dart';

IncomeDataEntity $IncomeDataEntityFromJson(Map<String, dynamic> json) {
  final IncomeDataEntity incomeDataEntity = IncomeDataEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    incomeDataEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    incomeDataEntity.message = message;
  }
  final List<IncomeDataData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<IncomeDataData>(e) as IncomeDataData)
      .toList();
  if (data != null) {
    incomeDataEntity.data = data;
  }
  return incomeDataEntity;
}

Map<String, dynamic> $IncomeDataEntityToJson(IncomeDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension IncomeDataEntityExtension on IncomeDataEntity {
  IncomeDataEntity copyWith({
    int? status,
    String? message,
    List<IncomeDataData>? data,
  }) {
    return IncomeDataEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

IncomeDataData $IncomeDataDataFromJson(Map<String, dynamic> json) {
  final IncomeDataData incomeDataData = IncomeDataData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    incomeDataData.id = id;
  }
  final String? amount = jsonConvert.convert<String>(json['amount']);
  if (amount != null) {
    incomeDataData.amount = amount;
  }
  final String? walletAmount = jsonConvert.convert<String>(
      json['wallet_amount']);
  if (walletAmount != null) {
    incomeDataData.walletAmount = walletAmount;
  }
  final String? createdEmployee = jsonConvert.convert<String>(
      json['created_employee']);
  if (createdEmployee != null) {
    incomeDataData.createdEmployee = createdEmployee;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    incomeDataData.userId = userId;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    incomeDataData.description = description;
  }
  final String? enteredDate = jsonConvert.convert<String>(json['entered_date']);
  if (enteredDate != null) {
    incomeDataData.enteredDate = enteredDate;
  }
  final String? createdDate = jsonConvert.convert<String>(json['created_date']);
  if (createdDate != null) {
    incomeDataData.createdDate = createdDate;
  }
  final String? updatedDate = jsonConvert.convert<String>(json['updated_date']);
  if (updatedDate != null) {
    incomeDataData.updatedDate = updatedDate;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    incomeDataData.status = status;
  }
  final String? cIncId = jsonConvert.convert<String>(json['c_inc_id']);
  if (cIncId != null) {
    incomeDataData.cIncId = cIncId;
  }
  final String? cuId = jsonConvert.convert<String>(json['cu_id']);
  if (cuId != null) {
    incomeDataData.cuId = cuId;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    incomeDataData.name = name;
  }
  return incomeDataData;
}

Map<String, dynamic> $IncomeDataDataToJson(IncomeDataData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['amount'] = entity.amount;
  data['wallet_amount'] = entity.walletAmount;
  data['created_employee'] = entity.createdEmployee;
  data['user_id'] = entity.userId;
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

extension IncomeDataDataExtension on IncomeDataData {
  IncomeDataData copyWith({
    String? id,
    String? amount,
    String? walletAmount,
    String? createdEmployee,
    String? userId,
    String? description,
    String? enteredDate,
    String? createdDate,
    String? updatedDate,
    String? status,
    String? cIncId,
    String? cuId,
    String? name,
  }) {
    return IncomeDataData()
      ..id = id ?? this.id
      ..amount = amount ?? this.amount
      ..walletAmount = walletAmount ?? this.walletAmount
      ..createdEmployee = createdEmployee ?? this.createdEmployee
      ..userId = userId ?? this.userId
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