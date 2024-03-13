import 'dart:convert';

TeacherPaymentStatusResponseModel teacherPaymentStatusResponseModelFromJson(
        String str) =>
    TeacherPaymentStatusResponseModel.fromJson(json.decode(str));

String teacherPaymentStatusResponseModelToJson(
        TeacherPaymentStatusResponseModel data) =>
    json.encode(data.toJson());

class TeacherPaymentStatusResponseModel {
  bool? status;
  String? message;
  Data? data;

  TeacherPaymentStatusResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherPaymentStatusResponseModel.fromJson(
          Map<String, dynamic> json) =>
      TeacherPaymentStatusResponseModel(
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
  String? schoolName;
  String? dataClass;
  String? section;
  int? month;
  int? year;
  int? amount;
  List<StudentList>? studentList;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.institutionId,
    this.schoolId,
    this.schoolName,
    this.dataClass,
    this.section,
    this.month,
    this.year,
    this.amount,
    this.studentList,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        institutionId: json["institutionId"],
        schoolId: json["schoolId"],
        schoolName: json["schoolName"],
        dataClass: json["class"],
        section: json["section"],
        month: json["month"],
        year: json["year"],
        amount: json["amount"],
        studentList: json["studentList"] == null
            ? []
            : List<StudentList>.from(
                json["studentList"]!.map((x) => StudentList.fromJson(x))),
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
        "class": dataClass,
        "section": section,
        "month": month,
        "year": year,
        "amount": amount,
        "studentList": studentList == null
            ? []
            : List<dynamic>.from(studentList!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class StudentList {
  String? parentEmailId;
  String? id;
  String? name;
  int? rollNumber;
  String? category;
  DateTime? paymentDate;

  StudentList({
    this.parentEmailId,
    this.id,
    this.name,
    this.rollNumber,
    this.category,
    this.paymentDate,
  });

  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
        parentEmailId: json["parentEmailID"],
        id: json["_id"],
        name: json["name"],
        rollNumber: json["rollNumber"],
        category: json["category"],
        paymentDate: json["paymentDate"] == null
            ? null
            : DateTime.parse(json["paymentDate"]),
      );

  Map<String, dynamic> toJson() => {
        "parentEmailID": parentEmailId,
        "_id": id,
        "name": name,
        "rollNumber": rollNumber,
        "category": category,
        "paymentDate":
            "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
      };
}
