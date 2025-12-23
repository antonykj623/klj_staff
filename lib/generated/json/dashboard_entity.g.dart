import 'package:kljcafe_staff_new/generated/json/base/json_convert_content.dart';
import 'package:kljcafe_staff_new/domain/dashboard_entity.dart';

DashboardEntity $DashboardEntityFromJson(Map<String, dynamic> json) {
  final DashboardEntity dashboardEntity = DashboardEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    dashboardEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    dashboardEntity.message = message;
  }
  final List<DashboardIncomedata>? incomedata = (json['incomedata'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<DashboardIncomedata>(e) as DashboardIncomedata)
      .toList();
  if (incomedata != null) {
    dashboardEntity.incomedata = incomedata;
  }
  final List<DashboardExpensedata>? expensedata = (json['expensedata'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<DashboardExpensedata>(e) as DashboardExpensedata)
      .toList();
  if (expensedata != null) {
    dashboardEntity.expensedata = expensedata;
  }
  final int? totalIncome = jsonConvert.convert<int>(json['total_income']);
  if (totalIncome != null) {
    dashboardEntity.totalIncome = totalIncome;
  }
  final int? totalExpense = jsonConvert.convert<int>(json['total_expense']);
  if (totalExpense != null) {
    dashboardEntity.totalExpense = totalExpense;
  }
  return dashboardEntity;
}

Map<String, dynamic> $DashboardEntityToJson(DashboardEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['incomedata'] = entity.incomedata?.map((v) => v.toJson()).toList();
  data['expensedata'] = entity.expensedata?.map((v) => v.toJson()).toList();
  data['total_income'] = entity.totalIncome;
  data['total_expense'] = entity.totalExpense;
  return data;
}

extension DashboardEntityExtension on DashboardEntity {
  DashboardEntity copyWith({
    int? status,
    String? message,
    List<DashboardIncomedata>? incomedata,
    List<DashboardExpensedata>? expensedata,
    int? totalIncome,
    int? totalExpense,
  }) {
    return DashboardEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..incomedata = incomedata ?? this.incomedata
      ..expensedata = expensedata ?? this.expensedata
      ..totalIncome = totalIncome ?? this.totalIncome
      ..totalExpense = totalExpense ?? this.totalExpense;
  }
}

DashboardIncomedata $DashboardIncomedataFromJson(Map<String, dynamic> json) {
  final DashboardIncomedata dashboardIncomedata = DashboardIncomedata();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    dashboardIncomedata.id = id;
  }
  final String? amount = jsonConvert.convert<String>(json['amount']);
  if (amount != null) {
    dashboardIncomedata.amount = amount;
  }
  final String? purpose = jsonConvert.convert<String>(json['purpose']);
  if (purpose != null) {
    dashboardIncomedata.purpose = purpose;
  }
  final String? addedEmployee = jsonConvert.convert<String>(
      json['added_employee']);
  if (addedEmployee != null) {
    dashboardIncomedata.addedEmployee = addedEmployee;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    dashboardIncomedata.description = description;
  }
  final String? enteredDate = jsonConvert.convert<String>(json['entered_date']);
  if (enteredDate != null) {
    dashboardIncomedata.enteredDate = enteredDate;
  }
  final String? createdDate = jsonConvert.convert<String>(json['created_date']);
  if (createdDate != null) {
    dashboardIncomedata.createdDate = createdDate;
  }
  final String? updatedDate = jsonConvert.convert<String>(json['updated_date']);
  if (updatedDate != null) {
    dashboardIncomedata.updatedDate = updatedDate;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    dashboardIncomedata.status = status;
  }
  final String? cIncId = jsonConvert.convert<String>(json['c_inc_id']);
  if (cIncId != null) {
    dashboardIncomedata.cIncId = cIncId;
  }
  final String? cuId = jsonConvert.convert<String>(json['cu_id']);
  if (cuId != null) {
    dashboardIncomedata.cuId = cuId;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    dashboardIncomedata.name = name;
  }
  return dashboardIncomedata;
}

Map<String, dynamic> $DashboardIncomedataToJson(DashboardIncomedata entity) {
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

extension DashboardIncomedataExtension on DashboardIncomedata {
  DashboardIncomedata copyWith({
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
    return DashboardIncomedata()
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

DashboardExpensedata $DashboardExpensedataFromJson(Map<String, dynamic> json) {
  final DashboardExpensedata dashboardExpensedata = DashboardExpensedata();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    dashboardExpensedata.id = id;
  }
  final String? amount = jsonConvert.convert<String>(json['amount']);
  if (amount != null) {
    dashboardExpensedata.amount = amount;
  }
  final String? walletAmount = jsonConvert.convert<String>(
      json['wallet_amount']);
  if (walletAmount != null) {
    dashboardExpensedata.walletAmount = walletAmount;
  }
  final String? createdEmployee = jsonConvert.convert<String>(
      json['created_employee']);
  if (createdEmployee != null) {
    dashboardExpensedata.createdEmployee = createdEmployee;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    dashboardExpensedata.userId = userId;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    dashboardExpensedata.description = description;
  }
  final String? enteredDate = jsonConvert.convert<String>(json['entered_date']);
  if (enteredDate != null) {
    dashboardExpensedata.enteredDate = enteredDate;
  }
  final String? createdDate = jsonConvert.convert<String>(json['created_date']);
  if (createdDate != null) {
    dashboardExpensedata.createdDate = createdDate;
  }
  final String? updatedDate = jsonConvert.convert<String>(json['updated_date']);
  if (updatedDate != null) {
    dashboardExpensedata.updatedDate = updatedDate;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    dashboardExpensedata.status = status;
  }
  final String? cIncId = jsonConvert.convert<String>(json['c_inc_id']);
  if (cIncId != null) {
    dashboardExpensedata.cIncId = cIncId;
  }
  final String? cuId = jsonConvert.convert<String>(json['cu_id']);
  if (cuId != null) {
    dashboardExpensedata.cuId = cuId;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    dashboardExpensedata.name = name;
  }
  return dashboardExpensedata;
}

Map<String, dynamic> $DashboardExpensedataToJson(DashboardExpensedata entity) {
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

extension DashboardExpensedataExtension on DashboardExpensedata {
  DashboardExpensedata copyWith({
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
    return DashboardExpensedata()
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