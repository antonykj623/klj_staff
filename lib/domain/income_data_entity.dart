import 'package:kljcafe_staff_new/generated/json/base/json_field.dart';
import 'package:kljcafe_staff_new/generated/json/income_data_entity.g.dart';
import 'dart:convert';
export 'package:kljcafe_staff_new/generated/json/income_data_entity.g.dart';

@JsonSerializable()
class IncomeDataEntity {
	int? status = 0;
	String? message = '';
	List<IncomeDataData>? data = [];

	IncomeDataEntity();

	factory IncomeDataEntity.fromJson(Map<String, dynamic> json) => $IncomeDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $IncomeDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class IncomeDataData {
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

	IncomeDataData();

	factory IncomeDataData.fromJson(Map<String, dynamic> json) => $IncomeDataDataFromJson(json);

	Map<String, dynamic> toJson() => $IncomeDataDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}