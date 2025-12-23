import 'package:kljcafe_staff_new/generated/json/base/json_field.dart';
import 'package:kljcafe_staff_new/generated/json/app_update_entity.g.dart';
import 'dart:convert';
export 'package:kljcafe_staff_new/generated/json/app_update_entity.g.dart';

@JsonSerializable()
class AppUpdateEntity {
	int? status = 0;
	String? message = '';
	List<AppUpdateData> data = [];

	AppUpdateEntity();

	factory AppUpdateEntity.fromJson(Map<String, dynamic> json) => $AppUpdateEntityFromJson(json);

	Map<String, dynamic> toJson() => $AppUpdateEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AppUpdateData {
	String? id = '';
	String? version = '';
	String? url = '';
	@JSONField(name: "mobile_os")
	String? mobileOs = '';
	@JSONField(name: "mobile_app")
	String? mobileApp = '';

	AppUpdateData();

	factory AppUpdateData.fromJson(Map<String, dynamic> json) => $AppUpdateDataFromJson(json);

	Map<String, dynamic> toJson() => $AppUpdateDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}