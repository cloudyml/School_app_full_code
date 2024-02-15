import 'dart:convert';

TeacherSeeOwnAssignmentsListModel teacherSeeOwnAssignmentsListModelFromJson(
    String str) =>
    TeacherSeeOwnAssignmentsListModel.fromJson(json.decode(str));

String teacherSeeOwnAssignmentsListModelToJson(
    TeacherSeeOwnAssignmentsListModel data) =>
    json.encode(data.toJson());

class TeacherSeeOwnAssignmentsListModel {
  bool? status;
  String? message;
  List<Datum>? data;

  TeacherSeeOwnAssignmentsListModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherSeeOwnAssignmentsListModel.fromJson(
      Map<String, dynamic> json) =>
      TeacherSeeOwnAssignmentsListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  UploadedImage? uploadedImage;
  String? id;
  String? institutionId;
  String? schoolId;
  String? schoolName;
  String? teacherId;
  int? datumClass;
  String? section;
  String? subject;
  String? topic;
  DateTime? givenDate;
  DateTime? lastDateOfSubmit;
  List<SubmittedStudentId>? submittedStudentId;
  List<NotSubmittedStudentList>? notSubmittedStudentList;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.uploadedImage,
    this.id,
    this.institutionId,
    this.schoolId,
    this.schoolName,
    this.teacherId,
    this.datumClass,
    this.section,
    this.subject,
    this.topic,
    this.givenDate,
    this.lastDateOfSubmit,
    this.submittedStudentId,
    this.notSubmittedStudentList,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    uploadedImage: json["uploadedImage"] == null
        ? null
        : UploadedImage.fromJson(json["uploadedImage"]),
    id: json["_id"],
    institutionId: json["institutionId"],
    schoolId: json["schoolId"],
    schoolName: json["schoolName"],
    teacherId: json["teacherId"],
    datumClass: json["class"],
    section: json["section"],
    subject: json["subject"],
    topic: json["topic"],
    givenDate: json["givenDate"] == null
        ? null
        : DateTime.parse(json["givenDate"]),
    lastDateOfSubmit: json["lastDateOfSubmit"] == null
        ? null
        : DateTime.parse(json["lastDateOfSubmit"]),
    submittedStudentId: json["submittedStudentId"] == null
        ? []
        : List<SubmittedStudentId>.from(json["submittedStudentId"]!
        .map((x) => SubmittedStudentId.fromJson(x))),
    notSubmittedStudentList: json["notSubmittedStudentList"] == null
        ? []
        : List<NotSubmittedStudentList>.from(
        json["notSubmittedStudentList"]!
            .map((x) => NotSubmittedStudentList.fromJson(x))),
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
    "schoolId": schoolId,
    "schoolName": schoolName,
    "teacherId": teacherId,
    "class": datumClass,
    "section": section,
    "subject": subject,
    "topic": topic,
    "givenDate": givenDate?.toIso8601String(),
    "lastDateOfSubmit": lastDateOfSubmit?.toIso8601String(),
    "submittedStudentId": submittedStudentId == null
        ? []
        : List<dynamic>.from(submittedStudentId!.map((x) => x.toJson())),
    "notSubmittedStudentList": notSubmittedStudentList == null
        ? []
        : List<dynamic>.from(
        notSubmittedStudentList!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class NotSubmittedStudentList {
  String? id;
  String? institutionId;
  String? schoolName;
  String? schoolId;
  int? rollNumber;
  String? name;
  int? notSubmittedStudentListClass;
  String? section;
  String? batch;
  String? gender;
  String? email;
  String? password;
  String? phoneNumber;
  String? address;
  String? firstChar;
  String? parentEmailId;
  String? role;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  NotSubmittedStudentList({
    this.id,
    this.institutionId,
    this.schoolName,
    this.schoolId,
    this.rollNumber,
    this.name,
    this.notSubmittedStudentListClass,
    this.section,
    this.batch,
    this.gender,
    this.email,
    this.password,
    this.phoneNumber,
    this.address,
    this.firstChar,
    this.parentEmailId,
    this.role,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotSubmittedStudentList.fromJson(Map<String, dynamic> json) =>
      NotSubmittedStudentList(
        id: json["_id"],
        institutionId: json["institutionId"],
        schoolName: json["schoolName"],
        schoolId: json["schoolId"],
        rollNumber: json["rollNumber"],
        name: json["name"],
        notSubmittedStudentListClass: json["class"],
        section: json["section"],
        batch: json["batch"],
        gender: json["gender"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        firstChar: json["firstChar"],
        parentEmailId: json["parentEmailID"],
        role: json["role"],
        isDeleted: json["isDeleted"],
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
    "schoolName": schoolName,
    "schoolId": schoolId,
    "rollNumber": rollNumber,
    "name": name,
    "class": notSubmittedStudentListClass,
    "section": section,
    "batch": batch,
    "gender": gender,
    "email": email,
    "password": password,
    "phoneNumber": phoneNumber,
    "address": address,
    "firstChar": firstChar,
    "parentEmailID": parentEmailId,
    "role": role,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class SubmittedStudentId {
  String? assignmentId;
  String? studentId;
  String? studentName;
  int? submittedStudentIdClass;
  String? section;
  int? rollNumber;
  DateTime? submitDate;
  List<dynamic>? textAssignmentList;
  UploadedImage? uploadedImage;
  String? isDone;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SubmittedStudentId({
    this.assignmentId,
    this.studentId,
    this.studentName,
    this.submittedStudentIdClass,
    this.section,
    this.rollNumber,
    this.submitDate,
    this.textAssignmentList,
    this.uploadedImage,
    this.isDone,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SubmittedStudentId.fromJson(Map<String, dynamic> json) =>
      SubmittedStudentId(
        assignmentId: json["assignmentId"],
        studentId: json["studentId"],
        studentName: json["studentName"],
        submittedStudentIdClass: json["class"],
        section: json["section"],
        rollNumber: json["rollNumber"],
        submitDate: json["submitDate"] == null
            ? null
            : DateTime.parse(json["submitDate"]),
        textAssignmentList: json["textAssignmentList"] == null
            ? []
            : List<dynamic>.from(json["textAssignmentList"]!.map((x) => x)),
        uploadedImage: json["uploadedImage"] == null
            ? null
            : UploadedImage.fromJson(json["uploadedImage"]),
        isDone: json["isDone"],
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
    "assignmentId": assignmentId,
    "studentId": studentId,
    "studentName": studentName,
    "class": submittedStudentIdClass,
    "section": section,
    "rollNumber": rollNumber,
    "submitDate": submitDate?.toIso8601String(),
    "textAssignmentList": textAssignmentList == null
        ? []
        : List<dynamic>.from(textAssignmentList!.map((x) => x)),
    "uploadedImage": uploadedImage?.toJson(),
    "isDone": isDone,
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