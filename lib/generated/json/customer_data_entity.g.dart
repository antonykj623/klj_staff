import 'package:kljcafe_staff_new/generated/json/base/json_convert_content.dart';
import 'package:kljcafe_staff_new/domain/customer_data_entity.dart';

CustomerDataEntity $CustomerDataEntityFromJson(Map<String, dynamic> json) {
  final CustomerDataEntity customerDataEntity = CustomerDataEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    customerDataEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    customerDataEntity.message = message;
  }
  final CustomerDataData? data = jsonConvert.convert<CustomerDataData>(
      json['data']);
  if (data != null) {
    customerDataEntity.data = data;
  }
  return customerDataEntity;
}

Map<String, dynamic> $CustomerDataEntityToJson(CustomerDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension CustomerDataEntityExtension on CustomerDataEntity {
  CustomerDataEntity copyWith({
    int? status,
    String? message,
    CustomerDataData? data,
  }) {
    return CustomerDataEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

CustomerDataData $CustomerDataDataFromJson(Map<String, dynamic> json) {
  final CustomerDataData customerDataData = CustomerDataData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    customerDataData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    customerDataData.name = name;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    customerDataData.mobile = mobile;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    customerDataData.password = password;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    customerDataData.image = image;
  }
  final String? deviceId = jsonConvert.convert<String>(json['device_id']);
  if (deviceId != null) {
    customerDataData.deviceId = deviceId;
  }
  final String? usertype = jsonConvert.convert<String>(json['usertype']);
  if (usertype != null) {
    customerDataData.usertype = usertype;
  }
  final String? referedUser = jsonConvert.convert<String>(json['refered_user']);
  if (referedUser != null) {
    customerDataData.referedUser = referedUser;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    customerDataData.status = status;
  }
  final String? createdDate = jsonConvert.convert<String>(json['created_date']);
  if (createdDate != null) {
    customerDataData.createdDate = createdDate;
  }
  return customerDataData;
}

Map<String, dynamic> $CustomerDataDataToJson(CustomerDataData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['mobile'] = entity.mobile;
  data['password'] = entity.password;
  data['image'] = entity.image;
  data['device_id'] = entity.deviceId;
  data['usertype'] = entity.usertype;
  data['refered_user'] = entity.referedUser;
  data['status'] = entity.status;
  data['created_date'] = entity.createdDate;
  return data;
}

extension CustomerDataDataExtension on CustomerDataData {
  CustomerDataData copyWith({
    String? id,
    String? name,
    String? mobile,
    String? password,
    String? image,
    String? deviceId,
    String? usertype,
    String? referedUser,
    String? status,
    String? createdDate,
  }) {
    return CustomerDataData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..mobile = mobile ?? this.mobile
      ..password = password ?? this.password
      ..image = image ?? this.image
      ..deviceId = deviceId ?? this.deviceId
      ..usertype = usertype ?? this.usertype
      ..referedUser = referedUser ?? this.referedUser
      ..status = status ?? this.status
      ..createdDate = createdDate ?? this.createdDate;
  }
}