import 'dart:convert';

TeacherUploadedTextAssignmentResponseModel
    teacherUploadedTextAssignmentResponseModelFromJson(String str) =>
        TeacherUploadedTextAssignmentResponseModel.fromJson(json.decode(str));

String teacherUploadedTextAssignmentResponseModelToJson(
        TeacherUploadedTextAssignmentResponseModel data) =>
    json.encode(data.toJson());

class TeacherUploadedTextAssignmentResponseModel {
  bool? status;
  String? message;
  List<Datum>? data;

  TeacherUploadedTextAssignmentResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherUploadedTextAssignmentResponseModel.fromJson(
          Map<String, dynamic> json) =>
      TeacherUploadedTextAssignmentResponseModel(
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
  List<DatumTextAssignmentList>? textAssignmentList;
  List<SubmittedStudentList>? submittedStudentId;
  List<NotSubmittedStudentList>? notSubmittedStudentList;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
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
    this.textAssignmentList,
    this.submittedStudentId,
    this.notSubmittedStudentList,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        textAssignmentList: json["textAssignmentList"] == null
            ? []
            : List<DatumTextAssignmentList>.from(json["textAssignmentList"]!
                .map((x) => DatumTextAssignmentList.fromJson(x))),
        submittedStudentId: json["submittedStudentId"] == null
            ? []
            : List<SubmittedStudentList>.from(json["submittedStudentId"]!
                .map((x) => SubmittedStudentList.fromJson(x))),
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
        "textAssignmentList": textAssignmentList == null
            ? []
            : List<dynamic>.from(textAssignmentList!.map((x) => x.toJson())),
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

class SubmittedStudentList {
  String? assignmentId;
  String? studentId;
  String? studentName;
  int? submittedStudentIdClass;
  String? section;
  int? rollNumber;
  DateTime? submitDate;
  List<SubmittedStudentIdTextAssignmentList>? textAssignmentList;
  String? isDone;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SubmittedStudentList({
    this.assignmentId,
    this.studentId,
    this.studentName,
    this.submittedStudentIdClass,
    this.section,
    this.rollNumber,
    this.submitDate,
    this.textAssignmentList,
    this.isDone,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SubmittedStudentList.fromJson(Map<String, dynamic> json) =>
      SubmittedStudentList(
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
            : List<SubmittedStudentIdTextAssignmentList>.from(
                json["textAssignmentList"]!.map(
                    (x) => SubmittedStudentIdTextAssignmentList.fromJson(x))),
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
            : List<dynamic>.from(textAssignmentList!.map((x) => x.toJson())),
        "isDone": isDone,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class SubmittedStudentIdTextAssignmentList {
  String? question;
  String? answer;

  SubmittedStudentIdTextAssignmentList({
    this.question,
    this.answer,
  });

  factory SubmittedStudentIdTextAssignmentList.fromJson(
          Map<String, dynamic> json) =>
      SubmittedStudentIdTextAssignmentList(
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}

class DatumTextAssignmentList {
  String? question;

  DatumTextAssignmentList({
    this.question,
  });

  factory DatumTextAssignmentList.fromJson(Map<String, dynamic> json) =>
      DatumTextAssignmentList(
        question: json["question"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
      };
}
