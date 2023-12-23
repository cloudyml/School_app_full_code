// To parse this JSON data, do
//
//     final teacherUploadEventsModel = teacherUploadEventsModelFromJson(jsonString);

import 'dart:convert';

TeacherUploadEventsModel teacherUploadEventsModelFromJson(String str) =>
    TeacherUploadEventsModel.fromJson(json.decode(str));

String teacherUploadEventsModelToJson(TeacherUploadEventsModel data) =>
    json.encode(data.toJson());

class TeacherUploadEventsModel {
  bool? status;
  String? message;
  Link? link;

  TeacherUploadEventsModel({
    this.status,
    this.message,
    this.link,
  });

  factory TeacherUploadEventsModel.fromJson(Map<String, dynamic> json) =>
      TeacherUploadEventsModel(
        status: json["status"],
        message: json["message"],
        link: json["link"] == null ? null : Link.fromJson(json["link"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "link": link?.toJson(),
      };
}

class Link {
  String? eventName;
  List<UploadedImage>? uploadedImage;
  String? description;
  DateTime? date;
  String? year;
  String? month;
  String? eventTime;
  String? status;
  String? eligibleClass;
  String? remark;
  String? schoolName;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Link({
    this.eventName,
    this.uploadedImage,
    this.description,
    this.date,
    this.year,
    this.month,
    this.eventTime,
    this.status,
    this.eligibleClass,
    this.remark,
    this.schoolName,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        eventName: json["eventName"],
        uploadedImage: json["uploadedImage"] == null
            ? []
            : List<UploadedImage>.from(
                json["uploadedImage"]!.map((x) => UploadedImage.fromJson(x))),
        description: json["description"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        year: json["year"],
        month: json["month"],
        eventTime: json["eventTime"],
        status: json["status"],
        eligibleClass: json["eligibleClass"],
        remark: json["remark"],
        schoolName: json["schoolName"],
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
        "eventName": eventName,
        "uploadedImage": uploadedImage == null
            ? []
            : List<dynamic>.from(uploadedImage!.map((x) => x.toJson())),
        "description": description,
        "date": date?.toIso8601String(),
        "year": year,
        "month": month,
        "eventTime": eventTime,
        "status": status,
        "eligibleClass": eligibleClass,
        "remark": remark,
        "schoolName": schoolName,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class UploadedImage {
  String? originalName;
  String? path;
  String? key;
  String? link;
  int? count;
  String? previosName;
  String? id;

  UploadedImage({
    this.originalName,
    this.path,
    this.key,
    this.link,
    this.count,
    this.previosName,
    this.id,
  });

  factory UploadedImage.fromJson(Map<String, dynamic> json) => UploadedImage(
        originalName: json["originalName"],
        path: json["path"],
        key: json["key"],
        link: json["link"],
        count: json["count"],
        previosName: json["previosName"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "originalName": originalName,
        "path": path,
        "key": key,
        "link": link,
        "count": count,
        "previosName": previosName,
        "_id": id,
      };
}



// To parse this JSON data, do

    // final teacherUploadEventsModel = teacherUploadEventsModelFromJson(jsonString);

// import 'dart:convert';

// TeacherUploadEventsModel teacherUploadEventsModelFromJson(String str) => TeacherUploadEventsModel.fromJson(json.decode(str));

// String teacherUploadEventsModelToJson(TeacherUploadEventsModel data) => json.encode(data.toJson());

// class TeacherUploadEventsModel {
//     bool status;
//     String message;
//     Link link;

//     TeacherUploadEventsModel({
//         required this.status,
//         required this.message,
//         required this.link,
//     });

//     factory TeacherUploadEventsModel.fromJson(Map<String, dynamic> json) => TeacherUploadEventsModel(
//         status: json["status"],
//         message: json["message"],
//         link: Link.fromJson(json["link"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "link": link.toJson(),
//     };
// }

// class Link {
//     String schoolName;
//     String eventName;
//     List<UploadedImage> uploadedImage;
//     String description;
//     String eventTime;
//     DateTime date;
//     String year;
//     String month;
//     String eligibleClass;
//     String status;
//     String remark;
//     String id;
//     List<dynamic> studentList;
//     DateTime createdAt;
//     DateTime updatedAt;
//     int v;

//     Link({
//         required this.schoolName,
//         required this.eventName,
//         required this.uploadedImage,
//         required this.description,
//         required this.eventTime,
//         required this.date,
//         required this.year,
//         required this.month,
//         required this.eligibleClass,
//         required this.status,
//         required this.remark,
//         required this.id,
//         required this.studentList,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//     });

//     factory Link.fromJson(Map<String, dynamic> json) => Link(
//         schoolName: json["schoolName"],
//         eventName: json["eventName"],
//         uploadedImage: List<UploadedImage>.from(json["uploadedImage"].map((x) => UploadedImage.fromJson(x))),
//         description: json["description"],
//         eventTime: json["eventTime"],
//         date: DateTime.parse(json["date"]),
//         year: json["year"],
//         month: json["month"],
//         eligibleClass: json["eligibleClass"],
//         status: json["status"],
//         remark: json["remark"],
//         id: json["_id"],
//         studentList: List<dynamic>.from(json["studentList"].map((x) => x)),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "schoolName": schoolName,
//         "eventName": eventName,
//         "uploadedImage": List<dynamic>.from(uploadedImage.map((x) => x.toJson())),
//         "description": description,
//         "eventTime": eventTime,
//         "date": date.toIso8601String(),
//         "year": year,
//         "month": month,
//         "eligibleClass": eligibleClass,
//         "status": status,
//         "remark": remark,
//         "_id": id,
//         "studentList": List<dynamic>.from(studentList.map((x) => x)),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//     };
// }

// class UploadedImage {
//     String originalName;
//     String path;
//     String key;
//     String link;
//     int count;
//     String previosName;
//     String id;

//     UploadedImage({
//         required this.originalName,
//         required this.path,
//         required this.key,
//         required this.link,
//         required this.count,
//         required this.previosName,
//         required this.id,
//     });

//     factory UploadedImage.fromJson(Map<String, dynamic> json) => UploadedImage(
//         originalName: json["originalName"],
//         path: json["path"],
//         key: json["key"],
//         link: json["link"],
//         count: json["count"],
//         previosName: json["previosName"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "originalName": originalName,
//         "path": path,
//         "key": key,
//         "link": link,
//         "count": count,
//         "previosName": previosName,
//         "_id": id,
//     };
// }
