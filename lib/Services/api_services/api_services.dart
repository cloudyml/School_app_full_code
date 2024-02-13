import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/Models/Teacher/Attendance/view_attendance_of_class_response_model.dart';
import 'package:school_management_system/Models/Teacher/Homework/Upload/assignment_upload_model.dart';
import 'package:school_management_system/Models/Teacher/Notice/teacher_view_notice_response_model.dart';
import 'package:school_management_system/Models/fetched_children_model.dart';
import 'package:school_management_system/Services/shared_services.dart';
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
import '../../Models/Teacher/Attendance/attendance_submit_model.dart';
import '../../Models/Teacher/Awards/class_wise_awards_list_response_model.dart';
import '../../Models/Teacher/Events/event_registered_student_list_model.dart';
import '../../Models/Teacher/Events/upload_events_post_api_model.dart';
import '../../Models/Teacher/Fees/delete_fees_model.dart';
import '../../Models/Teacher/Fees/update_fees_model.dart';
import '../../Models/Teacher/Fees/upload_fees_model.dart';
import '../../Models/Student/Student_Upload_Assignment.dart';
import '../../Models/Student/assignment_view_model.dart';
import '../../Models/Student/month_attendance_student_response_model.dart';
import '../../Models/Student/submitted_assignment_model.dart';
import '../../Models/Teacher/Gallery/upload_gallery.dart';
import '../../Models/Teacher/Result/Get models/class_wise_result_response_model.dart';
import '../../Models/Teacher/assignment_submitted_students_model.dart';
import '../../Models/Teacher/Homework/view file homework/teacher_see_own_assignments_list_response_model.dart';
import '../../Models/Teacher/Attendance/Original_Model/attendance_response_model.dart';
import '../../Models/Student/day_Routine_response_medel.dart';
import '../../Models/login_response_model.dart';
import '../../Models/Student/week_attendance_student_model.dart';
import '../../constants/constants.dart';
import '../api_urls.dart';
import '../base_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class ApiServices {
// ....... Login  ..................................................
  static Future<bool> userLogin(
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

      log(response.statusCode.toString());
      log(selectedrole.toString());
      log("\n${response.body}");

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          var responseModel = loginResponseModelFromJson(response.body);
          Future.delayed(
            const Duration(seconds: 2),
            () {
              fetchChildData();
            },
          );

          log(responseModel.message!);

          ret = true;
          SharedService.setLoginDetails(responseModel);
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
          SharedService.setDetailsOfFetchedChild(responseModel);
          log("  this is the data in the child detils shared pref ${SharedService.childDetails()?.data?.address.toString()}");

          var harsh = SharedService.childDetails();
          log("  this is the data fetched from shared pref ${harsh?.data?.address} ");
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
            "${ApiUrl.studentListForTakeAttendance}?class=$selectedClass&section=$selectedSection",
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
        extendedURL: ApiUrl.teacherSubmitAttendance,
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
            "teacher/${SharedService.loginDetails()!.data!.id.toString()}${ApiUrl.teacherSeeAttendanceOfWholeClassOfAday}?class=$selectedClass&section=$selectedSection&date=$selectedDate",
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
      String studentClass = '${SharedService.childDetails()?.data?.dataClass}';
      String section = '${SharedService.childDetails()?.data?.section}';
      String rollNumber = ' ${SharedService.childDetails()?.data?.rollNumber}';
      String date = formattedDate;

      var queryParam =
          "/${SharedService.loginDetails()?.data?.data?.role}/${SharedService.loginDetails()?.data?.id}${ApiUrl.weekStudentAttendance}?class=$studentClass&section=$section&rollNumber=$rollNumber&date=$date";
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

  static Future<StudentWeeklyAttendanceModel> StudentWeekAttendance() async {
    StudentWeeklyAttendanceModel WeeklyAttendance =
        StudentWeeklyAttendanceModel();
    try {
      var currentDate = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
      String studentClass =
          '${SharedService.loginDetails()?.data!.data!.dataClass}';
      String section = '${SharedService.loginDetails()?.data!.data!.section}';
      String rollNumber =
          ' ${SharedService.loginDetails()?.data!.data!.rollNumber}';
      String date = formattedDate;

      var queryParam =
          "/${SharedService.loginDetails()?.data?.data?.role}/${SharedService.loginDetails()?.data?.id}${ApiUrl.weekStudentAttendance}?class=$studentClass&section=$section&rollNumber=$rollNumber&date=$date";
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

// parent view childs  Monthly Attendance.........................................

  static Future<StudentMonthlyAttendanceModel> parentMonthlyAttendance(
    final String month,
    final String year,
  ) async {
    StudentMonthlyAttendanceModel MonthlyAttendance =
        StudentMonthlyAttendanceModel();
    try {
      // fetchChildData();
      String studentClass = '${SharedService.childDetails()?.data?.dataClass}';
      String section = '${SharedService.childDetails()?.data?.section}';
      String rollNumber = ' ${SharedService.childDetails()?.data?.rollNumber}';

      var queryParam =
          "/${SharedService.loginDetails()?.data?.data?.role}/${SharedService.loginDetails()?.data?.id}${ApiUrl.monthStudentAttendance}?class=$studentClass&section=$section&rollNumber=$rollNumber&month=$month&year=$year";
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

  static Future<StudentMonthlyAttendanceModel> StudentMonthlyAttendance(
    final String month,
    final String year,
  ) async {
    StudentMonthlyAttendanceModel MonthlyAttendance =
        StudentMonthlyAttendanceModel();
    try {
      String studentClass =
          '${SharedService.loginDetails()?.data!.data!.dataClass}';
      String section = '${SharedService.loginDetails()?.data!.data!.section}';
      String rollNumber =
          ' ${SharedService.loginDetails()?.data!.data!.rollNumber}';

      var queryParam =
          "/${SharedService.loginDetails()?.data?.data?.role}/${SharedService.loginDetails()?.data?.id}${ApiUrl.monthStudentAttendance}?class=$studentClass&section=$section&rollNumber=$rollNumber&month=$month&year=$year";
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

// parent view timetable
  static Future<StudentEachdayRoutineModel> parentViewEachDayRoutine() async {
    StudentEachdayRoutineModel studentDailyRoutine =
        StudentEachdayRoutineModel();
    try {
      // fetchChildData();
      String studentClass = '${SharedService.childDetails()?.data?.dataClass}';
      String section = '${SharedService.childDetails()?.data?.section}';

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
          '${SharedService.loginDetails()?.data!.data!.dataClass}';
      String section = '${SharedService.loginDetails()?.data!.data!.section}';

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

// Teacher see class routine Day wise....................................................

  static Future<StudentEachdayRoutineModel> TeacherSeeDayRoutine(
    String selectedClass,
    String selectedSection,
  ) async {
    StudentEachdayRoutineModel studentDailyRoutine =
        StudentEachdayRoutineModel();
    try {
      var queryParam =
          "${ApiUrl.dailyRoutine}?class=$selectedClass&section=$selectedSection";
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
    await ApiServices.childrenData(SharedService.loginDetails()
        ?.data!
        .data!
        .childrens![0]
        .toString() as String);
  }

// Parent View Children Assignment
  static Future<StudentViewAssignmentModel> parentViewAssignment() async {
    StudentViewAssignmentModel StudentCAttignment =
        StudentViewAssignmentModel();

    try {
      // fetchChildData();
      var rollNumber = SharedService.childDetails()?.data?.rollNumber;
      String studentClass = '${SharedService.childDetails()?.data?.dataClass}';
      String section = '${SharedService.childDetails()?.data?.section}';
      var queryParam =
          "${ApiUrl.parentViewPendingAssignment}/${SharedService.loginDetails()?.data?.id.toString()}/getPendingAssignment?class=$studentClass&section=$section";
      var response = await ApiBase.getRequest(
        extendedURL: queryParam,
      );

      log(response.statusCode.toString());
      log("RollNumber : ${rollNumber.toString()}");
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          StudentCAttignment =
              studentViewAssignmentModelFromJson(response.body);
        } else {
          log("else 2");
          StudentCAttignment = StudentViewAssignmentModel();
        }
      } else {
        log("else 2");
        StudentCAttignment = StudentViewAssignmentModel();
      }
    } catch (e) {
      log("Catch");
      StudentCAttignment = StudentViewAssignmentModel();
    }

    return StudentCAttignment;
  }

  static Future<StudentSubmittedAssignmentModel>
      parentViewSubmittedAssignment() async {
    StudentSubmittedAssignmentModel submittedAttignment =
        StudentSubmittedAssignmentModel();
    try {
      await ApiServices.childrenData(SharedService.loginDetails()
          ?.data!
          .data!
          .childrens![0]
          .toString() as String);
      String studentClass = '${SharedService.childDetails()?.data?.dataClass}';
      String section = '${SharedService.childDetails()?.data?.section}';
      var queryParam =
          "${ApiUrl.parentViewSubmittedAssignment}/${SharedService.loginDetails()?.data!.id.toString()}/studentseeSubmittedAssignment?class=$studentClass&section=$section";
      var response = await ApiBase.getRequest(
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

// Student view assignment (Pending) ...............................................................

  static Future<StudentViewAssignmentModel> StudentSeeAssignment() async {
    StudentViewAssignmentModel StudentCAttignment =
        StudentViewAssignmentModel();
    try {
      var rollNumber = SharedService.loginDetails()?.data!.data!.rollNumber;
      String studentClass =
          '${SharedService.loginDetails()?.data!.data!.dataClass}';
      String section = '${SharedService.loginDetails()?.data!.data!.section}';
      var queryParam =
          "${ApiUrl.studentPendingAssignment}/${SharedService.loginDetails()?.data!.id.toString()}/getPendingAssignment?class=$studentClass&section=$section";
      var response = await ApiBase.getRequest(
        extendedURL: queryParam,
      );

      log(response.statusCode.toString());
      log("RollNumber : ${rollNumber.toString()}");
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          StudentCAttignment =
              studentViewAssignmentModelFromJson(response.body);
        } else {
          log("else 2");
          StudentCAttignment = StudentViewAssignmentModel();
        }
      } else {
        log("else 2");
        StudentCAttignment = StudentViewAssignmentModel();
      }
    } catch (e) {
      log("Catch");
      StudentCAttignment = StudentViewAssignmentModel();
    }

    return StudentCAttignment;
  }

//.............Student Upload assignment..........................................

  static Future<bool> StudentUploadAssignment(
    String wclass,
    String section,
    String subject,
    String date,
    String rollNumber,
    File file,
    String assignMentID,
    BuildContext context,
  ) async {
    var ret = false;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "http://${ApiUrl.baseUrl}${ApiUrl.studentUploadAssignment}/${SharedService.loginDetails()?.data!.id}/uploadAssignmets/$assignMentID",
        ),
      );
      log("http://${ApiUrl.baseUrl}${ApiUrl.studentUploadAssignment}/${SharedService.loginDetails()?.data!.id}/uploadAssignmets/$assignMentID");

      // Add headers here
      Map<String, String> headers = {
        'Authorization':
            "${SharedService.loginDetails()?.data!.token}", // Replace with your token
      };

      request.headers.addAll(headers);

      request.fields['date'] = date;
      request.fields['class'] = wclass;
      request.fields['section'] = section;
      request.fields['subject'] = subject;
      request.fields['rollNumber'] = rollNumber;

      log("date= $date");
      log("class=$wclass");
      log("section=$section");
      log("subject=$subject");
      log("rollNumber=$rollNumber");

      if (file != null) {
        var fileStream = http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile(
          'file',
          fileStream.cast(),
          length,
          filename: p.basename(file.path),
        );
        request.files.add(multipartFile);
      }

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

//...................  Fees View........................................

  static Future<StudentFeesDetailsModel> viewFees() async {
    StudentFeesDetailsModel feeDetails = StudentFeesDetailsModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL: ApiUrl.studentFeeDetails,
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

// Student see his/her submitted assignment ....................................

  static Future<StudentSubmittedAssignmentModel>
      StudentSubmittedAssignment() async {
    StudentSubmittedAssignmentModel submittedAttignment =
        StudentSubmittedAssignmentModel();
    try {
      String studentClass =
          '${SharedService.loginDetails()?.data!.data!.dataClass}';
      String section = '${SharedService.loginDetails()?.data!.data!.section}';
      var queryParam =
          "${ApiUrl.studentSubmittedAssignment}/${SharedService.loginDetails()?.data!.id.toString()}/studentseeSubmittedAssignment?class=$studentClass&section=$section";
      var response = await ApiBase.getRequest(
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
  //         "${ApiUrl.teacherSeeSubmittedStudentsAssignments}/${SharedService.loginDetails()?.data!.id.toString()}/getAssignments/${assignmentID}?class=$wclass&section=$section";
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

//............ View School Gallery Parents ............................................

  static Future<ViewGalleryResponseModel> parentsViewSchoolGallery() async {
    ViewGalleryResponseModel viewGalModel = ViewGalleryResponseModel();
    try {
      // fetchChildData();
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.viewSchoolGallery}?schoolName=${SharedService.childDetails()?.data!.school}",
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
            "/${SharedService.loginDetails()?.data?.data?.role}/${SharedService.loginDetails()?.data?.id}${ApiUrl.viewSchoolGallery}?institutionId=${SharedService.loginDetails()?.data?.data?.institutionId}&schoolId=${SharedService.loginDetails()?.data?.data?.schoolId}",
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
  //..... View events Parents ......................................................

  static Future<StudentsViewEventsResponseModel> parentViewSchoolEvents(
    String status,
  ) async {
    StudentsViewEventsResponseModel viewEvents =
        StudentsViewEventsResponseModel();
    try {
      // fetchChildData();
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.viewSchoolEvents}?schoolName=${SharedService.childDetails()?.data?.school}&status=$status",
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
            "/teacher/${SharedService.loginDetails()?.data!.id}${ApiUrl.viewSchoolEvents}?schoolName=${SharedService.loginDetails()?.data!.data!.school}&status=$status&institutionId=${SharedService.loginDetails()?.data!.data!.institutionId}",
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

// Students View Awards/certificates.....................................................

  static Future<StudentViewAwardsResponseModel>
      parentsViewChildCertificates() async {
    StudentViewAwardsResponseModel myCertificates =
        StudentViewAwardsResponseModel();
    try {
      // fetchChildData();
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.studentViewAwards}/${SharedService.childDetails()?.data!.id}",
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

  static Future<StudentViewAwardsResponseModel> viewMyCertificates() async {
    StudentViewAwardsResponseModel myCertificates =
        StudentViewAwardsResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.studentViewAwards}/${SharedService.loginDetails()?.data!.id}",
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
      var schoolName = SharedService.loginDetails()?.data!.data!.school;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "http://${ApiUrl.baseUrl}${ApiUrl.teacherUploadAwards}",
        ),
      );

      // Add headers here
      Map<String, String> headers = {
        'Authorization':
            "${SharedService.loginDetails()?.data!.token}", // Replace with your token
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

  static Future<bool> updateMyAccountStudent(
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
            "${ApiUrl.updateMytAccountStudent}/${SharedService.loginDetails()?.data!.id}",
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

//update parent details
  static Future<bool> updateMyAccountParent(
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
            "${ApiUrl.updateMytAccountParent}/${SharedService.loginDetails()?.data!.id}",
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
            "${ApiUrl.updateMytAccountTeacher}/${SharedService.loginDetails()?.data!.id}",
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
      var stId = SharedService.loginDetails()?.data!.id;
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.studentEligibilityCheckForEnrollEvents}?eventId=$eventID&studentId=${SharedService.loginDetails()?.data!.id}",
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
      var studentID = SharedService.loginDetails()?.data!.id;
      var response = await ApiBase.postRequest(
        extendedURL: ApiUrl.studentRegisterEventPost,
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

  //.... View awards class wise Students List ( Teacher view)...................

  static Future<ClassWiseAwardsListOfStudentsResponseModel>
      classWiseAwardsListOfStudents(
          String selectedClass, String selectedSection) async {
    ClassWiseAwardsListOfStudentsResponseModel classWiseStudentsAwards =
        ClassWiseAwardsListOfStudentsResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.classWiseAwardsListOfStudents}?schoolName=${SharedService.loginDetails()?.data!.data!.school}&class=${selectedClass}&section=${selectedSection}",
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

  // Notice Student View Get.................................................

  static Future<ViewNoticeResponseModel> viewNoticeStudents() async {
    ViewNoticeResponseModel viewNotice = ViewNoticeResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.viewNoticeStudents}/${SharedService.loginDetails()?.data!.id}?schoolName=${SharedService.loginDetails()?.data!.data!.school}",
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
  // Verify read Unread notices Students...............................................

  static Future<bool> verifyReadUnreadNoticeStudents(String noticeID) async {
    var ret = false;
    try {
      var response = await ApiBase.putRequest(
        extendedURL:
            "${ApiUrl.verifyReadUnreadNoticeStudent}/${SharedService.loginDetails()!.data!.id}",
        body: {
          "schoolName": SharedService.loginDetails()!.data!.data!.school,
          "read": "true",
          "studentId": SharedService.loginDetails()!.data!.id,
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
            "${ApiUrl.viewNotice}/${SharedService.loginDetails()?.data?.id}?schoolName=${SharedService.childDetails()?.data?.school}",
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
            "${ApiUrl.verifyReadUnreadNoticeTeacher}/${SharedService.loginDetails()!.data!.data?.id.toString()}",
        body: {
          "schoolName": SharedService.loginDetails()!.data!.data!.school,
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

  static Future<TeacherNoticeResponseModel> viewNoticeTeacher() async {
    TeacherNoticeResponseModel viewNotice = TeacherNoticeResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.viewNoticeTeacher}/${SharedService.loginDetails()?.data!.id}?schoolName=${SharedService.loginDetails()?.data!.data!.school}",
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          viewNotice = teacherNoticeResponseModelFromJson(response.body);
        } else {
          viewNotice = TeacherNoticeResponseModel();
        }
      } else {
        viewNotice = TeacherNoticeResponseModel();
      }
    } catch (e) {
      viewNotice = TeacherNoticeResponseModel();
    }

    return viewNotice;
  }

  static Future<bool> verifyReadUnreadNoticeParent(String noticeID) async {
    var ret = false;
    try {
      var response = await ApiBase.putRequest(
        extendedURL:
            "${ApiUrl.verifyReadUnreadNoticeForParent}/${SharedService.loginDetails()?.data!.data?.id}",
        body: {
          "schoolName": SharedService.childDetails()?.data?.school,
          "read": "true",
          "parentId": SharedService.loginDetails()?.data?.id,
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
            "${ApiUrl.deleteNoticeTeacher}/${SharedService.loginDetails()!.data!.id}",
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
            "/teacher/${SharedService.loginDetails()!.data!.id}${ApiUrl.getRegisteredStudentListEvents}/$eventID",
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
      var studentID = SharedService.childDetails()?.data?.id;
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

/////////////////////////////////////////////////

  static Future<StudentMyEnrolledEventsResponseModel>
      studentSeeMyEnrolledEvents() async {
    StudentMyEnrolledEventsResponseModel myEnrolledEventsList =
        StudentMyEnrolledEventsResponseModel();
    try {
      var studentID = SharedService.loginDetails()?.data!.id;
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
      var schoolName = SharedService.loginDetails()?.data!.data!.school;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "http://${ApiUrl.baseUrl}${ApiUrl.teacherUploadNotice}",
        ),
      );

      // Add headers here
      Map<String, String> headers = {
        'Authorization': "${SharedService.loginDetails()?.data!.token}",
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

  // Student see own result GET api.................................................

  static Future<StudentResultResponseModel> parentSeeResult(
      String testType) async {
    StudentResultResponseModel result = StudentResultResponseModel();
    try {
      // fetchChildData();
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.studentSeeResult}/${SharedService.childDetails()?.data?.id}?examType=$testType&schoolName=${SharedService.childDetails()?.data?.school}",
      );
      log(response.statusCode.toString());

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

  // Student see own result GET api.................................................

  static Future<StudentResultResponseModel> studentSeeResult(
      String testType) async {
    StudentResultResponseModel result = StudentResultResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.studentSeeResult}/${SharedService.loginDetails()!.data!.id}?examType=$testType&schoolName=${SharedService.loginDetails()!.data!.data!.school}",
      );
      log(response.statusCode.toString());

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

  // view Exam Routine parent ..................................................
  static Future<ExamRoutineResponseModel> parentViewExamRoutine(
      String testType) async {
    ExamRoutineResponseModel examRoutine = ExamRoutineResponseModel();
    try {
      // fetchChildData();
      var selectedClass =
          SharedService.childDetails()!.data?.dataClass.toString();
      var school = SharedService.childDetails()!.data!.school;
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.viewExamRoutine}?schoolName=$school&class=$selectedClass&examType=$testType",
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
      String selectedClass, String testType) async {
    ExamRoutineResponseModel examRoutine = ExamRoutineResponseModel();
    try {
      var school = SharedService.loginDetails()!.data!.data!.school;
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.viewExamRoutine}?schoolName=$school&class=$selectedClass&examType=$testType",
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

// Teacher Upload exam routine (POST API)................................................

  static Future<bool> uploadExamRoutine(Map<String, dynamic> examData) async {
    var ret = false;
    try {
      var response = await ApiBase.postRequest(
        extendedURL: ApiUrl.uploadExamRoutine,
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
      Uri.parse("http://13.232.53.26:3000/deleteExam/$examId"),
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
      var school = SharedService.loginDetails()!.data!.data!.school;
      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.viewAboutSchool}?schoolName=${SharedService.childDetails()?.data?.school}",
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
      var school = SharedService.loginDetails()!.data!.data!.school;
      var response = await ApiBase.getRequest(
        extendedURL:
            "/${SharedService.loginDetails()?.data?.data?.role}/${SharedService.loginDetails()?.data?.id}${ApiUrl.viewAboutSchool}/?schoolName=$school&institutionId=${SharedService.loginDetails()?.data?.data?.institutionId}",
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