import 'dart:convert';

AssignmentSubmittedStudentListResponseModel
    assignmentSubmittedStudentListResponseModelFromJson(String str) =>
        AssignmentSubmittedStudentListResponseModel.fromJson(json.decode(str));

String assignmentSubmittedStudentListResponseModelToJson(
        AssignmentSubmittedStudentListResponseModel data) =>
    json.encode(data.toJson());

class AssignmentSubmittedStudentListResponseModel {
  List<SubmittedStudentId>? submittedStudentId;

  AssignmentSubmittedStudentListResponseModel({
    this.submittedStudentId,
  });

  factory AssignmentSubmittedStudentListResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AssignmentSubmittedStudentListResponseModel(
        submittedStudentId: json["submittedStudentId"] == null
            ? []
            : List<SubmittedStudentId>.from(json["submittedStudentId"]!
                .map((x) => SubmittedStudentId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "submittedStudentId": submittedStudentId == null
            ? []
            : List<dynamic>.from(submittedStudentId!.map((x) => x.toJson())),
      };
}

class SubmittedStudentId {
  String? studentId;
  String? studentName;
  int? submittedStudentIdClass;
  String? section;
  int? rollNumber;
  DateTime? submitDate;
  List<dynamic>? textAssignmentList;
  UploadedImage? uploadedImage;
  String? isDone;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SubmittedStudentId({
    this.studentId,
    this.studentName,
    this.submittedStudentIdClass,
    this.section,
    this.rollNumber,
    this.submitDate,
    this.textAssignmentList,
    this.uploadedImage,
    this.isDone,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SubmittedStudentId.fromJson(Map<String, dynamic> json) =>
      SubmittedStudentId(
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
            : List<dynamic>.from(json["textAssignmentList"]!.map((x) => x)),
        uploadedImage: json["uploadedImage"] == null
            ? null
            : UploadedImage.fromJson(json["uploadedImage"]),
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
        "studentId": studentId,
        "studentName": studentName,
        "class": submittedStudentIdClass,
        "section": section,
        "rollNumber": rollNumber,
        "submitDate": submitDate?.toIso8601String(),
        "textAssignmentList": textAssignmentList == null
            ? []
            : List<dynamic>.from(textAssignmentList!.map((x) => x)),
        "uploadedImage": uploadedImage?.toJson(),
        "isDone": isDone,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class UploadedImage {
  String? originalName;
  String? path;
  String? key;
  String? link;
  int? count;
  String? previosName;

  UploadedImage({
    this.originalName,
    this.path,
    this.key,
    this.link,
    this.count,
    this.previosName,
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
