import 'dart:convert';

TeacherViewAttendanceOfClassResponseModel
    teacherViewAttendanceOfClassResponseModelFromJson(String str) =>
        TeacherViewAttendanceOfClassResponseModel.fromJson(json.decode(str));

String teacherViewAttendanceOfClassResponseModelToJson(
        TeacherViewAttendanceOfClassResponseModel data) =>
    json.encode(data.toJson());

class TeacherViewAttendanceOfClassResponseModel {
  bool? status;
  String? message;
  TeacherViewAttendanceOfClassResponseModelData? data;

  TeacherViewAttendanceOfClassResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherViewAttendanceOfClassResponseModel.fromJson(
          Map<String, dynamic> json) =>
      TeacherViewAttendanceOfClassResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : TeacherViewAttendanceOfClassResponseModelData.fromJson(
                json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class TeacherViewAttendanceOfClassResponseModelData {
  DataData? data;
  int? numberOfPresentStudents;
  int? numberOfAbsentStudents;
  int? numberOfLeaveStudents;

  TeacherViewAttendanceOfClassResponseModelData({
    this.data,
    this.numberOfPresentStudents,
    this.numberOfAbsentStudents,
    this.numberOfLeaveStudents,
  });

  factory TeacherViewAttendanceOfClassResponseModelData.fromJson(
          Map<String, dynamic> json) =>
      TeacherViewAttendanceOfClassResponseModelData(
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
        numberOfPresentStudents: json["numberOfPresentStudents"],
        numberOfAbsentStudents: json["numberOfAbsentStudents"],
        numberOfLeaveStudents: json["numberOfLeaveStudents"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "numberOfPresentStudents": numberOfPresentStudents,
        "numberOfAbsentStudents": numberOfAbsentStudents,
        "numberOfLeaveStudents": numberOfLeaveStudents,
      };
}

class DataData {
  String? id;
  DateTime? date;
  int? dataClass;
  String? section;
  String? day;
  int? month;
  int? year;
  int? tarikh;
  List<Datum>? data;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  DataData({
    this.id,
    this.date,
    this.dataClass,
    this.section,
    this.day,
    this.month,
    this.year,
    this.tarikh,
    this.data,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        id: json["_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        dataClass: json["class"],
        section: json["section"],
        day: json["day"],
        month: json["month"],
        year: json["year"],
        tarikh: json["tarikh"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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
        "date": date?.toIso8601String(),
        "class": dataClass,
        "section": section,
        "day": day,
        "month": month,
        "year": year,
        "tarikh": tarikh,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Datum {
  String? name;
  int? rollNumber;
  String? attendance;
  String? id;

  Datum({
    this.name,
    this.rollNumber,
    this.attendance,
    this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        rollNumber: json["rollNumber"],
        attendance: json["attendance"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rollNumber": rollNumber,
        "attendance": attendance,
        "_id": id,
      };
}
