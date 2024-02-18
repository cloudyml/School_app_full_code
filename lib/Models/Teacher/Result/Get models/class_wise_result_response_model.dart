import 'dart:convert';

ClassWiseResultResponseModel classWiseResultResponseModelFromJson(String str) =>
    ClassWiseResultResponseModel.fromJson(json.decode(str));

String classWiseResultResponseModelToJson(ClassWiseResultResponseModel data) =>
    json.encode(data.toJson());

class ClassWiseResultResponseModel {
  bool? status;
  String? message;
  List<Datum>? data;

  ClassWiseResultResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory ClassWiseResultResponseModel.fromJson(Map<String, dynamic> json) =>
      ClassWiseResultResponseModel(
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
  int? datumClass;
  String? section;
  String? subject;
  List<StudentList>? studentList;

  Datum({
    this.id,
    this.datumClass,
    this.section,
    this.subject,
    this.studentList,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        datumClass: json["class"],
        section: json["section"],
        subject: json["subject"],
        studentList: json["studentList"] == null
            ? []
            : List<StudentList>.from(
                json["studentList"]!.map((x) => StudentList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "class": datumClass,
        "section": section,
        "subject": subject,
        "studentList": studentList == null
            ? []
            : List<dynamic>.from(studentList!.map((x) => x.toJson())),
      };
}

class StudentList {
  String? id;
  String? rollNumber;
  String? name;
  String? subject;
  dynamic marks;
  String? outOffMarks;
  String? passingMarks;
  String? grades;
  String? comments;

  StudentList({
    this.id,
    this.rollNumber,
    this.name,
    this.subject,
    this.marks,
    this.outOffMarks,
    this.passingMarks,
    this.grades,
    this.comments,
  });

  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
        id: json["_id"],
        rollNumber: json["rollNumber"],
        name: json["name"],
        subject: json["subject"],
        marks: json["marks"],
        outOffMarks: json["outOffMarks"],
        passingMarks: json["passingMarks"],
        grades: json["grades"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "rollNumber": rollNumber,
        "name": name,
        "subject": subject,
        "marks": marks,
        "outOffMarks": outOffMarks,
        "passingMarks": passingMarks,
        "grades": grades,
        "comments": comments,
      };
}
