
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:school_management_system/Models/Student/recived_text_assignment_model.dart';
import 'package:school_management_system/Models/Student/student_tex_assignment_submitted_model.dart';
import 'package:school_management_system/Models/Teacher/Attendance/view_attendance_of_class_response_model.dart';
import 'package:school_management_system/Models/fetched_children_model.dart';
import 'package:school_management_system/Services/shared_services_parent_children.dart';
import '../../Models/Student/About/view_about_school.dart';
import '../../Models/Student/Awards/view_awards_response_model.dart';
import '../../Models/Student/Events/Register_Event/eligibility_check_get_api_response_model.dart';
import '../../Models/Student/Events/Register_Event/my_enrolled_events_list_model.dart';
import '../../Models/Student/Events/view_events_response_model.dart';
import '../../Models/Student/Exam/exam_routine_response_model.dart';
import '../../Models/Student/Fees/student_fee_response_model.dart';
import '../../Models/Student/Gallery/view_gallery_response_model.dart';
import '../../Models/Student/Notice/view_notice_response_model.dart';
import '../../Models/Student/Result/student_see_result_model.dart';
import '../../Models/Student/Student_Upload_Assignment.dart';
import '../../Models/Student/assignment_view_model.dart';
import '../../Models/Student/day_Routine_response_medel.dart';
import '../../Models/Student/month_attendance_student_response_model.dart';
import '../../Models/Student/submitted_assignment_model.dart';
import '../../Models/Student/week_attendance_student_model.dart';
import '../../Models/Teacher/Attendance/Original_Model/attendance_response_model.dart';
import '../../Models/Teacher/Attendance/attendance_submit_model.dart';
import '../../Models/Teacher/Awards/classwise_awards_list.dart';
import '../../Models/Teacher/Events/event_registered_student_list_model.dart';
import '../../Models/Teacher/Gallery/upload_gallery.dart';
import '../../Models/login_response_model.dart';
import '../api_urls.dart';
import '../base_api_service.dart';

class ApiServices {
// ....... Login  ..................................................
  static Future<bool> userLoginParentStudent(
    String email,
    String password,
    String selectedrole,
    String fcmTokenn,
    BuildContext context,
  ) async {
    var ret = false;

    try {
      var response = await ApiBase.postRequest(
        extendedURL: ApiUrl.login,
        body: {
          "email": email,
          "password": password,
          "fcmToken": fcmTokenn,
          "role": selectedrole,
        },
      );

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          var responseModel = loginResponseModelFromJson(response.body);
          Future.delayed(
            const Duration(seconds: 1),
            () {
              fetchChildData();
            },
          );

          // log(responseModel.message!);

          ret = true;
          selectedrole == "parent"
              ? {
                  await SharedServiceParentChildren
                          .setLoginDetailsParentChildren(responseModel)
                      .whenComplete(() => fetchChildData()),
                  await ApiServices.dataOfAllStudents(
                      SharedServiceParentChildren.loginDetails()!
                          .data!
                          .data!
                          .childrens!
                          .length),
                }
              : SharedServiceParentChildren.setLoginDetailsParentChildren(
                  responseModel);
          SharedServiceParentChildren().userType(
              "${SharedServiceParentChildren.loginDetails()?.data?.data!.role}");

          log(
            '-----------\n-\n-\-n-\n--\n-\n------------\n--\n-\n-\n-\n-\n----\n----\n-------------------------------- this is the data in sharepref.type  ${SharedServiceParentChildren.type()}',
          );
        } else {
          ret = false;
          log("not successful");
        }
      } else {
        ret = false;
        log("not successful ");
      }
    } catch (e) {
      ret = false;
      log("$e :  not successful catch");
    }

    return ret;
  }

  // Fetch UserData using Unique ID.........................................

  static Future<FetchedChildrenModel> childrenData(String id) async {
    try {
      var response = await ApiBase.getRequest(
          extendedURL: "  ${ApiUrl.childrenDataById}/$id");

      log(response.statusCode.toString());
      debugPrint(response.body.toString());

      log("\n${response.body}");

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          FetchedChildrenModel responseModel =
              fetchedChildrenModelFromJson(response.body);
          log(responseModel.message!);
          SharedServiceParentChildren.setDetailsOfFetchedChild(responseModel);
          log("  this is the data in the child detils shared pref ${SharedServiceParentChildren.childDetails()?.data?.data?.address.toString()}");

          // var harsh = SharedServiceParentChildren.childDetails();
          // log("  this is the data fetched from shared pref ${harsh?.data?.data?.address} ");
        } else {
          log("not successful");
        }
      } else {
        log("not successful ");
      }
    } catch (e) {
      log("$e :  not successful catch");
    }
    return FetchedChildrenModel();
  }

//...................Teacher Get all students of a class for taking attendance.....

  static Future<AttendanceResponseModel> takeAttendance(
    String selectedClass,
    String selectedSection,
  ) async {
    AttendanceResponseModel attendanceModel = AttendanceResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "/teacher/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.studentListForTakeAttendance}?class=$selectedClass&section=$selectedSection",
      );
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          attendanceModel = attendanceResponseModelFromJson(response.body);
        } else {
          attendanceModel = AttendanceResponseModel();
        }
      } else {
        attendanceModel = AttendanceResponseModel();
      }
    } catch (e) {
      attendanceModel = AttendanceResponseModel();
    }

    return attendanceModel;
  }

// Teacher Submit attendance (POST API)...........................................
  static Future<bool> submitAttendance(
    Map<String, dynamic> attendance,
  ) async {
    var ret = false;

    try {
      var response = await ApiBase.postRequest(
        extendedURL:
            "/teacher/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.teacherSubmitAttendance}",
        body: attendance,
      );

      log(ApiUrl.teacherSubmitAttendance);

      log(response.statusCode.toString());
      log("${response.body}");

      if (response.statusCode == 201) {
        if (jsonDecode(response.body)['status'] == true) {
          ret = true;
        } else {
          ret = false;
          log("not successful");
        }
      } else {
        ret = false;
        log("not successful ");
      }
    } catch (e) {
      ret = false;
      log("$e :  not successful catch");
    }

    return ret;
  }

// Teacher See Attendance of the whole class date wise......................................

  static Future<TeacherViewAttendanceOfClassResponseModel>
      teacherSeeAttendanceOfWholeClassOfAday(
    String selectedClass,
    String selectedSection,
    String selectedDate,
  ) async {
    TeacherViewAttendanceOfClassResponseModel attendanceModel =
        TeacherViewAttendanceOfClassResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "teacher/${SharedServiceParentChildren.loginDetails()!.data!.id.toString()}${ApiUrl.teacherSeeAttendanceOfWholeClassOfAday}?class=$selectedClass&section=$selectedSection&date=$selectedDate",
      );
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          attendanceModel =
              teacherViewAttendanceOfClassResponseModelFromJson(response.body);
        } else {
          attendanceModel = TeacherViewAttendanceOfClassResponseModel();
        }
      } else {
        attendanceModel = TeacherViewAttendanceOfClassResponseModel();
      }
    } catch (e) {
      attendanceModel = TeacherViewAttendanceOfClassResponseModel();
    }

    return attendanceModel;
  }

//Parent  can see his/her child's Weekly Attendance.........................................

  static Future<StudentWeeklyAttendanceModel> parentWeekAttendance() async {
    StudentWeeklyAttendanceModel WeeklyAttendance =
        StudentWeeklyAttendanceModel();
    try {
      fetchChildData();

      var currentDate = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
      String studentClass =
          '${SharedServiceParentChildren.childDetails()?.data?.data?.dataClass}';
      String section =
          '${SharedServiceParentChildren.childDetails()?.data?.data?.section}';
      String rollNumber =
          ' ${SharedServiceParentChildren.childDetails()?.data?.data?.rollNumber}';
      String date = formattedDate;

      var queryParam =
          "/${SharedServiceParentChildren.loginDetails()?.data?.data?.role}/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.weekStudentAttendance}?class=$studentClass&section=$section&rollNumber=$rollNumber&date=$date";
      var response = await ApiBase.getRequest(
        extendedURL: queryParam, // Use queryParam here
      );
      log(response.statusCode.toString());
      log(formattedDate.toString());
      log(section.toString());
      log(rollNumber.toString());
      log(studentClass);

      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          WeeklyAttendance =
              studentWeeklyAttendanceModelFromJson(response.body);
        } else {
          log("else 2");
          WeeklyAttendance = StudentWeeklyAttendanceModel();
        }
      } else {
        log("else 2");
        WeeklyAttendance = StudentWeeklyAttendanceModel();
      }
    } catch (e) {
      log("Catch");
      WeeklyAttendance = StudentWeeklyAttendanceModel();
    }

    return WeeklyAttendance;
  }

// Student can see his/her Weekly Attendance.........................................

  static Future<StudentWeeklyAttendanceModel>
      studentParentWeekAttendance() async {
    StudentWeeklyAttendanceModel WeeklyAttendance =
        StudentWeeklyAttendanceModel();
    try {
      var currentDate = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
      String studentClass =
          '${SharedServiceParentChildren.loginDetails()?.data!.data!.dataClass}';
      String section =
          '${SharedServiceParentChildren.loginDetails()?.data!.data!.section}';
      String rollNumber =
          ' ${SharedServiceParentChildren.loginDetails()?.data!.data!.rollNumber}';
      String date = formattedDate;

      var response = SharedServiceParentChildren.loginDetails()
                  ?.data
                  ?.data
                  ?.role ==
              "parent"
          ? await ApiBase.getRequest(
              token: SharedServiceParentChildren.childDetails()?.data?.token,
              extendedURL:
                  "/student/${SharedServiceParentChildren.childDetails()?.data?.data?.id}${ApiUrl.weekStudentAttendance}?date=$date", // Use queryParam here
            )
          : await ApiBase.getRequest(
              extendedURL:
                  "/student/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.weekStudentAttendance}?date=$date", // Use queryParam here
            );
      log(response.statusCode.toString());
      log(formattedDate.toString());
      log(section.toString());
      log(rollNumber.toString());
      log(studentClass);

      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          WeeklyAttendance =
              studentWeeklyAttendanceModelFromJson(response.body);
        } else {
          log("else 2");
          WeeklyAttendance = StudentWeeklyAttendanceModel();
        }
      } else {
        log("else 2");
        WeeklyAttendance = StudentWeeklyAttendanceModel();
      }
    } catch (e) {
      log("Catch");
      WeeklyAttendance = StudentWeeklyAttendanceModel();
    }

    return WeeklyAttendance;
  }

// parent view childs  Monthly Attendance.........................................

  static Future<StudentMonthlyAttendanceModel> parentMonthlyAttendance(
    final String month,
    final String year,
  ) async {
    StudentMonthlyAttendanceModel MonthlyAttendance =
        StudentMonthlyAttendanceModel();
    try {
      // fetchChildData();
      String studentClass =
          '${SharedServiceParentChildren.childDetails()?.data?.data?.dataClass}';
      String section =
          '${SharedServiceParentChildren.childDetails()?.data?.data?.section}';
      String rollNumber =
          ' ${SharedServiceParentChildren.childDetails()?.data?.data?.rollNumber}';

      var queryParam =
          "/${SharedServiceParentChildren.loginDetails()?.data?.data?.role}/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.monthStudentAttendance}?class=$studentClass&section=$section&rollNumber=$rollNumber&month=$month&year=$year";
      var response = await ApiBase.getRequest(
        extendedURL: queryParam, // Use queryParam here
      );

      log(response.statusCode.toString());
      log(studentClass);
      log(section.toString());
      log(rollNumber.toString());
      log(month.toString());
      log(year.toString());

      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          MonthlyAttendance =
              studentMonthlyAttendanceModelFromJson(response.body);
        } else {
          log("else 2");
          MonthlyAttendance = StudentMonthlyAttendanceModel();
        }
      } else {
        log("else 2");
        MonthlyAttendance = StudentMonthlyAttendanceModel();
      }
    } catch (e) {
      log("Catch");
      MonthlyAttendance = StudentMonthlyAttendanceModel();
    }

    return MonthlyAttendance;
  }

// Student can see his/her Monthly Attendance.........................................

  static Future<StudentMonthlyAttendanceModel> studentParentMonthlyAttendance(
    final String month,
    final String year,
  ) async {
    StudentMonthlyAttendanceModel MonthlyAttendance =
        StudentMonthlyAttendanceModel();
    try {
      String studentClass =
          '${SharedServiceParentChildren.loginDetails()?.data!.data!.dataClass}';
      String section =
          '${SharedServiceParentChildren.loginDetails()?.data!.data!.section}';
      String rollNumber =
          ' ${SharedServiceParentChildren.loginDetails()?.data!.data!.rollNumber}';

      var response = SharedServiceParentChildren.loginDetails()
                  ?.data
                  ?.data
                  ?.role ==
              "parent"
          ? await ApiBase.getRequest(
              token: SharedServiceParentChildren.childDetails()?.data?.token,
              extendedURL:
                  "/student/${SharedServiceParentChildren.childDetails()?.data?.data?.id}${ApiUrl.monthStudentAttendance}?month=$month&year=$year")
          : await ApiBase.getRequest(
              extendedURL:
                  "/student/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.monthStudentAttendance}?month=$month&year=$year", // Use queryParam here
            );

      log(response.statusCode.toString());
      log(studentClass);
      log(section.toString());
      log(rollNumber.toString());
      log(month.toString());
      log(year.toString());

      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          MonthlyAttendance =
              studentMonthlyAttendanceModelFromJson(response.body);
        } else {
          log("else 2");
          MonthlyAttendance = StudentMonthlyAttendanceModel();
        }
      } else {
        log("else 2");
        MonthlyAttendance = StudentMonthlyAttendanceModel();
      }
    } catch (e) {
      log("Catch");
      MonthlyAttendance = StudentMonthlyAttendanceModel();
    }

    return MonthlyAttendance;
  }

// parent view timetable
  static Future<StudentEachdayRoutineModel> parentViewEachDayRoutine() async {
    StudentEachdayRoutineModel studentDailyRoutine =
        StudentEachdayRoutineModel();
    try {
      // fetchChildData();
      String studentClass =
          '${SharedServiceParentChildren.childDetails()?.data?.data?.dataClass}';
      String section =
          '${SharedServiceParentChildren.childDetails()?.data?.data?.section}';

      var queryParam =
          "${ApiUrl.dailyRoutine}?class=$studentClass&section=$section";
      var response = await ApiBase.getRequest(
        extendedURL: queryParam,
      );
      log(response.statusCode.toString());
      log(section.toString());
      log(studentClass);

      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          studentDailyRoutine =
              studentEachdayRoutineModelFromJson(response.body);
        } else {
          log("else 2");
          studentDailyRoutine = StudentEachdayRoutineModel();
        }
      } else {
        log("else 2");
        studentDailyRoutine = StudentEachdayRoutineModel();
      }
    } catch (e) {
      log("Catch");
      studentDailyRoutine = StudentEachdayRoutineModel();
    }

    return studentDailyRoutine;
  }

// Student view Daily Routine.........................
  static Future<StudentEachdayRoutineModel> StudentEachDayRoutine() async {
    StudentEachdayRoutineModel studentDailyRoutine =
        StudentEachdayRoutineModel();
    try {
      String studentClass =
          '${SharedServiceParentChildren.loginDetails()?.data!.data!.dataClass}';
      String section =
          '${SharedServiceParentChildren.loginDetails()?.data!.data!.section}';

      var response = SharedServiceParentChildren.loginDetails()
                  ?.data
                  ?.data
                  ?.role ==
              "parent"
          ? await ApiBase.getRequest(
              token: SharedServiceParentChildren.childDetails()?.data?.token,
              extendedURL:
                  "/student/${SharedServiceParentChildren.childDetails()?.data?.data?.id}${ApiUrl.dailyRoutine}",
            )
          : await ApiBase.getRequest(
              extendedURL:
                  "/student/${SharedServiceParentChildren.loginDetails()?.data?.data?.id}${ApiUrl.dailyRoutine}",
            );
      log(response.statusCode.toString());
      log(section.toString());
      log(studentClass);

      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          studentDailyRoutine =
              studentEachdayRoutineModelFromJson(response.body);
        } else {
          log("else 2");
          studentDailyRoutine = StudentEachdayRoutineModel();
        }
      } else {
        log("else 2");
        studentDailyRoutine = StudentEachdayRoutineModel();
      }
    } catch (e) {
      log("Catch");
      studentDailyRoutine = StudentEachdayRoutineModel();
    }

    return studentDailyRoutine;
  }

// Teacher see class routine Day wise....................................................

  static Future<StudentEachdayRoutineModel> TeacherSeeDayRoutine(
    String selectedClass,
    String selectedSection,
  ) async {
    StudentEachdayRoutineModel studentDailyRoutine =
        StudentEachdayRoutineModel();
    try {
      var queryParam =
          "/teacher/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.dailyRoutine}?class=$selectedClass&section=$selectedSection";
      var response = await ApiBase.getRequest(
        extendedURL: queryParam,
      );
      log(response.statusCode.toString());

      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          studentDailyRoutine =
              studentEachdayRoutineModelFromJson(response.body);
        } else {
          log("else 2");
          studentDailyRoutine = StudentEachdayRoutineModel();
        }
      } else {
        log("else 2");
        studentDailyRoutine = StudentEachdayRoutineModel();
      }
    } catch (e) {
      log("Catch");
      studentDailyRoutine = StudentEachdayRoutineModel();
    }

    return studentDailyRoutine;
  }

// fetch the child details for the parent.........................................
  static fetchChildData() async {
    await ApiServices.childrenData(SharedServiceParentChildren.loginDetails()
        ?.data!
        .data!
        .childrens![0]
        .toString() as String);
  }

  static dataOfAllStudents(
    int lenOfChildrens,
  ) async {
    List<FetchedChildrenModel> allChildInfo = [];
    // allChildInfo.add(value)
    for (int i = 0; i <= lenOfChildrens; i++) {
      try {
        var response = await ApiBase.getRequest(
            extendedURL:
                "${ApiUrl.childrenDataById}/${SharedServiceParentChildren.loginDetails()?.data?.data?.childrens?[i]}");
        if (response.statusCode == 200) {
          if (jsonDecode(response.body)['status'] == true) {
            allChildInfo.add(fetchedChildrenModelFromJson(response.body));
          } else {
            log("not successful");
          }
        } else {
          log("not successful ");
        }

        // log(response.statusCode.toString());
        // debugPrint(response.body.toString());
      } catch (e) {
        log(e.toString());
      }
    }
    SharedServiceParentChildren.listOfAllTheChildrens(allChildInfo);
    // for (int i = 0; i < allChildInfo.length; i++) {
    //   log("this is the info of $i student${allChildInfo[i].data?.data?.name.toString()}");
    // }
  }

// Parent View Children Assignment
  static Future<StudentViewAssignmentModel> parentViewPendingAssignmentFile(
      String type, String form) async {
    StudentViewAssignmentModel studentCAttignment =
        StudentViewAssignmentModel();

    try {
      // fetchChildData();
      var rollNumber =
          SharedServiceParentChildren.childDetails()?.data?.data?.rollNumber;
      String studentClass =
          '${SharedServiceParentChildren.childDetails()?.data?.data?.dataClass}';
      String section =
          '${SharedServiceParentChildren.childDetails()?.data?.data?.section}';
      var queryParam =
          "${ApiUrl.studentPendingAssignment}/${SharedServiceParentChildren.childDetails()?.data?.data!.id.toString()}/$type-$form?institutionId=${SharedServiceParentChildren.childDetails()?.data?.data?.institutionId}&schoolId=${SharedServiceParentChildren.childDetails()?.data?.data?.schoolId}&class=$studentClass&section=$section";
      var response = await ApiBase.getRequest(
        token: SharedServiceParentChildren.childDetails()?.data?.token,
        extendedURL: queryParam,
      );

      log(response.statusCode.toString());
      log("RollNumber : ${rollNumber.toString()}");
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          studentCAttignment =
              studentViewAssignmentModelFromJson(response.body);
        } else {
          log("else 2");
          studentCAttignment = StudentViewAssignmentModel();
        }
      } else {
        log("else 2");
        studentCAttignment = StudentViewAssignmentModel();
      }
    } catch (e) {
      log("Catch");
      studentCAttignment = StudentViewAssignmentModel();
    }

    return studentCAttignment;
  }

  // // Student see his/her submitted assignment ....................................

  // static Future<StudentSubmittedAssignmentModel>
  //     StudentSubmittedAssignment() async {
  //   StudentSubmittedAssignmentModel submittedAttignment =
  //       StudentSubmittedAssignmentModel();
  //   try {
  //     String studentClass =
  //         '${SharedServiceParentChildren.loginDetails()?.data!.data!.dataClass}';
  //     String section = '${SharedServiceParentChildren.loginDetails()?.data!.data!.section}';
  //     var queryParam =
  //         "${ApiUrl.studentSubmittedAssignment}/${SharedServiceParentChildren.loginDetails()?.data!.id.toString()}/studentseeSubmittedAssignment?class=$studentClass&section=$section";
  //     var response = await ApiBase.getRequest(
  //       extendedURL: queryParam,
  //     );

  //     log(response.body.toString());
  //     if (response.statusCode == 200) {
  //       if (jsonDecode(response.body)['status'] == true) {
  //         log("success");
  //         submittedAttignment =
  //             studentSubmittedAssignmentModelFromJson(response.body);
  //       } else {
  //         log("else 2");
  //         submittedAttignment = StudentSubmittedAssignmentModel();
  //       }
  //     } else {
  //       log("else 2");
  //       submittedAttignment = StudentSubmittedAssignmentModel();
  //     }
  //   } catch (e) {
  //     log("Catch");
  //     submittedAttignment = StudentSubmittedAssignmentModel();
  //   }

  //   return submittedAttignment;
  // }

  static Future<StudentSubmittedAssignmentModel>
      parentViewSubmittedAssignmentFile(String type, String form) async {
    StudentSubmittedAssignmentModel submittedAttignment =
        StudentSubmittedAssignmentModel();
    try {
      await ApiServices.childrenData(SharedServiceParentChildren.loginDetails()
          ?.data!
          .data!
          .childrens![0]
          .toString() as String);
      String studentClass =
          '${SharedServiceParentChildren.childDetails()?.data?.data?.dataClass}';
      String section =
          '${SharedServiceParentChildren.childDetails()?.data?.data?.section}';
      var queryParam =
          "${ApiUrl.studentPendingAssignment}/${SharedServiceParentChildren.childDetails()?.data?.data!.id.toString()}/$type-$form?institutionId=${SharedServiceParentChildren.childDetails()?.data?.data?.institutionId}&schoolId=${SharedServiceParentChildren.childDetails()?.data?.data?.schoolId}&class=$studentClass&section=$section";
      var response = await ApiBase.getRequest(
        token: SharedServiceParentChildren.childDetails()?.data?.token,
        extendedURL: queryParam,
      );

      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          submittedAttignment =
              studentSubmittedAssignmentModelFromJson(response.body);
        } else {
          log("else 2");
          submittedAttignment = StudentSubmittedAssignmentModel();
        }
      } else {
        log("else 2");
        submittedAttignment = StudentSubmittedAssignmentModel();
      }
    } catch (e) {
      log("Catch");
      submittedAttignment = StudentSubmittedAssignmentModel();
    }

    return submittedAttignment;
  }

// Student view assignment (Pending) file ...............................................................

  static Future<StudentViewAssignmentModel> studentSeeAssignmentFile(
      String type, String form) async {
    StudentViewAssignmentModel studentCAttignment =
        StudentViewAssignmentModel();
    try {
      var rollNumber =
          SharedServiceParentChildren.loginDetails()?.data!.data!.rollNumber;
      String studentClass =
          '${SharedServiceParentChildren.loginDetails()?.data!.data!.dataClass}';
      String section =
          '${SharedServiceParentChildren.loginDetails()?.data!.data!.section}';
      var queryParam =
          "${ApiUrl.studentPendingAssignment}/${SharedServiceParentChildren.loginDetails()?.data!.id.toString()}/$type-$form?institutionId=${SharedServiceParentChildren.loginDetails()?.data?.data?.institutionId}&schoolId=${SharedServiceParentChildren.loginDetails()?.data?.data?.schoolId}&class=$studentClass&section=$section";
      var response = await ApiBase.getRequest(
        extendedURL: queryParam,
      );

      log(response.statusCode.toString());
      log("RollNumber : ${rollNumber.toString()}");
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success ");
          studentCAttignment =
              studentViewAssignmentModelFromJson(response.body);
        } else {
          log("else 2");
          studentCAttignment = StudentViewAssignmentModel();
        }
      } else {
        log("else 2");
        studentCAttignment = StudentViewAssignmentModel();
      }
    } catch (e) {
      log("Catch");
      studentCAttignment = StudentViewAssignmentModel();
    }

    return studentCAttignment;
  }

// Student view assignment (Pending) Text ...............................................................

  static Future<SubmittedTextAssignmentModel> studentSeeAssignmentText(
      String type, String form) async {
    SubmittedTextAssignmentModel studentCAttignment =
        SubmittedTextAssignmentModel();
    try {
      var rollNumber =
          SharedServiceParentChildren.loginDetails()?.data!.data!.rollNumber;
      String studentClass =
          '${SharedServiceParentChildren.loginDetails()?.data!.data!.dataClass}';
      String section =
          '${SharedServiceParentChildren.loginDetails()?.data!.data!.section}';
      var queryParam =
          "${ApiUrl.studentPendingAssignment}/${SharedServiceParentChildren.loginDetails()?.data!.id.toString()}/$type-$form?institutionId=${SharedServiceParentChildren.loginDetails()?.data?.data?.institutionId}&schoolId=${SharedServiceParentChildren.loginDetails()?.data?.data?.schoolId}&class=$studentClass&section=$section";
      var response = await ApiBase.getRequest(
        extendedURL: queryParam,
      );
      // log("this is type -------------------------------------->" + type);
      // log("this is type -------------------------------------->" + form);
      // log(form);
      // log(response.statusCode.toString());
      // log("RollNumber : ${rollNumber.toString()}");
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          // log("success");
          studentCAttignment =
              submittedTextAssignmentModelFromJson(response.body);
          // log(studentCAttignment.data![0].textAssignmentList![0]["question"]
          //     .toString());
        } else {
          log("else 2");
          studentCAttignment = SubmittedTextAssignmentModel();
        }
      } else {
        log("else 2");
        studentCAttignment = SubmittedTextAssignmentModel();
      }
    } catch (e) {
      log(e.toString());
      studentCAttignment = SubmittedTextAssignmentModel();
    }

    return studentCAttignment;
  }

//......... parent see pending assignment Text ...............................
  static Future<SubmittedTextAssignmentModel> parentSeeAssignmentText(
      String type, String form) async {
    SubmittedTextAssignmentModel studentCAttignment =
        SubmittedTextAssignmentModel();
    try {
      String studentClass =
          '${SharedServiceParentChildren.childDetails()?.data?.data?.dataClass}';
      String section =
          '${SharedServiceParentChildren.childDetails()?.data?.data?.section}';
      var queryParam =
          "${ApiUrl.studentPendingAssignment}/${SharedServiceParentChildren.childDetails()?.data?.data?.id.toString()}/$type-$form?institutionId=${SharedServiceParentChildren.childDetails()?.data?.data?.institutionId}&schoolId=${SharedServiceParentChildren.childDetails()?.data?.data?.schoolId}&class=$studentClass&section=$section";
      var response = await ApiBase.getRequest(
        token: SharedServiceParentChildren.childDetails()?.data?.token,
        extendedURL: queryParam,
      );
      log("this is type -------------------------------------->" + type);
      log("this is type -------------------------------------->" + form);
      log(form);
      // log(response.statusCode.toString());
      // log("RollNumber : ${rollNumber.toString()}");
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          // log("success");
          studentCAttignment =
              submittedTextAssignmentModelFromJson(response.body);
          // log(studentCAttignment.data![0].textAssignmentList![0]["question"]
          //     .toString());
        } else {
          log("else 2");
          studentCAttignment = SubmittedTextAssignmentModel();
        }
      } else {
        log("else 2");
        studentCAttignment = SubmittedTextAssignmentModel();
      }
    } catch (e) {
      log(e.toString());
      studentCAttignment = SubmittedTextAssignmentModel();
    }

    return studentCAttignment;
  }

//.............Student Upload assignment..........................................

  static Future<bool> StudentUploadAssignmentFile(
    // String wclass,
    // String section,
    // String subject,
    // String date,
    // String rollNumber,
    File file,
    String assignMentID,
  ) async {
    var ret = false;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "http://${ApiUrl.baseUrl}${ApiUrl.studentUploadAssignment}/${SharedServiceParentChildren.loginDetails()?.data!.id}/uploadAssignmets/$assignMentID",
        ),
      );
      log("http://${ApiUrl.baseUrl}${ApiUrl.studentUploadAssignment}/${SharedServiceParentChildren.loginDetails()?.data!.id}/uploadAssignmets/$assignMentID");

      // Add headers here
      Map<String, String> headers = {
        'Authorization':
            "${SharedServiceParentChildren.loginDetails()?.data!.token}", // Replace with your token
      };

      request.headers.addAll(headers);

      // request.fields['date'] = date;
      // request.fields['class'] = wclass;
      // request.fields['section'] = section;
      // request.fields['subject'] = subject;
      // request.fields['rollNumber'] = rollNumber;

      // log("date= $date");
      // log("class=$wclass");
      // log("section=$section");
      // log("subject=$subject");
      // log("rollNumber=$rollNumber");

      var fileStream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'file',
        fileStream.cast(),
        length,
        filename: p.basename(file.path),
      );
      request.files.add(multipartFile);

      var response = await http.Response.fromStream(await request.send());

      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          var studentUploadAssign =
              studentUploadAssignmentModelFromJson(response.body);
          ret = true;
        } else {
          log(response.statusCode.toString());
          ret = false;
          log("not successful");
        }
      } else {
        log(response.statusCode.toString());
        ret = false;
        log("not successful");
      }
    } catch (e) {
      ret = false;
      log("$e : not successful catch");
    }

    return ret;
  }

//.............Student Upload assignment..........................................

  static Future<bool> studentUploadAssignmentText(
      String assignMentID, answers) async {
    var ret = false;

    // log("This is the data that is inside the function $answers");
    // log(assignMentID);
    // log({"textAssignmentList": answers}.toString());
    try {
      var queryParam =
          "/student/${SharedServiceParentChildren.loginDetails()?.data?.id}/uploadAssignmets/$assignMentID";
      var response = await ApiBase.postRequest(
        body: {"textAssignmentList": jsonDecode(answers)},
        extendedURL: queryParam,
      );
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          var recivedStudentTextAssignmentModel =
              recivedStudentTextAssignmentModelToJson(response.body);
          ret = true;
        } else {
          log(response.statusCode.toString());
          ret = false;
          log("not successful");
        }
      }
    } catch (e) {
      ret = false;
      log("$e : not successful catch");
    }
    return ret;
  }

// Teacher See assignment.................................................
  static Future<StudentFeesDetailsModel> teacherSeeAssign() async {
    StudentFeesDetailsModel viewAssignment = StudentFeesDetailsModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL: ApiUrl.studentFeeDetails,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          viewAssignment = studentFeesDetailsModelFromJson(response.body);
        } else {
          viewAssignment = StudentFeesDetailsModel();
        }
      } else {
        viewAssignment = StudentFeesDetailsModel();
      }
    } catch (e) {
      viewAssignment = StudentFeesDetailsModel();
    }

    return viewAssignment;
  }

//...................  Fees View........................................

  static Future<StudentFeesDetailsModel> viewFees() async {
    StudentFeesDetailsModel feeDetails = StudentFeesDetailsModel();
    try {
      var response = SharedServiceParentChildren.type() == "parent"
          ? await ApiBase.getRequest(
              token: SharedServiceParentChildren.childDetails()?.data?.token,
              extendedURL:
                  "/student/${SharedServiceParentChildren.childDetails()?.data?.data?.id}${ApiUrl.studentFeeDetails}",
            )
          : await ApiBase.getRequest(
              extendedURL:
                  "/student/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.studentFeeDetails}",
            );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          feeDetails = studentFeesDetailsModelFromJson(response.body);
        } else {
          feeDetails = StudentFeesDetailsModel();
        }
      } else {
        feeDetails = StudentFeesDetailsModel();
      }
    } catch (e) {
      feeDetails = StudentFeesDetailsModel();
    }

    return feeDetails;
  }



// //to raise a payment request
//   static Future<bool> feesPaidRequestRaise(int amount) async {
//     var response = await ApiBase.postRequest(
//         extendedURL:
//             "/parent/${SharedServiceParentChildren.loginDetails()?.data?.id}/raised-feeRequest",
//         body: {
//           "studentId":
//               SharedServiceParentChildren.childDetails()?.data?.data?.id,
//           "amount": amount
//         });
//     log(response.body);
//     if (response.statusCode == 200) {
//       log(response.body);
//       return true;
//     } else {
//       return false;
//     }
//   }
//....................... Teacher see submitted students assignments ...........

  // static Future<TeacherSeeSubmittedStudentsAssignments>
  //     TeacherSeeSubittedStudents(
  //   String assignmentID,
  //   String wclass,
  //   String section,
  // ) async {
  //   TeacherSeeSubmittedStudentsAssignments submittedStudents =
  //       TeacherSeeSubmittedStudentsAssignments();
  //   try {
  //     var queryParam =
  //         "${ApiUrl.teacherSeeSubmittedStudentsAssignments}/${SharedServiceParentChildren.loginDetails()?.data!.id.toString()}/getAssignments/${assignmentID}?class=$wclass&section=$section";
  //     var response = await ApiBase.getRequest(
  //       extendedURL: queryParam,
  //     );

  //     log(response.body.toString());
  //     if (response.statusCode == 200) {
  //       if (jsonDecode(response.body)['status'] == true) {
  //         log("success");
  //         submittedStudents =
  //             teacherSeeSubmittedStudentsAssignmentsFromJson(response.body);
  //       } else {
  //         log("else 2");
  //         submittedStudents = TeacherSeeSubmittedStudentsAssignments();
  //       }
  //     } else {
  //       log("else 2");
  //       submittedStudents = TeacherSeeSubmittedStudentsAssignments();
  //     }
  //   } catch (e) {
  //     log("Catch");
  //     submittedStudents = TeacherSeeSubmittedStudentsAssignments();
  //   }

  //   return submittedStudents;
  // }
  // Attendance post...............................................

  static Future<bool> attendancePost() async {
    var ret = false;

    try {
      var response = await ApiBase.postRequest(
        extendedURL: ApiUrl.teacherAttendanceSubmit,
        body: {},
      );

      log(response.statusCode.toString());
      log("\n${response.body}");

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          var responseModel = attendanceSubmitModelFromJson(response.body);
          log(responseModel.message!);

          ret = true;
        } else {
          ret = false;
          log("not successful");
        }
      } else {
        ret = false;
        log("not successful ");
      }
    } catch (e) {
      ret = false;
      log("$e :  not successful catch");
    }

    return ret;
  }

// Gallery Teacher Upload ...................................................
  static Future<bool> teacherUploadGallery(
    List<XFile> files,
  ) async {
    var ret = false;

    try {
      String? schoolName =
          SharedServiceParentChildren.loginDetails()?.data!.data!.schoolName;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "http://${ApiUrl.baseUrl}${ApiUrl.uploadGallery}",
        ),
      );
      log(
        "http://${ApiUrl.baseUrl}${ApiUrl.uploadGallery}",
      );
      // Add headers here
      Map<String, String> headers = {
        'Authorization':
            "${SharedServiceParentChildren.loginDetails()?.data!.token}",
      };
      request.headers.addAll(headers);

      // Add your string to the request body
      request.fields['schoolName'] = schoolName!;

      for (var file in files) {
        var fileStream = http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile(
          'files[]', // Use 'files[]' to indicate it's an array of files
          fileStream.cast(),
          length,
          filename: p.basename(file.path),
        );
        request.files.add(multipartFile);
      }

      var response = await http.Response.fromStream(await request.send());

      log(response.statusCode.toString());
      // log(response.body);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          var teacherUploadGal = galleryUploadModelFromJson(response.body);
          ret = true;
        } else {
          log(response.statusCode.toString());
          log(response.body);
          ret = false;
          log("not successful");
        }
      } else {
        log(response.statusCode.toString());
        ret = false;
        log("not successful");
      }
    } catch (e) {
      ret = false;
      log("$e : not successful catch");
    }

    return ret;
  }

//............ View School Gallery Parents ............................................

  static Future<ViewGalleryResponseModel> parentsViewSchoolGallery() async {
    ViewGalleryResponseModel viewGalModel = ViewGalleryResponseModel();
    try {
      // fetchChildData();
      var response = await ApiBase.getRequest(
        token: SharedServiceParentChildren.childDetails()?.data?.token,
        extendedURL:
            "/student/${SharedServiceParentChildren.childDetails()?.data?.data?.id}${ApiUrl.viewSchoolGallery}?institutionId=${SharedServiceParentChildren.childDetails()?.data?.data?.institutionId}&schoolId=${SharedServiceParentChildren.childDetails()?.data?.data?.schoolId}",
      );
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          viewGalModel = viewGalleryResponseModelFromJson(response.body);
        } else {
          viewGalModel = ViewGalleryResponseModel();
        }
      } else {
        viewGalModel = ViewGalleryResponseModel();
      }
    } catch (e) {
      viewGalModel = ViewGalleryResponseModel();
    }

    return viewGalModel;
  }

//............ View School Gallery............................................

  static Future<ViewGalleryResponseModel> viewSchoolGallery() async {
    ViewGalleryResponseModel viewGalModel = ViewGalleryResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "/${SharedServiceParentChildren.loginDetails()?.data?.data?.role}/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.viewSchoolGallery}?institutionId=${SharedServiceParentChildren.loginDetails()?.data?.data?.institutionId}&schoolId=${SharedServiceParentChildren.loginDetails()?.data?.data?.schoolId}",
      );
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          viewGalModel = viewGalleryResponseModelFromJson(response.body);
        } else {
          viewGalModel = ViewGalleryResponseModel();
        }
      } else {
        viewGalModel = ViewGalleryResponseModel();
      }
    } catch (e) {
      viewGalModel = ViewGalleryResponseModel();
    }

    return viewGalModel;
  }

  //..... View events Parents ......................................................

  static Future<StudentsViewEventsResponseModel> parentViewSchoolEvents(
    String status,
  ) async {
    StudentsViewEventsResponseModel viewEvents =
        StudentsViewEventsResponseModel();
    try {
      // fetchChildData();
      var response = await ApiBase.getRequest(
        token: SharedServiceParentChildren.childDetails()?.data?.token,
        extendedURL:
            "/student/${SharedServiceParentChildren.childDetails()?.data?.data?.id}/getEventsByStatus?institutionId=${SharedServiceParentChildren.childDetails()?.data?.data?.institutionId}&schoolName=${SharedServiceParentChildren.childDetails()?.data?.data?.schoolName}&status=$status",
      );
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          viewEvents = studentsViewEventsResponseModelFromJson(response.body);
        } else {
          viewEvents = StudentsViewEventsResponseModel();
        }
      } else {
        viewEvents = StudentsViewEventsResponseModel();
      }
    } catch (e) {
      viewEvents = StudentsViewEventsResponseModel();
    }

    return viewEvents;
  }

  //..... View events Students ......................................................

  static Future<StudentsViewEventsResponseModel> viewSchoolEvents(
    String status,
  ) async {
    StudentsViewEventsResponseModel viewEvents =
        StudentsViewEventsResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "/student/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.viewSchoolEvents}?schoolName=${SharedServiceParentChildren.loginDetails()?.data!.data!.schoolName}&status=$status&institutionId=${SharedServiceParentChildren.loginDetails()?.data!.data!.institutionId}",
      );
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          viewEvents = studentsViewEventsResponseModelFromJson(response.body);
        } else {
          viewEvents = StudentsViewEventsResponseModel();
        }
      } else {
        viewEvents = StudentsViewEventsResponseModel();
      }
    } catch (e) {
      viewEvents = StudentsViewEventsResponseModel();
    }

    return viewEvents;
  }

// Students View Awards/certificates.....................................................

  static Future<StudentViewAwardsResponseModel>
      parentsViewChildCertificates() async {
    StudentViewAwardsResponseModel myCertificates =
        StudentViewAwardsResponseModel();
    try {
      // fetchChildData();
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.studentViewAwards}/${SharedServiceParentChildren.childDetails()?.data?.data?.id}",
      );
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          myCertificates =
              studentViewAwardsResponseModelFromJson(response.body);
        } else {
          myCertificates = StudentViewAwardsResponseModel();
        }
      } else {
        myCertificates = StudentViewAwardsResponseModel();
      }
    } catch (e) {
      myCertificates = StudentViewAwardsResponseModel();
    }

    return myCertificates;
  }

// Students View Awards/certificates.....................................................

  static Future<StudentViewAwardsResponseModel>
      viewMyCertificatesParentStudent() async {
    StudentViewAwardsResponseModel myCertificates =
        StudentViewAwardsResponseModel();
    try {
      var response = SharedServiceParentChildren.loginDetails()
                  ?.data
                  ?.data
                  ?.role ==
              "parent"
          ? await ApiBase.getRequest(
              token: SharedServiceParentChildren.childDetails()?.data?.token,
              extendedURL:
                  "/student/${SharedServiceParentChildren.childDetails()?.data?.data?.id}/getAllAwards",
            )
          : await ApiBase.getRequest(
              extendedURL:
                  "/student/${SharedServiceParentChildren.loginDetails()?.data!.id}/getAllAwards",
            );
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          myCertificates =
              studentViewAwardsResponseModelFromJson(response.body);
        } else {
          myCertificates = StudentViewAwardsResponseModel();
        }
      } else {
        myCertificates = StudentViewAwardsResponseModel();
      }
    } catch (e) {
      myCertificates = StudentViewAwardsResponseModel();
    }

    return myCertificates;
  }

  // Teacher Upload Awards.........................................

  static Future<bool> teacherUploadAwards(
    String studentName,
    String wclass,
    String section,
    String rollNumber,
    String certificationHeading,
    String date,
    File file,
    BuildContext context,
  ) async {
    var ret = false;

    try {
      var schoolName =
          SharedServiceParentChildren.loginDetails()?.data!.data!.schoolName;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "http://${ApiUrl.baseUrl}${ApiUrl.teacherUploadAwards}",
        ),
      );

      // Add headers here
      Map<String, String> headers = {
        'Authorization':
            "${SharedServiceParentChildren.loginDetails()?.data!.token}", // Replace with your token
      };
      request.headers.addAll(headers);

      request.fields['certificationDate'] = date;
      request.fields['class'] = wclass;
      request.fields['section'] = section;
      request.fields['studentName'] = studentName;
      request.fields['rollNumber'] = rollNumber;
      request.fields['certificationHeading'] = certificationHeading;
      request.fields['schoolName'] = schoolName!;

      log("http://${ApiUrl.baseUrl}${ApiUrl.teacherUploadAwards}");
      log("date= $date");
      log("class=$wclass");
      log("section=$section");
      log("Name=$studentName");
      log("rollNumber=$rollNumber");
      log("SchoolName=$schoolName");

      var fileStream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'file',
        fileStream.cast(),
        length,
        filename: p.basename(file.path),
      );
      request.files.add(multipartFile);

      var response = await http.Response.fromStream(await request.send());

      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          // var studentUploadAssign =
          //     studentUploadAssignmentModelFromJson(response.body);
          ret = true;
        } else {
          log(response.statusCode.toString());
          ret = false;
          log("not successful else");
        }
      } else {
        log(response.statusCode.toString());
        ret = false;
        log("not successful else 2");
      }
    } catch (e) {
      ret = false;
      log("$e : not successful catch");
    }

    return ret;
  }

// Update my account details Student..................................................

  static Future<bool> updateMyAccountParentStudent(
    String password,
  ) async {
    var ret = false;

    try {
      var response = SharedServiceParentChildren.type() == "parent"
          ? await ApiBase.putRequest(
              extendedURL:
                  "/${SharedServiceParentChildren.type()}/${SharedServiceParentChildren.loginDetails()?.data!.id}/updateParent",
              body: {
                "password": password,
              },
            )
          : await ApiBase.putRequest(
              extendedURL:
                  "/${SharedServiceParentChildren.type()}/${SharedServiceParentChildren.loginDetails()?.data!.id}/updateStudentById",
              body: {
                "password": password,
              },
            );

      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          ret = true;
          ret = true;
        } else {
          ret = false;
          log("Not Successful");
        }
      } else {
        ret = false;
        log("Not Successful");
      }
    } catch (e) {
      log("error: $e");
    }
    return ret;
  }


//.... Update my account details Teacher....................................

  static Future<bool> updateMyAccountTeacher(

    String name,
    String email,
    String phone,
    String password,
    String city,
  ) async {
    var ret = false;

    try {
      var response = await ApiBase.putRequest(
        extendedURL:

            "${ApiUrl.updateMytAccountTeacher}/${SharedServiceParentChildren.loginDetails()?.data!.id}",

        body: {
          "name": name,
          "email": email,
          "phoneNumber": phone,
          "password": password,
          "address": city,
        },
      );

      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          ret = true;
        } else {
          ret = false;
          log("Not Successful");
        }
      } else {
        ret = false;
        log("Not Successful");
      }
    } catch (e) {
      log("error: $e");
    }
    return ret;
  }

// Student enroll for event ( Eligibility verify)............................

  static Future<StudentEnrollEventEligibilityResponseModel>
      studentEligibilityCheckForEnrollEvents(
    String eventID,
  ) async {
    StudentEnrollEventEligibilityResponseModel eligibleCheck =
        StudentEnrollEventEligibilityResponseModel();

    try {
      var stId = SharedServiceParentChildren.loginDetails()?.data!.id;
      var response = await ApiBase.getRequest(
        extendedURL:
            "/student/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.studentEligibilityCheckForEnrollEvents}/$eventID",
      );
      log(response.statusCode.toString());
      log("Event ID= $eventID");
      log("Student ID= ${stId.toString()}");
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          eligibleCheck =
              studentEnrollEventEligibilityResponseModelFromJson(response.body);
        } else {
          eligibleCheck = StudentEnrollEventEligibilityResponseModel();
        }
      } else {
        eligibleCheck = StudentEnrollEventEligibilityResponseModel();
      }
    } catch (e) {
      eligibleCheck = StudentEnrollEventEligibilityResponseModel();
    }

    return eligibleCheck;
  }

  //...Student Register for events POST api...................................
  static Future<bool> studentRegisterEvent(
    String name,
    String wclass,
    String section,
    String rollNumber,
    String email,
    String phone,
    String eventName,
    String gender,
    String eventID,
  ) async {
    var ret = false;

    try {
      var studentID = SharedServiceParentChildren.loginDetails()?.data!.id;
      var response = await ApiBase.postRequest(
        extendedURL:
            "/student/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.studentRegisterEventPost}/$eventID",
        body: {
          "studentName": name,
          "class": wclass,
          "section": section,
          "rollNumber": rollNumber,
          "email": email,
          "phoneNumber": phone,
          "eventName": eventName,
          "gender": gender,
          "studentId": studentID,
          "eventId": eventID,
        },
      );
      log(name);
      log(wclass);
      log(section);
      log(rollNumber);
      log(email);
      log(phone);
      log(eventID);
      log(studentID.toString());

      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          ret = true;
        } else {
          ret = false;
          log("Not Successful");
        }
      } else {
        ret = false;
        log("Not Successful");
      }
    } catch (e) {
      log("error: $e");
    }
    return ret;
  }

  // Notice Student View Get.................................................
  //.... View awards class wise Students List ( Teacher view)...................

  static Future<ClassWiseAwardsListOfStudentsResponseModel>
      classWiseAwardsListOfStudents(
          String selectedClass, String selectedSection) async {
    ClassWiseAwardsListOfStudentsResponseModel classWiseStudentsAwards =
        ClassWiseAwardsListOfStudentsResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.classWiseAwardsListOfStudents}?schoolName=${SharedServiceParentChildren.loginDetails()?.data!.data!.schoolName}&class=${selectedClass}&section=${selectedSection}",
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          classWiseStudentsAwards =
              classWiseAwardsListOfStudentsResponseModelFromJson(response.body);
        } else {
          classWiseStudentsAwards =
              ClassWiseAwardsListOfStudentsResponseModel();
        }
      } else {
        classWiseStudentsAwards = ClassWiseAwardsListOfStudentsResponseModel();
      }
    } catch (e) {
      classWiseStudentsAwards = ClassWiseAwardsListOfStudentsResponseModel();
    }

    return classWiseStudentsAwards;
  }

  // Notice Student  and parent View Get.................................................

  static Future<ViewNoticeResponseModel> viewNoticeStudents() async {
    ViewNoticeResponseModel viewNotice = ViewNoticeResponseModel();
    try {
      var response =
          SharedServiceParentChildren.loginDetails()?.data?.data?.role ==
                  "parent"
              ? await ApiBase.getRequest(
                  extendedURL:
                      "/parent/${SharedServiceParentChildren.loginDetails()?.data!.id}${ApiUrl.viewNoticeParent}/?institutionId=${SharedServiceParentChildren.childDetails()?.data?.data?.institutionId}&schoolId=${SharedServiceParentChildren.childDetails()?.data?.data?.schoolId}",
                )
              : await ApiBase.getRequest(
                  extendedURL:
                      "/student/${SharedServiceParentChildren.loginDetails()?.data!.id}${ApiUrl.viewNoticeStudents}",
                );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          viewNotice = viewNoticeResponseModelFromJson(response.body);
        } else {
          viewNotice = ViewNoticeResponseModel();
        }
      } else {
        viewNotice = ViewNoticeResponseModel();
      }
    } catch (e) {
      viewNotice = ViewNoticeResponseModel();
    }

    return viewNotice;
  }

  // Verify read Unread notices Students and parent...............................................

  static Future<bool> verifyReadUnreadNoticeParentStudent(
      String noticeID) async {
    var ret = false;
    try {
      var response =
          SharedServiceParentChildren.loginDetails()?.data?.data?.role ==
                  "parent"
              ? await ApiBase.putRequest(
                  extendedURL:
                      "/parent/${SharedServiceParentChildren.loginDetails()!.data!.id}${ApiUrl.verifyReadUnreadNoticeForParent}",
                  body: {
                    "noticeId": noticeID,
                    "read": "true",
                    "institutionId": SharedServiceParentChildren.childDetails()
                        ?.data
                        ?.data
                        ?.institutionId,
                    "schoolId": SharedServiceParentChildren.childDetails()
                        ?.data
                        ?.data
                        ?.schoolId
                  },
                )
              : await ApiBase.putRequest(
                  extendedURL:
                      "/student/${SharedServiceParentChildren.loginDetails()!.data!.id}${ApiUrl.verifyReadUnreadNoticeStudent}?institutionId=${SharedServiceParentChildren.loginDetails()?.data?.data?.institutionId}&schoolId=${SharedServiceParentChildren.loginDetails()?.data?.data?.schoolId}",
                  body: {
                    "schoolName": SharedServiceParentChildren.loginDetails()!
                        .data!
                        .data!
                        .schoolName,
                    "read": "true",
                    "studentId":
                        SharedServiceParentChildren.loginDetails()!.data!.id,
                    "noticeId": noticeID,
                  },
                );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          ret = true;
        } else {
          ret = false;
          log("Not Successful");
        }
      } else {
        ret = false;
        log("Not Successful");
      }
    } catch (e) {
      log("error: $e");
    }
    return ret;
  }

  // View notice teacher......................................................

  static Future<ViewNoticeResponseModel> viewNoticeParent() async {
    ViewNoticeResponseModel viewNotice = ViewNoticeResponseModel();
    try {
      // fetchChildData();
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.viewNotice}/${SharedServiceParentChildren.loginDetails()?.data?.id}?schoolName=${SharedServiceParentChildren.childDetails()?.data?.data!.schoolName}",
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          viewNotice = viewNoticeResponseModelFromJson(response.body);
        } else {
          viewNotice = ViewNoticeResponseModel();
        }
      } else {
        viewNotice = ViewNoticeResponseModel();
      }
    } catch (e) {
      viewNotice = ViewNoticeResponseModel();
    }

    return viewNotice;
  }

  // Verify read Unread notices Teacher...............................................

  static Future<bool> verifyReadUnreadNoticeTeacher(String noticeID) async {
    var ret = false;
    try {
      var response = await ApiBase.putRequest(
        extendedURL:
            "${ApiUrl.verifyReadUnreadNoticeTeacher}/${SharedServiceParentChildren.loginDetails()!.data!.data?.id.toString()}",
        body: {
          "schoolName": SharedServiceParentChildren.loginDetails()!
              .data!
              .data!
              .schoolName,
          "read": "true",
          "noticeId": noticeID,
        },
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          ret = true;
        } else {
          ret = false;
          log("Not Successful");
        }
      } else {
        ret = false;
        log("Not Successful");
      }
    } catch (e) {
      log("error: $e");
    }
    return ret;
  }

  // static Future<TeacherNoticeResponseModel> viewNoticeTeacher() async {
  //   TeacherNoticeResponseModel viewNotice = TeacherNoticeResponseModel();
  //   try {
  //     var response = await ApiBase.getRequest(
  //       extendedURL:
  //           "${ApiUrl.viewNoticeTeacher}/${SharedServiceParentChildren.loginDetails()?.data!.id}?schoolName=${SharedServiceParentChildren.loginDetails()?.data!.data!.schoolName}",
  //     );
  //     log(response.statusCode.toString());
  //     log(response.body.toString());
  //     if (response.statusCode == 200) {
  //       if (jsonDecode(response.body)['status'] == true) {
  //         viewNotice = teacherNoticeResponseModelFromJson(response.body);
  //       } else {
  //         viewNotice = TeacherNoticeResponseModel();
  //       }
  //     } else {
  //       viewNotice = TeacherNoticeResponseModel();
  //     }
  //   } catch (e) {
  //     viewNotice = TeacherNoticeResponseModel();
  //   }

  //   return viewNotice;
  // }

  static Future<bool> verifyReadUnreadNoticeParent(String noticeID) async {
    var ret = false;
    try {
      var response = await ApiBase.putRequest(
        extendedURL:
            "${ApiUrl.verifyReadUnreadNoticeForParent}/${SharedServiceParentChildren.loginDetails()?.data!.data?.id}",
        body: {
          "schoolName": SharedServiceParentChildren.childDetails()
              ?.data
              ?.data
              ?.schoolName,
          "read": "true",
          "parentId": SharedServiceParentChildren.loginDetails()?.data?.id,
          "noticeId": noticeID,
        },
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          ret = true;
        } else {
          ret = false;
          log("Not Successful");
        }
      } else {
        ret = false;
        log("Not Successful");
      }
    } catch (e) {
      log("error: $e");
    }
    return ret;
  }

//Delete Notice Teacher .......................................................
  static Future<bool> deleteNoticeTeacher(
    String noticeID,
  ) async {
    var ret = false;
    try {
      var response = await ApiBase.deleteRequest(
        extendedURL:
            "${ApiUrl.deleteNoticeTeacher}/${SharedServiceParentChildren.loginDetails()!.data!.id}",
        body: {
          "noticeId": noticeID,
        },
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          ret = true;
        } else {
          ret = false;
          log("Not Successful 1");
        }
      } else {
        ret = false;
        log("Not Successful 2");
      }
    } catch (e) {
      log("error: $e");
    }
    return ret;
  }

// Teacher see registered students of partticular events.......................

  static Future<EventRegisteredStudentListResponseModel>
      getRegisteredStudentListEvents(String eventID) async {
    EventRegisteredStudentListResponseModel viewStudentList =
        EventRegisteredStudentListResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "/teacher/${SharedServiceParentChildren.loginDetails()!.data!.id}${ApiUrl.getRegisteredStudentListEvents}/$eventID",
      );
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          viewStudentList =
              eventRegisteredStudentListResponseModelFromJson(response.body);
        } else {
          viewStudentList = EventRegisteredStudentListResponseModel();
        }
      } else {
        viewStudentList = EventRegisteredStudentListResponseModel();
      }
    } catch (e) {
      viewStudentList = EventRegisteredStudentListResponseModel();
    }

    return viewStudentList;
  }

//.........Students see my enrolled events GET api.........................

  ///enrolled events for parent

  static Future<StudentMyEnrolledEventsResponseModel>
      parentSeeMyEnrolledEvents() async {
    StudentMyEnrolledEventsResponseModel myEnrolledEventsList =
        StudentMyEnrolledEventsResponseModel();
    try {
      var studentID =
          SharedServiceParentChildren.childDetails()?.data?.data?.id;
      var response = await ApiBase.getRequest(
        token: SharedServiceParentChildren.childDetails()?.data?.token,
        extendedURL: "/student/$studentID${ApiUrl.studentSeeMyEnrolledEvents}",
      );
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          myEnrolledEventsList =
              studentMyEnrolledEventsResponseModelFromJson(response.body);
        } else {
          myEnrolledEventsList = StudentMyEnrolledEventsResponseModel();
        }
      } else {
        myEnrolledEventsList = StudentMyEnrolledEventsResponseModel();
      }
    } catch (e) {
      myEnrolledEventsList = StudentMyEnrolledEventsResponseModel();
    }

    return myEnrolledEventsList;
  }

/////////////////////////////////////////////////

  static Future<StudentMyEnrolledEventsResponseModel>
      studentSeeMyEnrolledEvents() async {
    StudentMyEnrolledEventsResponseModel myEnrolledEventsList =
        StudentMyEnrolledEventsResponseModel();
    try {
      var studentID = SharedServiceParentChildren.loginDetails()?.data!.id;
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.studentSeeMyEnrolledEvents}?studentId=$studentID",
      );
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          myEnrolledEventsList =
              studentMyEnrolledEventsResponseModelFromJson(response.body);
        } else {
          myEnrolledEventsList = StudentMyEnrolledEventsResponseModel();
        }
      } else {
        myEnrolledEventsList = StudentMyEnrolledEventsResponseModel();
      }
    } catch (e) {
      myEnrolledEventsList = StudentMyEnrolledEventsResponseModel();
    }

    return myEnrolledEventsList;
  }

  // Student see own result GET api.................................................
// Teacher Upload Notice........................................................

  static Future<bool> teacherUploadNotice(
    String noticeNeading,
    String noticeDescription,
    String noticeDate,
    File file,
    BuildContext context,
  ) async {
    var ret = false;

    try {
      var schoolName =
          SharedServiceParentChildren.loginDetails()?.data!.data!.schoolName;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "http://${ApiUrl.baseUrl}${ApiUrl.teacherUploadNotice}",
        ),
      );

      // Add headers here
      Map<String, String> headers = {
        'Authorization':
            "${SharedServiceParentChildren.loginDetails()?.data!.token}",
      };
      request.headers.addAll(headers);

      request.fields['heading'] = noticeNeading;
      request.fields['description'] = noticeDescription;
      request.fields['date'] = noticeDate;
      request.fields['schoolName'] = schoolName!;

      log("http://${ApiUrl.baseUrl}${ApiUrl.teacherUploadAwards}");

      log("SchoolName=$schoolName");

      var fileStream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'file',
        fileStream.cast(),
        length,
        filename: p.basename(file.path),
      );
      request.files.add(multipartFile);

      var response = await http.Response.fromStream(await request.send());

      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          ret = true;
        } else {
          log(response.statusCode.toString());
          ret = false;
          log("not successful else");
        }
      } else {
        log(response.statusCode.toString());
        ret = false;
        log("not successful else 2");
      }
    } catch (e) {
      ret = false;
      log("$e : not successful catch");
    }

    return ret;
  }

  // Student and parent see own result GET api.................................................

  static Future<StudentResultResponseModel> studentParentSeeResult(
      String userType, String testType) async {
    StudentResultResponseModel result = StudentResultResponseModel();
    try {
      var response = userType == "parent"
          ? await ApiBase.getRequest(
              token: SharedServiceParentChildren.childDetails()?.data?.token,
              extendedURL:
                  "/student/${SharedServiceParentChildren.childDetails()?.data?.data?.id}/studentSeeTheirResult?examType=$testType",
            )
          : await ApiBase.getRequest(
              extendedURL:
                  // "${ApiUrl.studentSeeResult}/${SharedServiceParentChildren.loginDetails()!.data!.id}?examType=$testType&schoolName=${SharedServiceParentChildren.loginDetails()!.data!.data!.school}",
                  "/${SharedServiceParentChildren.loginDetails()!.data?.data?.role}/${SharedServiceParentChildren.loginDetails()?.data?.id}/studentSeeTheirResult?examType=$testType",
            );
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          result = studentResultResponseModelFromJson(response.body);
        } else {
          result = StudentResultResponseModel();
        }
      } else {
        result = StudentResultResponseModel();
      }
    } catch (e) {
      result = StudentResultResponseModel();
    }

    return result;
  }

//......................Teacher Post Result...................................

  static Future<bool> uploadResultSpecificStudent(
      Map<String, dynamic> resultData) async {
    var ret = false;
    try {
      var response = await ApiBase.postRequest(
        extendedURL: ApiUrl.uploadResult,
        body: resultData,
      );

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          ret = true;
        } else {
          ret = false;
          log("not successful");
        }
      } else {
        ret = false;
        log("not successful ");
      }
    } catch (e) {
      ret = false;
      log("$e :  not successful catch");
    }

    return ret;
  }

// Delete result by teacher...................................................

  static Future<void> deleteResult(String resultId) async {
    final response = await http.delete(
      Uri.parse("http://13.232.53.26:3000/deleteResultOfStudent/$resultId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // Add any additional headers as needed
      },
    );

    if (response.statusCode == 200) {
      log('Deleted successfully');
    } else {
      log('Failed to delete data. Status code: ${response.statusCode}');
      log('Response body: ${response.body}');
      // Handle the error as needed
    }
  }

// student view and parent view the exam routine
  static Future<ExamRoutineResponseModel> viewExamRoutineParentStudent(
      String userType, String testType) async {
    ExamRoutineResponseModel examRoutine = ExamRoutineResponseModel();
    try {
      // var school = SharedServiceParentChildren.loginDetails()!.data!.data!.school;

      var response = userType == "parent"
          ? await ApiBase.getRequest(
              token: SharedServiceParentChildren.childDetails()?.data?.token,
              extendedURL:
                  "/student/${SharedServiceParentChildren.childDetails()?.data?.data?.id}/getExamination?examType=$testType",
            )
          : await ApiBase.getRequest(
              extendedURL:
                  "/student/${SharedServiceParentChildren.loginDetails()?.data?.data?.id}/getExamination?examType=$testType",
            );
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          examRoutine = examRoutineResponseModelFromJson(response.body);
        } else {
          examRoutine = ExamRoutineResponseModel();
        }
      } else {
        examRoutine = ExamRoutineResponseModel();
      }
    } catch (e) {
      examRoutine = ExamRoutineResponseModel();
    }

    return examRoutine;
  }

// View Exam routine (GET API)..................................................

  static Future<ExamRoutineResponseModel> viewExamRoutine(
      String selectedClass, String testType, String selectedSection) async {
    var institutionId =
        SharedServiceParentChildren.loginDetails()!.data!.data!.institutionId;
    var schoolId =
        SharedServiceParentChildren.loginDetails()!.data!.data!.schoolId;
    var school =
        SharedServiceParentChildren.loginDetails()!.data!.data!.schoolName;
    var id = SharedServiceParentChildren.loginDetails()!.data!.data!.id;
    ExamRoutineResponseModel examRoutine = ExamRoutineResponseModel();
    try {
      var schoolName =
          SharedServiceParentChildren.loginDetails()!.data!.data!.schoolName;
      var schoolID =
          SharedServiceParentChildren.loginDetails()!.data!.data!.schoolId;
      var institutionId =
          SharedServiceParentChildren.loginDetails()!.data!.data!.institutionId;
      var id = SharedServiceParentChildren.loginDetails()?.data?.data?.id;
      var response = await ApiBase.getRequest(
          extendedURL:
              "/teacher/$id${ApiUrl.viewExamRoutine}?schoolName=$schoolName&examType=$testType&institutionId=$institutionId&schoolId=$schoolID&class=$selectedClass&section=$selectedSection");
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          examRoutine = examRoutineResponseModelFromJson(response.body);
        } else {
          examRoutine = ExamRoutineResponseModel();
        }
      } else {
        examRoutine = ExamRoutineResponseModel();
      }
    } catch (e) {
      examRoutine = ExamRoutineResponseModel();
    }

    return examRoutine;
  }

// Teacher Upload exam routine (POST API)................................................

  static Future<bool> uploadExamRoutine(Map<String, dynamic> examData) async {
    var ret = false;

    var id = SharedServiceParentChildren.loginDetails()!.data!.data!.id;

    try {
      var response = await ApiBase.postRequest(
        extendedURL: "/teacher/$id${ApiUrl.uploadExamRoutine}",
        body: examData,
      );

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          ret = true;
        } else {
          ret = false;
          log("not successful");
        }
      } else {
        ret = false;
        log("not successful ");
      }
    } catch (e) {
      ret = false;
      log("$e :  not successful catch");
    }

    return ret;
  }

//.... Teacher Delete Exam Routine..............................................

  static Future<void> deleteExamRoutine(String examId) async {
    final response = await http.delete(
      Uri.parse("http://${ApiUrl.baseUrl}${ApiUrl.deleteExam}/$examId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // Add any additional headers as needed
      },
    );

    if (response.statusCode == 200) {
      log('Deleted successfully');
    } else {
      log('Failed to delete data. Status code: ${response.statusCode}');
      log('Response body: ${response.body}');
      // Handle the error as needed
    }
  }

  // View About School.........................................................

//parent
  static Future<AboutSchoolResponseModel> ViewAboutSchoolParent() async {
    AboutSchoolResponseModel about = AboutSchoolResponseModel();

    try {
      // fetchChildData();
      var school =
          SharedServiceParentChildren.childDetails()!.data!.data?.schoolName;
      var response = await ApiBase.getRequest(
        token: SharedServiceParentChildren.childDetails()?.data?.token,
        extendedURL:
            "/student/${SharedServiceParentChildren.childDetails()?.data?.data?.id}${ApiUrl.viewAboutSchool}/?schoolName=$school&institutionId=${SharedServiceParentChildren.childDetails()?.data?.data?.institutionId}",
      );
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          about = aboutSchoolResponseModelFromJson(response.body);
        } else {
          about = AboutSchoolResponseModel();
        }
      } else {
        about = AboutSchoolResponseModel();
      }
    } catch (e) {
      about = AboutSchoolResponseModel();
    }

    return about;
  }

  static Future<AboutSchoolResponseModel> ViewAboutSchool() async {
    AboutSchoolResponseModel about = AboutSchoolResponseModel();
    try {
      var school =
          SharedServiceParentChildren.loginDetails()!.data!.data!.schoolName;
      var response = await ApiBase.getRequest(
        extendedURL:
            "/${SharedServiceParentChildren.loginDetails()?.data?.data?.role}/${SharedServiceParentChildren.loginDetails()?.data?.id}${ApiUrl.viewAboutSchool}/?schoolName=$school&institutionId=${SharedServiceParentChildren.loginDetails()?.data?.data?.institutionId}",
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          about = aboutSchoolResponseModelFromJson(response.body);
        } else {
          about = AboutSchoolResponseModel();
        }
      } else {
        about = AboutSchoolResponseModel();
      }
    } catch (e) {
      about = AboutSchoolResponseModel();
    }

    return about;
  }
}

