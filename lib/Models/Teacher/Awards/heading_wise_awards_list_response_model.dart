import 'dart:convert';

HeadingWiseAwardsListOfStudentsResponseModel headingWiseAwardsListOfStudentsResponseModelFromJson(String str) => HeadingWiseAwardsListOfStudentsResponseModel.fromJson(json.decode(str));

String headingWiseAwardsListOfStudentsResponseModelToJson(HeadingWiseAwardsListOfStudentsResponseModel data) => json.encode(data.toJson());

class HeadingWiseAwardsListOfStudentsResponseModel {
    bool? status;
    String? message;
    List<Datum>? data;

    HeadingWiseAwardsListOfStudentsResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory HeadingWiseAwardsListOfStudentsResponseModel.fromJson(Map<String, dynamic> json) => HeadingWiseAwardsListOfStudentsResponseModel(
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
    String? schoolName;
    String? schoolId;
    String? teacherId;
    String? certificationHeading;
    DateTime? certificationDate;
    List<StudentList>? studentList;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Datum({
        this.id,
        this.institutionId,
        this.schoolName,
        this.schoolId,
        this.teacherId,
        this.certificationHeading,
        this.certificationDate,
        this.studentList,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        institutionId: json["institutionId"],
        schoolName: json["schoolName"],
        schoolId: json["schoolId"],
        teacherId: json["teacherId"],
        certificationHeading: json["certificationHeading"],
        certificationDate: json["certificationDate"] == null ? null : DateTime.parse(json["certificationDate"]),
        studentList: json["studentList"] == null ? [] : List<StudentList>.from(json["studentList"]!.map((x) => StudentList.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "institutionId": institutionId,
        "schoolName": schoolName,
        "schoolId": schoolId,
        "teacherId": teacherId,
        "certificationHeading": certificationHeading,
        "certificationDate": certificationDate?.toIso8601String(),
        "studentList": studentList == null ? [] : List<dynamic>.from(studentList!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class StudentList {
    UploadedImage? uploadedImage;
    String? studentName;
    String? studentId;
    int? studentListClass;
    String? section;
    int? rollNumber;
    String? id;

    StudentList({
        this.uploadedImage,
        this.studentName,
        this.studentId,
        this.studentListClass,
        this.section,
        this.rollNumber,
        this.id,
    });

    factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
        uploadedImage: json["uploadedImage"] == null ? null : UploadedImage.fromJson(json["uploadedImage"]),
        studentName: json["studentName"],
        studentId: json["studentId"],
        studentListClass: json["class"],
        section: json["section"],
        rollNumber: json["rollNumber"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "uploadedImage": uploadedImage?.toJson(),
        "studentName": studentName,
        "studentId": studentId,
        "class": studentListClass,
        "section": section,
        "rollNumber": rollNumber,
        "_id": id,
    };
}

class UploadedImage {
    String? link;
    String? originalName;
    String? path;

    UploadedImage({
        this.link,
        this.originalName,
        this.path,
    });

    factory UploadedImage.fromJson(Map<String, dynamic> json) => UploadedImage(
        link: json["link"],
        originalName: json["originalName"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "link": link,
        "originalName": originalName,
        "path": path,
    };
}
