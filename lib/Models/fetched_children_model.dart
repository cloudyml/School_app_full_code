// To parse this JSON data, do
//
//     final fetchedChildrenModel = fetchedChildrenModelFromJson(jsonString);

import 'dart:convert';

FetchedChildrenModel fetchedChildrenModelFromJson(String str) => FetchedChildrenModel.fromJson(json.decode(str));

String fetchedChildrenModelToJson(FetchedChildrenModel data) => json.encode(data.toJson());

class FetchedChildrenModel {
    bool? status;
    String? message;
    FetchedChildrenModelData? data;

    FetchedChildrenModel({
        this.status,
        this.message,
        this.data,
    });

    factory FetchedChildrenModel.fromJson(Map<String, dynamic> json) => FetchedChildrenModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : FetchedChildrenModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class FetchedChildrenModelData {
    String? token;
    DataData? data;

    FetchedChildrenModelData({
        this.token,
        this.data,
    });

    factory FetchedChildrenModelData.fromJson(Map<String, dynamic> json) => FetchedChildrenModelData(
        token: json["token"],
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "data": data?.toJson(),
    };
}

class DataData {
    String? id;
    String? institutionId;
    String? schoolName;
    String? schoolId;
    int? rollNumber;
    String? name;
    int? dataClass;
    String? section;
    String? batch;
    String? gender;
    String? email;
    String? password;
    String? phoneNumber;
    String? address;
    String? firstChar;
    String? parentEmailId;
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
        this.rollNumber,
        this.name,
        this.dataClass,
        this.section,
        this.batch,
        this.gender,
        this.email,
        this.password,
        this.phoneNumber,
        this.address,
        this.firstChar,
        this.parentEmailId,
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
        rollNumber: json["rollNumber"],
        name: json["name"],
        dataClass: json["class"],
        section: json["section"],
        batch: json["batch"],
        gender: json["gender"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        firstChar: json["firstChar"],
        parentEmailId: json["parentEmailID"],
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
        "rollNumber": rollNumber,
        "name": name,
        "class": dataClass,
        "section": section,
        "batch": batch,
        "gender": gender,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "address": address,
        "firstChar": firstChar,
        "parentEmailID": parentEmailId,
        "role": role,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
