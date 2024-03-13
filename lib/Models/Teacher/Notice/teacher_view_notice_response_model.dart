// import 'dart:convert';

// TeacherNoticeResponseModel teacherNoticeResponseModelFromJson(String str) =>
//     TeacherNoticeResponseModel.fromJson(json.decode(str));

// String teacherNoticeResponseModelToJson(TeacherNoticeResponseModel data) =>
//     json.encode(data.toJson());

// class TeacherNoticeResponseModel {
//   bool? status;
//   String? message;
//   Data? data;

//   TeacherNoticeResponseModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   factory TeacherNoticeResponseModel.fromJson(Map<String, dynamic> json) =>
//       TeacherNoticeResponseModel(
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   String? id;
//   String? studentId;
//   String? schoolName;
//   List<NoticeList>? noticeList;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;

//   Data({
//     this.id,
//     this.studentId,
//     this.schoolName,
//     this.noticeList,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["_id"],
//         studentId: json["studentId"],
//         schoolName: json["schoolName"],
//         noticeList: json["noticeList"] == null
//             ? []
//             : List<NoticeList>.from(
//                 json["noticeList"]!.map((x) => NoticeList.fromJson(x))),
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "studentId": studentId,
//         "schoolName": schoolName,
//         "noticeList": noticeList == null
//             ? []
//             : List<dynamic>.from(noticeList!.map((x) => x.toJson())),
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class NoticeList {
//   String? id;
//   String? heading;
//   String? description;
//   String? schoolName;
//   DateTime? date;
//   bool? read;
//   String? link;
//   String? originalImage;
//   String? path;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;

//   NoticeList({
//     this.id,
//     this.heading,
//     this.description,
//     this.schoolName,
//     this.date,
//     this.read,
//     this.link,
//     this.originalImage,
//     this.path,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory NoticeList.fromJson(Map<String, dynamic> json) => NoticeList(
//         id: json["_id"],
//         heading: json["heading"],
//         description: json["description"],
//         schoolName: json["schoolName"],
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         read: json["read"],
//         link: json["link"],
//         originalImage: json["originalImage"],
//         path: json["path"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "heading": heading,
//         "description": description,
//         "schoolName": schoolName,
//         "date": date?.toIso8601String(),
//         "read": read,
//         "link": link,
//         "originalImage": originalImage,
//         "path": path,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

//....

// To parse this JSON data, do
//
//     final teacherNoticeResponseModel = teacherNoticeResponseModelFromJson(jsonString);

import 'dart:convert';

TeacherNoticeResponseModel teacherNoticeResponseModelFromJson(String str) =>
    TeacherNoticeResponseModel.fromJson(json.decode(str));

String teacherNoticeResponseModelToJson(TeacherNoticeResponseModel data) =>
    json.encode(data.toJson());

class TeacherNoticeResponseModel {
  bool? status;
  String? message;
  Data? data;

  TeacherNoticeResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherNoticeResponseModel.fromJson(Map<String, dynamic> json) =>
      TeacherNoticeResponseModel(
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
  String? id;
  String? institutionId;
  String? schoolId;
  String? teacherId;
  List<NoticeList>? noticeList;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.institutionId,
    this.schoolId,
    this.teacherId,
    this.noticeList,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        institutionId: json["institutionId"],
        schoolId: json["schoolId"],
        teacherId: json["teacherId"],
        noticeList: json["noticeList"] == null
            ? []
            : List<NoticeList>.from(
                json["noticeList"]!.map((x) => NoticeList.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "institutionId": institutionId,
        "schoolId": schoolId,
        "teacherId": teacherId,
        "noticeList": noticeList == null
            ? []
            : List<dynamic>.from(noticeList!.map((x) => x.toJson())),
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
