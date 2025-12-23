import 'package:kljcafe_staff_new/generated/json/base/json_convert_content.dart';
import 'package:kljcafe_staff_new/domain/app_update_entity.dart';

AppUpdateEntity $AppUpdateEntityFromJson(Map<String, dynamic> json) {
  final AppUpdateEntity appUpdateEntity = AppUpdateEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    appUpdateEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    appUpdateEntity.message = message;
  }
  final List<AppUpdateData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<AppUpdateData>(e) as AppUpdateData)
      .toList();
  if (data != null) {
    appUpdateEntity.data = data;
  }
  return appUpdateEntity;
}

Map<String, dynamic> $AppUpdateEntityToJson(AppUpdateEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension AppUpdateEntityExtension on AppUpdateEntity {
  AppUpdateEntity copyWith({
    int? status,
    String? message,
    List<AppUpdateData>? data,
  }) {
    return AppUpdateEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AppUpdateData $AppUpdateDataFromJson(Map<String, dynamic> json) {
  final AppUpdateData appUpdateData = AppUpdateData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    appUpdateData.id = id;
  }
  final String? version = jsonConvert.convert<String>(json['version']);
  if (version != null) {
    appUpdateData.version = version;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    appUpdateData.url = url;
  }
  final String? mobileOs = jsonConvert.convert<String>(json['mobile_os']);
  if (mobileOs != null) {
    appUpdateData.mobileOs = mobileOs;
  }
  final String? mobileApp = jsonConvert.convert<String>(json['mobile_app']);
  if (mobileApp != null) {
    appUpdateData.mobileApp = mobileApp;
  }
  return appUpdateData;
}

Map<String, dynamic> $AppUpdateDataToJson(AppUpdateData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['version'] = entity.version;
  data['url'] = entity.url;
  data['mobile_os'] = entity.mobileOs;
  data['mobile_app'] = entity.mobileApp;
  return data;
}

extension AppUpdateDataExtension on AppUpdateData {
  AppUpdateData copyWith({
    String? id,
    String? version,
    String? url,
    String? mobileOs,
    String? mobileApp,
  }) {
    return AppUpdateData()
      ..id = id ?? this.id
      ..version = version ?? this.version
      ..url = url ?? this.url
      ..mobileOs = mobileOs ?? this.mobileOs
      ..mobileApp = mobileApp ?? this.mobileApp;
  }
}