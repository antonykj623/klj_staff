import 'package:kljcafe_staff_new/generated/json/base/json_field.dart';
import 'package:kljcafe_staff_new/generated/json/login_response_entity.g.dart';
import 'dart:convert';
export 'package:kljcafe_staff_new/generated/json/login_response_entity.g.dart';

@JsonSerializable()
class LoginResponseEntity {
	int? status = 0;
	String? message = '';
	LoginResponseData? data;

	LoginResponseEntity();

	factory LoginResponseEntity.fromJson(Map<String, dynamic> json) => $LoginResponseEntityFromJson(json);

	Map<String, dynamic> toJson() => $LoginResponseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LoginResponseData {
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
	String? token = '';

	LoginResponseData();

	factory LoginResponseData.fromJson(Map<String, dynamic> json) => $LoginResponseDataFromJson(json);

	Map<String, dynamic> toJson() => $LoginResponseDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}