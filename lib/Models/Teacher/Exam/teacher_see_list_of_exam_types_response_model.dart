import 'dart:convert';

TeacherSeeExamTypesResponseModel teacherSeeExamTypesResponseModelFromJson(String str) => TeacherSeeExamTypesResponseModel.fromJson(json.decode(str));

String teacherSeeExamTypesResponseModelToJson(TeacherSeeExamTypesResponseModel data) => json.encode(data.toJson());

class TeacherSeeExamTypesResponseModel {
    bool? status;
    String? message;
    Data? data;

    TeacherSeeExamTypesResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory TeacherSeeExamTypesResponseModel.fromJson(Map<String, dynamic> json) => TeacherSeeExamTypesResponseModel(
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
    String? teacherId;
    List<String>? examTypeList;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Data({
        this.id,
        this.institutionId,
        this.schoolId,
        this.schoolName,
        this.teacherId,
        this.examTypeList,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        institutionId: json["institutionId"],
        schoolId: json["schoolId"],
        schoolName: json["schoolName"],
        teacherId: json["teacherId"],
        examTypeList: json["examTypeList"] == null ? [] : List<String>.from(json["examTypeList"]!.map((x) => x)),
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
        "examTypeList": examTypeList == null ? [] : List<dynamic>.from(examTypeList!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
