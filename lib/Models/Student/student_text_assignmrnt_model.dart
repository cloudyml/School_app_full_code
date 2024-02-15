// To parse this JSON data, do
//
//     final textAssignmentStudentModel = textAssignmentStudentModelFromJson(jsonString);

import 'dart:convert';

TextAssignmentStudentModel textAssignmentStudentModelFromJson(String str) => TextAssignmentStudentModel.fromJson(json.decode(str));

String textAssignmentStudentModelToJson(TextAssignmentStudentModel data) => json.encode(data.toJson());

class TextAssignmentStudentModel {
    bool? status;
    String? message;
    List<Datum>? data;

    TextAssignmentStudentModel({
        this.status,
        this.message,
        this.data,
    });

    factory TextAssignmentStudentModel.fromJson(Map<String, dynamic> json) => TextAssignmentStudentModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
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
    List<dynamic>? textAssignmentList;
    List<dynamic>? submittedStudentId;
    List<dynamic>? notSubmittedStudentList;
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
        givenDate: json["givenDate"] == null ? null : DateTime.parse(json["givenDate"]),
        lastDateOfSubmit: json["lastDateOfSubmit"] == null ? null : DateTime.parse(json["lastDateOfSubmit"]),
        textAssignmentList: json["textAssignmentList"] == null ? [] : List<dynamic>.from(json["textAssignmentList"]!.map((x) => x)),
        submittedStudentId: json["submittedStudentId"] == null ? [] : List<dynamic>.from(json["submittedStudentId"]!.map((x) => x)),
        notSubmittedStudentList: json["notSubmittedStudentList"] == null ? [] : List<dynamic>.from(json["notSubmittedStudentList"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
        "textAssignmentList": textAssignmentList == null ? [] : List<dynamic>.from(textAssignmentList!.map((x) => x)),
        "submittedStudentId": submittedStudentId == null ? [] : List<dynamic>.from(submittedStudentId!.map((x) => x)),
        "notSubmittedStudentList": notSubmittedStudentList == null ? [] : List<dynamic>.from(notSubmittedStudentList!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
