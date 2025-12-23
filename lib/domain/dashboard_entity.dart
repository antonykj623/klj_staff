import 'package:kljcafe_staff_new/generated/json/base/json_field.dart';
import 'package:kljcafe_staff_new/generated/json/dashboard_entity.g.dart';
import 'dart:convert';
export 'package:kljcafe_staff_new/generated/json/dashboard_entity.g.dart';

@JsonSerializable()
class DashboardEntity {
	int? status = 0;
	String? message = '';
	List<DashboardIncomedata>? incomedata = [];
	List<DashboardExpensedata>? expensedata = [];
	@JSONField(name: "total_income")
	int? totalIncome = 0;
	@JSONField(name: "total_expense")
	int? totalExpense = 0;

	DashboardEntity();

	factory DashboardEntity.fromJson(Map<String, dynamic> json) => $DashboardEntityFromJson(json);

	Map<String, dynamic> toJson() => $DashboardEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class DashboardIncomedata {
	String? id = '';
	String? amount = '';
	String? purpose = '';
	@JSONField(name: "added_employee")
	String? addedEmployee = '';
	String? description = '';
	@JSONField(name: "entered_date")
	String? enteredDate = '';
	@JSONField(name: "created_date")
	String? createdDate = '';
	@JSONField(name: "updated_date")
	String? updatedDate = '';
	String? status = '';
	@JSONField(name: "c_inc_id")
	String? cIncId = '';
	@JSONField(name: "cu_id")
	String? cuId = '';
	String? name = '';

	DashboardIncomedata();

	factory DashboardIncomedata.fromJson(Map<String, dynamic> json) => $DashboardIncomedataFromJson(json);

	Map<String, dynamic> toJson() => $DashboardIncomedataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class DashboardExpensedata {
	String? id = '';
	String? amount = '';
	@JSONField(name: "wallet_amount")
	String? walletAmount = '';
	@JSONField(name: "created_employee")
	String? createdEmployee = '';
	@JSONField(name: "user_id")
	String? userId = '';
	String? description = '';
	@JSONField(name: "entered_date")
	String? enteredDate = '';
	@JSONField(name: "created_date")
	String? createdDate = '';
	@JSONField(name: "updated_date")
	String? updatedDate = '';
	String? status = '';
	@JSONField(name: "c_inc_id")
	String? cIncId = '';
	@JSONField(name: "cu_id")
	String? cuId = '';
	String? name = '';

	DashboardExpensedata();

	factory DashboardExpensedata.fromJson(Map<String, dynamic> json) => $DashboardExpensedataFromJson(json);

	Map<String, dynamic> toJson() => $DashboardExpensedataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}