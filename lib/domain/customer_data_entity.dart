import 'package:kljcafe_staff_new/generated/json/base/json_field.dart';
import 'package:kljcafe_staff_new/generated/json/customer_data_entity.g.dart';
import 'dart:convert';
export 'package:kljcafe_staff_new/generated/json/customer_data_entity.g.dart';

@JsonSerializable()
class CustomerDataEntity {
	int? status = 0;
	String? message = '';
	CustomerDataData? data;

	CustomerDataEntity();

	factory CustomerDataEntity.fromJson(Map<String, dynamic> json) => $CustomerDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $CustomerDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CustomerDataData {
	String? id = '';
	String? name = '';
	String? mobile = '';
	String? password = '';
	String? image = '';
	@JSONField(name: "device_id")
	String? deviceId = '';
	String? usertype = '';
	@JSONField(name: "refered_user")
	String? referedUser = '';
	String? status = '';
	@JSONField(name: "created_date")
	String? createdDate = '';

	CustomerDataData();

	factory CustomerDataData.fromJson(Map<String, dynamic> json) => $CustomerDataDataFromJson(json);

	Map<String, dynamic> toJson() => $CustomerDataDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}