
import 'dart:convert';

TeacherLoginResponseModel teacherLoginResponseModelFromJson(String str) => TeacherLoginResponseModel.fromJson(json.decode(str));

String teacherLoginResponseModelToJson(TeacherLoginResponseModel data) => json.encode(data.toJson());

class TeacherLoginResponseModel {
    bool? status;
    String? message;
    TeacherLoginResponseModelData? data;

    TeacherLoginResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory TeacherLoginResponseModel.fromJson(Map<String, dynamic> json) => TeacherLoginResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : TeacherLoginResponseModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class TeacherLoginResponseModelData {
    String? id;
    String? token;
    String? fcmToken;
    DataData? data;

    TeacherLoginResponseModelData({
        this.id,
        this.token,
        this.fcmToken,
        this.data,
    });

    factory TeacherLoginResponseModelData.fromJson(Map<String, dynamic> json) => TeacherLoginResponseModelData(
        id: json["id"],
        token: json["token"],
        fcmToken: json["fcmToken"],
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "fcmToken": fcmToken,
        "data": data?.toJson(),
    };
}

class DataData {
    String? id;
    String? institutionId;
    String? schoolName;
    String? schoolId;
    String? name;
    int? dataClass;
    bool? isClassTeacher;
    List<String>? subjects;
    String? gender;
    String? email;
    String? password;
    String? phoneNumber;
    String? address;
    String? role;
    bool? isDeleted;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    DataData({
        this.id,
        this.institutionId,
        this.schoolName,
        this.schoolId,
        this.name,
        this.dataClass,
        this.isClassTeacher,
        this.subjects,
        this.gender,
        this.email,
        this.password,
        this.phoneNumber,
        this.address,
        this.role,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        id: json["_id"],
        institutionId: json["institutionId"],
        schoolName: json["schoolName"],
        schoolId: json["schoolId"],
        name: json["name"],
        dataClass: json["class"],
        isClassTeacher: json["isClassTeacher"],
        subjects: json["subjects"] == null ? [] : List<String>.from(json["subjects"]!.map((x) => x)),
        gender: json["gender"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        role: json["role"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "institutionId": institutionId,
        "schoolName": schoolName,
        "schoolId": schoolId,
        "name": name,
        "class": dataClass,
        "isClassTeacher": isClassTeacher,
        "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x)),
        "gender": gender,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "address": address,
        "role": role,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
