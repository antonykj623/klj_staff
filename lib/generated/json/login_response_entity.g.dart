import 'package:kljcafe_staff_new/generated/json/base/json_convert_content.dart';
import 'package:kljcafe_staff_new/domain/login_response_entity.dart';

LoginResponseEntity $LoginResponseEntityFromJson(Map<String, dynamic> json) {
  final LoginResponseEntity loginResponseEntity = LoginResponseEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    loginResponseEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    loginResponseEntity.message = message;
  }
  final LoginResponseData? data = jsonConvert.convert<LoginResponseData>(
      json['data']);
  if (data != null) {
    loginResponseEntity.data = data;
  }
  return loginResponseEntity;
}

Map<String, dynamic> $LoginResponseEntityToJson(LoginResponseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension LoginResponseEntityExtension on LoginResponseEntity {
  LoginResponseEntity copyWith({
    int? status,
    String? message,
    LoginResponseData? data,
  }) {
    return LoginResponseEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

LoginResponseData $LoginResponseDataFromJson(Map<String, dynamic> json) {
  final LoginResponseData loginResponseData = LoginResponseData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    loginResponseData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    loginResponseData.name = name;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    loginResponseData.mobile = mobile;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    loginResponseData.password = password;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    loginResponseData.image = image;
  }
  final String? deviceId = jsonConvert.convert<String>(json['device_id']);
  if (deviceId != null) {
    loginResponseData.deviceId = deviceId;
  }
  final String? usertype = jsonConvert.convert<String>(json['usertype']);
  if (usertype != null) {
    loginResponseData.usertype = usertype;
  }
  final String? referedUser = jsonConvert.convert<String>(json['refered_user']);
  if (referedUser != null) {
    loginResponseData.referedUser = referedUser;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    loginResponseData.status = status;
  }
  final String? createdDate = jsonConvert.convert<String>(json['created_date']);
  if (createdDate != null) {
    loginResponseData.createdDate = createdDate;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    loginResponseData.token = token;
  }
  return loginResponseData;
}

Map<String, dynamic> $LoginResponseDataToJson(LoginResponseData entity) {
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
  data['token'] = entity.token;
  return data;
}

extension LoginResponseDataExtension on LoginResponseData {
  LoginResponseData copyWith({
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
    String? token,
  }) {
    return LoginResponseData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..mobile = mobile ?? this.mobile
      ..password = password ?? this.password
      ..image = image ?? this.image
      ..deviceId = deviceId ?? this.deviceId
      ..usertype = usertype ?? this.usertype
      ..referedUser = referedUser ?? this.referedUser
      ..status = status ?? this.status
      ..createdDate = createdDate ?? this.createdDate
      ..token = token ?? this.token;
  }
}