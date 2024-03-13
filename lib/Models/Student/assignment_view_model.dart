import 'dart:convert';

StudentViewAssignmentModel studentViewAssignmentModelFromJson(String str) =>
    StudentViewAssignmentModel.fromJson(json.decode(str));

String studentViewAssignmentModelToJson(StudentViewAssignmentModel data) =>
    json.encode(data.toJson());

class StudentViewAssignmentModel {
  bool? status;
  String? message;
  List<Datum>? data;

  StudentViewAssignmentModel({
    this.status,
    this.message,
    this.data,
  });

  factory StudentViewAssignmentModel.fromJson(Map<String, dynamic> json) =>
      StudentViewAssignmentModel(
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
    UploadedImage uploadedImage;
    String id;
    String institutionId;
    String schoolId;
    String schoolName;
    String teacherId;
    int datumClass;
    String section;
    String subject;
    String topic;
    DateTime givenDate;
    DateTime lastDateOfSubmit;
    List<dynamic> textAssignmentList;
    List<dynamic> submittedStudentId;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.uploadedImage,
        required this.id,
        required this.institutionId,
        required this.schoolId,
        required this.schoolName,
        required this.teacherId,
        required this.datumClass,
        required this.section,
        required this.subject,
        required this.topic,
        required this.givenDate,
        required this.lastDateOfSubmit,
        required this.textAssignmentList,
        required this.submittedStudentId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uploadedImage: UploadedImage.fromJson(json["uploadedImage"]),
        id: json["_id"],
        institutionId: json["institutionId"],
        schoolId: json["schoolId"],
        schoolName: json["schoolName"],
        teacherId: json["teacherId"],
        datumClass: json["class"],
        section: json["section"],
        subject: json["subject"],
        topic: json["topic"],
        givenDate: DateTime.parse(json["givenDate"]),
        lastDateOfSubmit: DateTime.parse(json["lastDateOfSubmit"]),
        textAssignmentList: List<dynamic>.from(json["textAssignmentList"].map((x) => x)),
        submittedStudentId: List<dynamic>.from(json["submittedStudentId"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "uploadedImage": uploadedImage.toJson(),
        "_id": id,
        "institutionId": institutionId,
        "schoolId": schoolId,
        "schoolName": schoolName,
        "teacherId": teacherId,
        "class": datumClass,
        "section": section,
        "subject": subject,
        "topic": topic,
        "givenDate": givenDate.toIso8601String(),
        "lastDateOfSubmit": lastDateOfSubmit.toIso8601String(),
        "textAssignmentList": List<dynamic>.from(textAssignmentList.map((x) => x)),
        "submittedStudentId": List<dynamic>.from(submittedStudentId.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class UploadedImage {
    String originalName;
    String path;
    String key;
    String link;
    int count;
    String previosName;

    UploadedImage({
        required this.originalName,
        required this.path,
        required this.key,
        required this.link,
        required this.count,
        required this.previosName,
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