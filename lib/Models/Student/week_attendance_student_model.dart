import 'dart:convert';

StudentWeeklyAttendanceModel studentWeeklyAttendanceModelFromJson(String str) => StudentWeeklyAttendanceModel.fromJson(json.decode(str));

String studentWeeklyAttendanceModelToJson(StudentWeeklyAttendanceModel data) => json.encode(data.toJson());

class StudentWeeklyAttendanceModel {
    bool? status;
    String? message;
    Data? data;

    StudentWeeklyAttendanceModel({
        this.status,
        this.message,
        this.data,
    });

    factory StudentWeeklyAttendanceModel.fromJson(Map<String, dynamic> json) => StudentWeeklyAttendanceModel(
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
    List<Datum>? data;
    int? totalPresent;
    int? totalAbsent;

    Data({
        this.data,
        this.totalPresent,
        this.totalAbsent,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        totalPresent: json["totalPresent"],
        totalAbsent: json["totalAbsent"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalPresent": totalPresent,
        "totalAbsent": totalAbsent,
    };
}

class Datum {
    String? date;
    String? day;
    String? attendance;

    Datum({
        this.date,
        this.day,
        this.attendance,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"],
        day: json["day"],
        attendance: json["attendance"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "day": day,
        "attendance": attendance,
    };
}
