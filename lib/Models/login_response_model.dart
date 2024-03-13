import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  bool? status;
  String? message;
  LoginResponseModelData? data;

  LoginResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : LoginResponseModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class LoginResponseModelData {
  String? id;
  String? token;
  String? fcmToken;
  LoginData? data;

  LoginResponseModelData({
    this.id,
    this.token,
    this.fcmToken,
    this.data,
  });

  factory LoginResponseModelData.fromJson(Map<String, dynamic> json) =>
      LoginResponseModelData(
        id: json["id"],
        token: json["token"],
        fcmToken: json["fcmToken"],
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "fcmToken": fcmToken,
        "data": data?.toJson(),
      };
}

class LoginData {
  String? address;
  String? role;
  String? gender;
  String? batch;
  String? parentsId;
  String? section;
  String? password;
  String? phoneNumber;
  String? schoolName;
  String? schoolId;
  int? rollNumber;
  String? name;
  int? dataClass;
  String? subject;

  //changed
  String? id;
  bool? admin;
  String? email;
  String? institutionId;

  //ADDED THIS by HARSH
  List<String>? childrens;

  LoginData(
      {this.address,
      this.role,
      this.gender,
      this.batch,
      this.parentsId,
      this.section,
      this.password,
      this.phoneNumber,
      this.schoolName,
      this.rollNumber,
      this.name,
      this.dataClass,
      this.subject,
      this.id,
      this.admin,
      this.email,
      this.schoolId,
      this.institutionId,
      this.childrens});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        address: json["address"],
        role: json["role"],
        gender: json["gender"],
        batch: json["batch"],
        parentsId: json["parents_id"],
        section: json["section"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        schoolName: json["schoolName"],
        rollNumber: json["rollNumber"],
        name: json["name"],
        dataClass: json["class"],
        subject: json["subject"],
        id: json["_id"],
        admin: json["admin"],
        email: json["email"],
        schoolId: json["schoolId"],
        institutionId: json["institutionId"],
        childrens: json["childrens"] == null
            ? []
            : List<String>.from(json["childrens"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "role": role,
        "gender": gender,
        "batch": batch,
        "parents_id": parentsId,
        "section": section,
        "password": password,
        "phoneNumber": phoneNumber,
        "schoolName": schoolName,
        "rollNumber": rollNumber,
        "name": name,
        "class": dataClass,
        "subject": subject,
        "_id": id,
        "admin": admin,
        "institutionId": institutionId,
        "schoolId": schoolId,
        "email": email,
        "childrens": childrens == null
            ? []
            : List<dynamic>.from(childrens!.map((x) => x)),
      };
}

// Login Model Updated
