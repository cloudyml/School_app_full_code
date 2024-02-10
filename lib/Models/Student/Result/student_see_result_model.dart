// To parse this JSON data, do
//
//     final studentResultResponseModel = studentResultResponseModelFromJson(jsonString);

import 'dart:convert';

StudentResultResponseModel studentResultResponseModelFromJson(String str) => StudentResultResponseModel.fromJson(json.decode(str));

String studentResultResponseModelToJson(StudentResultResponseModel data) => json.encode(data.toJson());

class StudentResultResponseModel {
    bool? status;
    String? message;
    StudentResultResponseModelData? data;

    StudentResultResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory StudentResultResponseModel.fromJson(Map<String, dynamic> json) => StudentResultResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : StudentResultResponseModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class StudentResultResponseModelData {
    Result? result;
    DataData? data;

    StudentResultResponseModelData({
        this.result,
        this.data,
    });

    factory StudentResultResponseModelData.fromJson(Map<String, dynamic> json) => StudentResultResponseModelData(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "data": data?.toJson(),
    };
}

class DataData {
    String? id;
    String? institutionId;
    String? schoolId;
    String? schoolName;
    int? dataClass;
    String? examType;
    String? month;
    String? year;
    String? studentId;
    String? studentName;
    int? rollNumber;
    List<Subject>? subjects;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    DataData({
        this.id,
        this.institutionId,
        this.schoolId,
        this.schoolName,
        this.dataClass,
        this.examType,
        this.month,
        this.year,
        this.studentId,
        this.studentName,
        this.rollNumber,
        this.subjects,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        id: json["_id"],
        institutionId: json["institutionId"],
        schoolId: json["schoolId"],
        schoolName: json["schoolName"],
        dataClass: json["class"],
        examType: json["examType"],
        month: json["month"],
        year: json["year"],
        studentId: json["studentId"],
        studentName: json["studentName"],
        rollNumber: json["rollNumber"],
        subjects: json["subjects"] == null ? [] : List<Subject>.from(json["subjects"]!.map((x) => Subject.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "institutionId": institutionId,
        "schoolId": schoolId,
        "schoolName": schoolName,
        "class": dataClass,
        "examType": examType,
        "month": month,
        "year": year,
        "studentId": studentId,
        "studentName": studentName,
        "rollNumber": rollNumber,
        "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Subject {
    String? subject;
    int? marks;
    int? outOffMarks;
    int? passingMarks;
    String? grades;
    String? comment;
    String? id;

    Subject({
        this.subject,
        this.marks,
        this.outOffMarks,
        this.passingMarks,
        this.grades,
        this.comment,
        this.id,
    });

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        subject: json["subject"],
        marks: json["marks"],
        outOffMarks: json["outOffMarks"],
        passingMarks: json["passingMarks"],
        grades: json["grades"],
        comment: json["comment"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "subject": subject,
        "marks": marks,
        "outOffMarks": outOffMarks,
        "passingMarks": passingMarks,
        "grades": grades,
        "comment": comment,
        "_id": id,
    };
}

class Result {
    int? passingMarks;
    int? totalMarks;
    int? totalOutOffMarks;
    String? result;
    String? percentage;
    String? overAllGrades;
    String? overAllComments;

    Result({
        this.passingMarks,
        this.totalMarks,
        this.totalOutOffMarks,
        this.result,
        this.percentage,
        this.overAllGrades,
        this.overAllComments,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        passingMarks: json["passingMarks"],
        totalMarks: json["totalMarks"],
        totalOutOffMarks: json["totalOutOffMarks"],
        result: json["result"],
        percentage: json["percentage"],
        overAllGrades: json["overAllGrades"],
        overAllComments: json["overAllComments"],
    );

    Map<String, dynamic> toJson() => {
        "passingMarks": passingMarks,
        "totalMarks": totalMarks,
        "totalOutOffMarks": totalOutOffMarks,
        "result": result,
        "percentage": percentage,
        "overAllGrades": overAllGrades,
        "overAllComments": overAllComments,
    };
}
