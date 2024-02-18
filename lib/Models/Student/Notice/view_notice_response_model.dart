import 'dart:convert';

ViewNoticeResponseModel viewNoticeResponseModelFromJson(String str) =>
    ViewNoticeResponseModel.fromJson(json.decode(str));

String viewNoticeResponseModelToJson(ViewNoticeResponseModel data) =>
    json.encode(data.toJson());

class ViewNoticeResponseModel {
  bool? status;
  String? message;
  Data? data;

  ViewNoticeResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory ViewNoticeResponseModel.fromJson(Map<String, dynamic> json) =>
      ViewNoticeResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? institutionId;
  String? schoolId;
  String? studentId;
  List<NoticeList>? noticeList;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.institutionId,
    this.schoolId,
    this.studentId,
    this.noticeList,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        institutionId: json["institutionId"],
        schoolId: json["schoolId"],
        studentId: json["studentId"],
        noticeList: json["noticeList"] == null
            ? []
            : List<NoticeList>.from(
                json["noticeList"]!.map((x) => NoticeList.fromJson(x))),
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "institutionId": institutionId,
        "schoolId": schoolId,
        "studentId": studentId,
        "noticeList": noticeList == null
            ? []
            : List<dynamic>.from(noticeList!.map((x) => x.toJson())),
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class NoticeList {
  UploadedImage? uploadedImage;
  String? id;
  String? institutionId;
  String? schoolName;
  String? schoolId;
  String? teacherId;
  String? heading;
  String? description;
  DateTime? date;
  bool? read;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  NoticeList({
    this.uploadedImage,
    this.id,
    this.institutionId,
    this.schoolName,
    this.schoolId,
    this.teacherId,
    this.heading,
    this.description,
    this.date,
    this.read,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NoticeList.fromJson(Map<String, dynamic> json) => NoticeList(
        uploadedImage: json["uploadedImage"] == null
            ? null
            : UploadedImage.fromJson(json["uploadedImage"]),
        id: json["_id"],
        institutionId: json["institutionId"],
        schoolName: json["schoolName"],
        schoolId: json["schoolId"],
        teacherId: json["teacherId"],
        heading: json["heading"],
        description: json["description"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        read: json["read"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "uploadedImage": uploadedImage?.toJson(),
        "_id": id,
        "institutionId": institutionId,
        "schoolName": schoolName,
        "schoolId": schoolId,
        "teacherId": teacherId,
        "heading": heading,
        "description": description,
        "date": date?.toIso8601String(),
        "read": read,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class UploadedImage {
  String? link;
  String? originalName;
  String? path;

  UploadedImage({
    this.link,
    this.originalName,
    this.path,
  });

  factory UploadedImage.fromJson(Map<String, dynamic> json) => UploadedImage(
        link: json["link"],
        originalName: json["originalName"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "originalName": originalName,
        "path": path,
      };
}
