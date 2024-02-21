import 'dart:convert';

RecivedStudentTextAssignmentModel recivedStudentTextAssignmentModelFromJson(String str) => RecivedStudentTextAssignmentModel.fromJson(json.decode(str));

String recivedStudentTextAssignmentModelToJson(RecivedStudentTextAssignmentModel data) => json.encode(data.toJson());

class RecivedStudentTextAssignmentModel {
    bool? status;
    String? message;
    Link? link;

    RecivedStudentTextAssignmentModel({
        this.status,
        this.message,
        this.link,
    });

    factory RecivedStudentTextAssignmentModel.fromJson(Map<String, dynamic> json) => RecivedStudentTextAssignmentModel(
        status: json["status"],
        message: json["message"],
        link: json["link"] == null ? null : Link.fromJson(json["link"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "link": link?.toJson(),
    };
}

class Link {
    String? assignmentId;
    String? studentId;
    String? studentName;
    int? linkClass;
    String? section;
    int? rollNumber;
    String? subject;
    String? topic;
    DateTime? submitDate;
    List<TextAssignmentList>? textAssignmentList;
    String? isDone;
    String? id;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Link({
        this.assignmentId,
        this.studentId,
        this.studentName,
        this.linkClass,
        this.section,
        this.rollNumber,
        this.subject,
        this.topic,
        this.submitDate,
        this.textAssignmentList,
        this.isDone,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        assignmentId: json["assignmentId"],
        studentId: json["studentId"],
        studentName: json["studentName"],
        linkClass: json["class"],
        section: json["section"],
        rollNumber: json["rollNumber"],
        subject: json["subject"],
        topic: json["topic"],
        submitDate: json["submitDate"] == null ? null : DateTime.parse(json["submitDate"]),
        textAssignmentList: json["textAssignmentList"] == null ? [] : List<TextAssignmentList>.from(json["textAssignmentList"]!.map((x) => TextAssignmentList.fromJson(x))),
        isDone: json["isDone"],
        id: json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "assignmentId": assignmentId,
        "studentId": studentId,
        "studentName": studentName,
        "class": linkClass,
        "section": section,
        "rollNumber": rollNumber,
        "subject": subject,
        "topic": topic,
        "submitDate": submitDate?.toIso8601String(),
        "textAssignmentList": textAssignmentList == null ? [] : List<dynamic>.from(textAssignmentList!.map((x) => x.toJson())),
        "isDone": isDone,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class TextAssignmentList {
    String? question;
    String? answer;

    TextAssignmentList({
        this.question,
        this.answer,
    });

    factory TextAssignmentList.fromJson(Map<String, dynamic> json) => TextAssignmentList(
        question: json["question"],
        answer: json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
    };
}
