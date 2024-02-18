import 'dart:convert';

StudentViewAwardsResponseModel studentViewAwardsResponseModelFromJson(String str) => StudentViewAwardsResponseModel.fromJson(json.decode(str));

String studentViewAwardsResponseModelToJson(StudentViewAwardsResponseModel data) => json.encode(data.toJson());

class StudentViewAwardsResponseModel {
    bool? status;
    String? message;
    Data? data;

    StudentViewAwardsResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory StudentViewAwardsResponseModel.fromJson(Map<String, dynamic> json) => StudentViewAwardsResponseModel(
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
    String? schoolName;
    String? schoolId;
    String? studentId;
    String? studentName;
    int? dataClass;
    String? section;
    int? rollNumber;
    List<AwardList>? awardList;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Data({
        this.id,
        this.institutionId,
        this.schoolName,
        this.schoolId,
        this.studentId,
        this.studentName,
        this.dataClass,
        this.section,
        this.rollNumber,
        this.awardList,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        institutionId: json["institutionId"],
        schoolName: json["schoolName"],
        schoolId: json["schoolId"],
        studentId: json["studentId"],
        studentName: json["studentName"],
        dataClass: json["class"],
        section: json["section"],
        rollNumber: json["rollNumber"],
        awardList: json["awardList"] == null ? [] : List<AwardList>.from(json["awardList"]!.map((x) => AwardList.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "institutionId": institutionId,
        "schoolName": schoolName,
        "schoolId": schoolId,
        "studentId": studentId,
        "studentName": studentName,
        "class": dataClass,
        "section": section,
        "rollNumber": rollNumber,
        "awardList": awardList == null ? [] : List<dynamic>.from(awardList!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class AwardList {
    String? teacherId;
    String? certificationHeading;
    DateTime? certificationDate;
    String? link;
    String? originalName;
    String? path;
    String? id;

    AwardList({
        this.teacherId,
        this.certificationHeading,
        this.certificationDate,
        this.link,
        this.originalName,
        this.path,
        this.id,
    });

    factory AwardList.fromJson(Map<String, dynamic> json) => AwardList(
        teacherId: json["teacherId"],
        certificationHeading: json["certificationHeading"],
        certificationDate: json["certificationDate"] == null ? null : DateTime.parse(json["certificationDate"]),
        link: json["link"],
        originalName: json["originalName"],
        path: json["path"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "teacherId": teacherId,
        "certificationHeading": certificationHeading,
        "certificationDate": certificationDate?.toIso8601String(),
        "link": link,
        "originalName": originalName,
        "path": path,
        "_id": id,
    };
}
