import 'package:kljcafe_staff_new/generated/json/base/json_field.dart';
import 'package:kljcafe_staff_new/generated/json/expense_data_entity.g.dart';
import 'dart:convert';
export 'package:kljcafe_staff_new/generated/json/expense_data_entity.g.dart';

@JsonSerializable()
class ExpenseDataEntity {
	int? status = 0;
	String? message = '';
	List<ExpenseDataData>? data = [];

	ExpenseDataEntity();

	factory ExpenseDataEntity.fromJson(Map<String, dynamic> json) => $ExpenseDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $ExpenseDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ExpenseDataData {
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

	ExpenseDataData();

	factory ExpenseDataData.fromJson(Map<String, dynamic> json) => $ExpenseDataDataFromJson(json);

	Map<String, dynamic> toJson() => $ExpenseDataDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}