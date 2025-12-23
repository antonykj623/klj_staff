import 'package:kljcafe_staff_new/generated/json/base/json_convert_content.dart';
import 'package:kljcafe_staff_new/domain/qr_entity.dart';

QrEntity $QrEntityFromJson(Map<String, dynamic> json) {
  final QrEntity qrEntity = QrEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    qrEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    qrEntity.message = message;
  }
  final String? data = jsonConvert.convert<String>(json['data']);
  if (data != null) {
    qrEntity.data = data;
  }
  return qrEntity;
}

Map<String, dynamic> $QrEntityToJson(QrEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data;
  return data;
}

extension QrEntityExtension on QrEntity {
  QrEntity copyWith({
    int? status,
    String? message,
    String? data,
  }) {
    return QrEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}