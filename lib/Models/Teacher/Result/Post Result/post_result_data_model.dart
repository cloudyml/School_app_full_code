import 'dart:convert';

PostResultModel postResultModelFromJson(String str) =>
    PostResultModel.fromJson(json.decode(str));

String postResultModelToJson(PostResultModel data) =>
    json.encode(data.toJson());

class PostResultModel {
  int? postResultModelClass;
  String? section;
  String? subject;
  String? examType;
  List<StudentList>? studentList;

  PostResultModel({
    this.postResultModelClass,
    this.section,
    this.subject,
    this.examType,
    this.studentList,
  });

  factory PostResultModel.fromJson(Map<String, dynamic> json) =>
      PostResultModel(
        postResultModelClass: json["class"],
        section: json["section"],
        subject: json["subject"],
        examType: json["examType"],
        studentList: json["studentList"] == null
            ? []
            : List<StudentList>.from(
                json["studentList"]!.map((x) => StudentList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "class": postResultModelClass,
        "section": section,
        "subject": subject,
        "examType": examType,
        "studentList": studentList == null
            ? []
            : List<dynamic>.from(studentList!.map((x) => x.toJson())),
      };
}

class StudentList {
  String? id;
  int? rollNumber;
  String? name;
  String? subject;
  int? marks;
  int? outOffMarks;
  int? passingMarks;
  String? grades;
  String? comment;

  StudentList({
    this.id,
    this.rollNumber,
    this.name,
    this.subject,
    this.marks,
    this.outOffMarks,
    this.passingMarks,
    this.grades,
    this.comment,
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
        comment: json["comment"],
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
        "comment": comment,
      };
}
