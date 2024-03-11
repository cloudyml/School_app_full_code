// import 'dart:convert';

// GetStudentListForResultResponseModel
//     getStudentListForResultResponseModelFromJson(String str) =>
//         GetStudentListForResultResponseModel.fromJson(json.decode(str));

// String getStudentListForResultResponseModelToJson(
//         GetStudentListForResultResponseModel data) =>
//     json.encode(data.toJson());

// class GetStudentListForResultResponseModel {
//   bool? status;
//   String? message;
//   Data? data;

//   GetStudentListForResultResponseModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   factory GetStudentListForResultResponseModel.fromJson(
//           Map<String, dynamic> json) =>
//       GetStudentListForResultResponseModel(
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   String? examType;
//   List<String>? subjects;
//   DefaultData? defaultData;
//   List<ListOfStudent>? studentList;

//   Data({
//     this.examType,
//     this.subjects,
//     this.defaultData,
//     this.studentList,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         examType: json["examType"],
//         subjects: json["subjects"] == null
//             ? []
//             : List<String>.from(json["subjects"]!.map((x) => x)),
//         defaultData: json["defaultData"] == null
//             ? null
//             : DefaultData.fromJson(json["defaultData"]),
//         studentList: json["studentList"] == null
//             ? []
//             : List<ListOfStudent>.from(
//                 json["studentList"]!.map((x) => ListOfStudent.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "examType": examType,
//         "subjects":
//             subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x)),
//         "defaultData": defaultData?.toJson(),
//         "studentList": studentList == null
//             ? []
//             : List<dynamic>.from(studentList!.map((x) => x.toJson())),
//       };
// }

// class DefaultData {
//   MarksList? marksList;
//   List<GradingCriterion>? gradingCriteria;

//   DefaultData({
//     this.marksList,
//     this.gradingCriteria,
//   });

//   factory DefaultData.fromJson(Map<String, dynamic> json) => DefaultData(
//         marksList: json["marksList"] == null
//             ? null
//             : MarksList.fromJson(json["marksList"]),
//         gradingCriteria: json["gradingCriteria"] == null
//             ? []
//             : List<GradingCriterion>.from(json["gradingCriteria"]!
//                 .map((x) => GradingCriterion.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "marksList": marksList?.toJson(),
//         "gradingCriteria": gradingCriteria == null
//             ? []
//             : List<dynamic>.from(gradingCriteria!.map((x) => x.toJson())),
//       };
// }

// class GradingCriterion {
//   List<int>? marksRange;
//   String? grades;
//   String? comments;
//   String? id;

//   GradingCriterion({
//     this.marksRange,
//     this.grades,
//     this.comments,
//     this.id,
//   });

//   factory GradingCriterion.fromJson(Map<String, dynamic> json) =>
//       GradingCriterion(
//         marksRange: json["marksRange"] == null
//             ? []
//             : List<int>.from(json["marksRange"]!.map((x) => x)),
//         grades: json["grades"],
//         comments: json["comments"],
//         id: json["_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "marksRange": marksRange == null
//             ? []
//             : List<dynamic>.from(marksRange!.map((x) => x)),
//         "grades": grades,
//         "comments": comments,
//         "_id": id,
//       };
// }

// class MarksList {
//   int? passingMarks;
//   int? outOffMarks;

//   MarksList({
//     this.passingMarks,
//     this.outOffMarks,
//   });

//   factory MarksList.fromJson(Map<String, dynamic> json) => MarksList(
//         passingMarks: json["passingMarks"],
//         outOffMarks: json["outOffMarks"],
//       );

//   Map<String, dynamic> toJson() => {
//         "passingMarks": passingMarks,
//         "outOffMarks": outOffMarks,
//       };
// }

// class ListOfStudent {
//   String? id;
//   int? rollNumber;
//   String? name;

//   ListOfStudent({
//     this.id,
//     this.rollNumber,
//     this.name,
//   });

//   factory ListOfStudent.fromJson(Map<String, dynamic> json) => ListOfStudent(
//         id: json["_id"],
//         rollNumber: json["rollNumber"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "rollNumber": rollNumber,
//         "name": name,
//       };
// }

//..... Above one is Harsh wala experiment......................................................................

import 'dart:convert';

GetStudentListForResultResponseModel
    getStudentListForResultResponseModelFromJson(String str) =>
        GetStudentListForResultResponseModel.fromJson(json.decode(str));

String getStudentListForResultResponseModelToJson(
        GetStudentListForResultResponseModel data) =>
    json.encode(data.toJson());

class GetStudentListForResultResponseModel {
  bool? status;
  String? message;
  Data? data;

  GetStudentListForResultResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetStudentListForResultResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetStudentListForResultResponseModel(
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
  String? examType;
  List<String>? subjects;
  DefaultData? defaultData;
  List<StudentList>? studentList;

  Data({
    this.examType,
    this.subjects,
    this.defaultData,
    this.studentList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        examType: json["examType"],
        subjects: json["subjects"] == null
            ? []
            : List<String>.from(json["subjects"]!.map((x) => x)),
        defaultData: json["defaultData"] == null
            ? null
            : DefaultData.fromJson(json["defaultData"]),
        studentList: json["studentList"] == null
            ? []
            : List<StudentList>.from(
                json["studentList"]!.map((x) => StudentList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "examType": examType,
        "subjects":
            subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x)),
        "defaultData": defaultData?.toJson(),
        "studentList": studentList == null
            ? []
            : List<dynamic>.from(studentList!.map((x) => x.toJson())),
      };
}

class DefaultData {
  MarksList? marksList;
  List<GradingCriterion>? gradingCriteria;

  DefaultData({
    this.marksList,
    this.gradingCriteria,
  });

  factory DefaultData.fromJson(Map<String, dynamic> json) => DefaultData(
        marksList: json["marksList"] == null
            ? null
            : MarksList.fromJson(json["marksList"]),
        gradingCriteria: json["gradingCriteria"] == null
            ? []
            : List<GradingCriterion>.from(json["gradingCriteria"]!
                .map((x) => GradingCriterion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "marksList": marksList?.toJson(),
        "gradingCriteria": gradingCriteria == null
            ? []
            : List<dynamic>.from(gradingCriteria!.map((x) => x.toJson())),
      };
}

class GradingCriterion {
  List<int>? marksRange;
  String? grades;
  String? comments;
  String? id;

  GradingCriterion({
    this.marksRange,
    this.grades,
    this.comments,
    this.id,
  });

  factory GradingCriterion.fromJson(Map<String, dynamic> json) =>
      GradingCriterion(
        marksRange: json["marksRange"] == null
            ? []
            : List<int>.from(json["marksRange"]!.map((x) => x)),
        grades: json["grades"],
        comments: json["comments"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "marksRange": marksRange == null
            ? []
            : List<dynamic>.from(marksRange!.map((x) => x)),
        "grades": grades,
        "comments": comments,
        "_id": id,
      };
}

class MarksList {
  int? passingMarks;
  int? outOffMarks;

  MarksList({
    this.passingMarks,
    this.outOffMarks,
  });

  factory MarksList.fromJson(Map<String, dynamic> json) => MarksList(
        passingMarks: json["passingMarks"],
        outOffMarks: json["outOffMarks"],
      );

  Map<String, dynamic> toJson() => {
        "passingMarks": passingMarks,
        "outOffMarks": outOffMarks,
      };
}

class StudentList {
  String? id;
  int? rollNumber;
  String? name;

  StudentList({
    this.id,
    this.rollNumber,
    this.name,
  });

  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
        id: json["_id"],
        rollNumber: json["rollNumber"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "rollNumber": rollNumber,
        "name": name,
      };
}
