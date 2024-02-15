import 'dart:convert';

TeacherAssignmentUploadModel teacherAssignmentUploadModelFromJson(String str) =>
    TeacherAssignmentUploadModel.fromJson(json.decode(str));

String teacherAssignmentUploadModelToJson(TeacherAssignmentUploadModel data) =>
    json.encode(data.toJson());

class TeacherAssignmentUploadModel {
  bool? status;
  String? message;
  Data? data;

  TeacherAssignmentUploadModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherAssignmentUploadModel.fromJson(Map<String, dynamic> json) =>
      TeacherAssignmentUploadModel(
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
  String? schoolName;
  String? teacherId;
  int? dataClass;
  String? section;
  String? subject;
  String? topic;
  DateTime? givenDate;
  DateTime? lastDateOfSubmit;
  UploadedImage? uploadedImage;
  List<dynamic>? textAssignmentList;
  List<dynamic>? submittedStudentId;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.institutionId,
    this.schoolId,
    this.schoolName,
    this.teacherId,
    this.dataClass,
    this.section,
    this.subject,
    this.topic,
    this.givenDate,
    this.lastDateOfSubmit,
    this.uploadedImage,
    this.textAssignmentList,
    this.submittedStudentId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        institutionId: json["institutionId"],
        schoolId: json["schoolId"],
        schoolName: json["schoolName"],
        teacherId: json["teacherId"],
        dataClass: json["class"],
        section: json["section"],
        subject: json["subject"],
        topic: json["topic"],
        givenDate: json["givenDate"] == null
            ? null
            : DateTime.parse(json["givenDate"]),
        lastDateOfSubmit: json["lastDateOfSubmit"] == null
            ? null
            : DateTime.parse(json["lastDateOfSubmit"]),
        uploadedImage: json["uploadedImage"] == null
            ? null
            : UploadedImage.fromJson(json["uploadedImage"]),
        textAssignmentList: json["textAssignmentList"] == null
            ? []
            : List<dynamic>.from(json["textAssignmentList"]!.map((x) => x)),
        submittedStudentId: json["submittedStudentId"] == null
            ? []
            : List<dynamic>.from(json["submittedStudentId"]!.map((x) => x)),
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
        "schoolName": schoolName,
        "teacherId": teacherId,
        "class": dataClass,
        "section": section,
        "subject": subject,
        "topic": topic,
        "givenDate": givenDate?.toIso8601String(),
        "lastDateOfSubmit": lastDateOfSubmit?.toIso8601String(),
        "uploadedImage": uploadedImage?.toJson(),
        "textAssignmentList": textAssignmentList == null
            ? []
            : List<dynamic>.from(textAssignmentList!.map((x) => x)),
        "submittedStudentId": submittedStudentId == null
            ? []
            : List<dynamic>.from(submittedStudentId!.map((x) => x)),
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

  UploadedImage({
    this.originalName,
    this.path,
    this.key,
    this.link,
    this.count,
    this.previosName,
  });

  factory UploadedImage.fromJson(Map<String, dynamic> json) => UploadedImage(
        originalName: json["originalName"],
        path: json["path"],
        key: json["key"],
        link: json["link"],
        count: json["count"],
        previosName: json["previosName"],
      );

  Map<String, dynamic> toJson() => {
        "originalName": originalName,
        "path": path,
        "key": key,
        "link": link,
        "count": count,
        "previosName": previosName,
      };
}
