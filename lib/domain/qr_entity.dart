import 'package:kljcafe_staff_new/generated/json/base/json_field.dart';
import 'package:kljcafe_staff_new/generated/json/qr_entity.g.dart';
import 'dart:convert';
export 'package:kljcafe_staff_new/generated/json/qr_entity.g.dart';

@JsonSerializable()
class QrEntity {
	int? status = 0;
	String? message = '';
	String? data = '';

	QrEntity();

	factory QrEntity.fromJson(Map<String, dynamic> json) => $QrEntityFromJson(json);

	Map<String, dynamic> toJson() => $QrEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}