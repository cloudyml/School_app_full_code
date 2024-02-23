import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:school_management_system/Models/Student/Events/view_events_response_model.dart';
import 'package:school_management_system/Models/Student/Fees/student_fee_response_model.dart';
import 'package:school_management_system/Models/Teacher/Attendance/view_attendance_of_class_response_model.dart';
import 'package:school_management_system/Models/Teacher/Awards/heading_wise_awards_list_response_model.dart';
import 'package:school_management_system/Models/Teacher/Events/upload_events_post_api_model.dart';
import 'package:school_management_system/Models/Teacher/Exam/teacher_see_list_of_exam_types_response_model.dart';
import 'package:school_management_system/Models/Teacher/Fees/delete_fees_model.dart';
import 'package:school_management_system/Models/Teacher/Fees/update_fees_model.dart';
import 'package:school_management_system/Models/Teacher/Fees/upload_fees_model.dart';
import 'package:school_management_system/Models/Teacher/Gallery/upload_gallery.dart';
import 'package:school_management_system/Models/Teacher/Homework/Text%20Homework/teacher_uploaded_text_assignments_response_model.dart';
import 'package:school_management_system/Models/Teacher/Homework/Upload/assignment_upload_model.dart';
import 'package:school_management_system/Models/Teacher/Homework/view%20file%20homework/teacher_see_own_assignments_list_response_model.dart';
import 'package:school_management_system/Models/Teacher/Notice/teacher_view_notice_response_model.dart';
import 'package:school_management_system/Models/Teacher/Result/Get%20models/class_wise_result_response_model.dart';
import 'package:school_management_system/Models/Teacher/Result/Get%20models/get_students_list_response_model.dart';
import 'package:school_management_system/Models/teacher_login_response_model.dart';
import 'package:school_management_system/Services/shared_services_parent_children.dart';
import 'package:school_management_system/Services/teacher_shared_service.dart';

import '../api_urls.dart';
import '../base_api_service.dart';

class TeacherApiServices {
// teacher login ....................................................................
  static Future<bool> teacherLogin(
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
          var responseModel = teacherLoginResponseModelFromJson(response.body);

          log(responseModel.message!);

          ret = true;

          await TeacherSharedServices.setLoginDetailsTeacher(responseModel)
              .whenComplete(() {
            SharedServiceParentChildren().userType(
                "${TeacherSharedServices.loginDetails()?.data?.data?.role}");
          });

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

// ***************************8******** Fees ***********************************

//................... Teacher View Fees.................................................

  static Future<StudentFeesDetailsModel> teacherViewFees() async {
    StudentFeesDetailsModel feeDetails = StudentFeesDetailsModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.studentFeeDetails}",
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
//........ Update Fees Teacher..................................................

  static Future<bool> updateFees(
    String feesID,
    String wClass,
    String admissionFees,
    String tuitionFees,
    String examinationFees,
    String libraryFees,
    String transportFees,
    String miscellaneousFees,
    String discountAmount,
  ) async {
    var ret = false;
    UpdateFeesDetailsModel updateFee = UpdateFeesDetailsModel();
    try {
      // Convert String values to int, or use a default value (0) if parsing fails.
      int admissionFeesInt = int.tryParse(admissionFees) ?? 0;
      int tuitionFeesInt = int.tryParse(tuitionFees) ?? 0;
      int examinationFeesInt = int.tryParse(examinationFees) ?? 0;
      int libraryFeesInt = int.tryParse(libraryFees) ?? 0;
      int transportFeesInt = int.tryParse(transportFees) ?? 0;
      int miscellaneousFeesInt = int.tryParse(miscellaneousFees) ?? 0;
      int discountAmountInt = int.tryParse(discountAmount) ?? 0;

      var response = await ApiBase.putRequest(
        extendedURL:
            "/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.teacherUpdateFees}/$feesID",
        body: {
          "class": wClass,
          "admissionFees": admissionFeesInt,
          "tuitionFees": tuitionFeesInt,
          "examinationFees": examinationFeesInt,
          "libraryFees": libraryFeesInt,
          "transportFees": transportFeesInt,
          "miscellaneousFees": miscellaneousFeesInt,
          "discountAmount": discountAmountInt,
        },
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          var responseModel = updateFeesDetailsModelFromJson(response.body);

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

//......................Teacher Upload Fees....................................

  static Future<bool> uploadFees(
    String wClass,
    String admissionFees,
    String tuitionFees,
    String examinationFees,
    String libraryFees,
    String transportFees,
    String miscellaneousFees,
    String discountFees,
  ) async {
    var ret = false;
    try {
      int admissionFeesInt = int.tryParse(admissionFees) ?? 0;
      int tuitionFeesInt = int.tryParse(tuitionFees) ?? 0;
      int examinationFeesInt = int.tryParse(examinationFees) ?? 0;
      int libraryFeesInt = int.tryParse(libraryFees) ?? 0;
      int transportFeesInt = int.tryParse(transportFees) ?? 0;
      int miscellaneousFeesInt = int.tryParse(miscellaneousFees) ?? 0;
      int discountFeesInt = int.tryParse(discountFees) ?? 0;
      var response = await ApiBase.postRequest(
        extendedURL:
            "/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.teacherUploadFees}",
        body: {
          "class": wClass,
          "admissionFees": admissionFeesInt,
          "tuitionFees": tuitionFeesInt,
          "examinationFees": examinationFeesInt,
          "libraryFees": libraryFeesInt,
          "transportFees": transportFeesInt,
          "miscellaneousFees": miscellaneousFeesInt,
          "discountAmount": discountFees,
        },
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          var responseModel = uploadFeesResponseModelFromJson(response.body);

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

// ............Teacher delete fees..............................................

  static Future<bool> deleteFees(
    String feesID,
  ) async {
    var ret = false;
    try {
      var response = await ApiBase.deleteRequest(
        extendedURL:
            "/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.teacherDeleteFees}/$feesID",
        body: {},
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == false) {
          var responseModel = deleteFeesDetailsModelFromJson(response.body);

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

  //......Teacher Upload File Assignments..................................................

  static Future<bool> TeacherUploadFileAssignment(
    String givenDate,
    String subjectDate,
    String wclass,
    String section,
    String subject,
    String topic,
    File file,
    BuildContext context,
  ) async {
    var ret = false;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "http://${ApiUrl.baseUrl}/teacher/${TeacherSharedServices.loginDetails()?.data!.id}${ApiUrl.teacherUploadAssignment}",
        ),
      );
      log("http://${ApiUrl.baseUrl}/teacher/${TeacherSharedServices.loginDetails()?.data!.id}${ApiUrl.teacherUploadAssignment}");
      // Added headers here
      Map<String, String> headers = {
        'Authorization':
            "${TeacherSharedServices.loginDetails()?.data!.token.toString()}",
      };
      request.headers.addAll(headers);

      request.fields['givenDate'] = givenDate;
      request.fields['lastDateOfSubmit'] = subjectDate;
      request.fields['class'] = wclass;
      request.fields['section'] = section;
      request.fields['subject'] = subject;
      request.fields['topic'] = topic;
      request.fields['schoolName'] =
          TeacherSharedServices.loginDetails()!.data!.token.toString();
      request.fields['institutionId'] = TeacherSharedServices.loginDetails()!
          .data!
          .data!
          .institutionId
          .toString();
      request.fields['schoolId'] =
          TeacherSharedServices.loginDetails()!.data!.data!.schoolId.toString();

      log("SubmitDate= $subjectDate");
      log("givendate= $givenDate");
      log("class=$wclass");
      log("section=$section");
      log("topic=$topic");
      log("subject=$subject");

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
          var teacherUploadassign =
              teacherAssignmentUploadModelFromJson(response.body);
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

//Teacher Upload Text Assignments................................................

  static Future<bool> TeacherUploadTextAssignment({
    required String classofStudent,
    required String section,
    required String subject,
    required String topic,
    required String givenDate,
    required String lastDateOfSubmit,
    required List textAssignmentList,
  }) async {
    var ret = false;
    String schooleName =
        TeacherSharedServices.loginDetails()!.data!.data!.schoolName.toString();
    String institutionId = TeacherSharedServices.loginDetails()!
        .data!
        .data!
        .institutionId
        .toString();
    String schoolId =
        TeacherSharedServices.loginDetails()!.data!.data!.schoolId.toString();
    try {
      var response = await ApiBase.postRequest(
        extendedURL:
            "/teacher/${TeacherSharedServices.loginDetails()?.data?.id}/createAssignment",
        body: {
          "institutionId": institutionId,
          "schoolId": schoolId,
          "schoolName": schooleName,
          "class": classofStudent,
          "section": section,
          "subject": subject,
          "topic": topic,
          "givenDate": givenDate,
          "lastDateOfSubmit": lastDateOfSubmit,
          "textAssignmentList": textAssignmentList,
        },
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 201) {
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

  // Teacher View Assignments his own uploaded assignments...................................................

  static Future<TeacherSeeOwnAssignmentsListModel>
      teacherSeeOwnGivenFileAssignment(
    String selectesClass,
    String selectesSection,
  ) async {
    TeacherSeeOwnAssignmentsListModel teacherGivenAssignment =
        TeacherSeeOwnAssignmentsListModel();
    try {
      var queryParam =
          "/teacher/${TeacherSharedServices.loginDetails()!.data!.id}${ApiUrl.teacherSeeOwnUploadedAssignments}?class=$selectesClass&section=$selectesSection&schoolId=${TeacherSharedServices.loginDetails()!.data!.data!.schoolId}&institutionId=${TeacherSharedServices.loginDetails()!.data!.data!.institutionId}";
      var response = await ApiBase.getRequest(
        extendedURL: queryParam,
      );

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          teacherGivenAssignment =
              teacherSeeOwnAssignmentsListModelFromJson(response.body);
        } else {
          log("else 2");
          teacherGivenAssignment = TeacherSeeOwnAssignmentsListModel();
        }
      } else {
        log("else 2");
        teacherGivenAssignment = TeacherSeeOwnAssignmentsListModel();
      }
    } catch (e) {
      log("Catch");
      teacherGivenAssignment = TeacherSeeOwnAssignmentsListModel();
    }

    return teacherGivenAssignment;
  }

  // Teacher View Assignments his own uploaded assignments...................................................

  static Future<TeacherUploadedTextAssignmentResponseModel>
      teacherSeeOwnGivenTextAssignment(
    String selectesClass,
    String selectesSection,
  ) async {
    TeacherUploadedTextAssignmentResponseModel teacherGivenAssignment =
        TeacherUploadedTextAssignmentResponseModel();
    try {
      var queryParam =
          "/teacher/${TeacherSharedServices.loginDetails()!.data!.id}${ApiUrl.teacherSeeOwnUploadedTextAssignments}?class=$selectesClass&section=$selectesSection&schoolId=${TeacherSharedServices.loginDetails()!.data!.data!.schoolId}&institutionId=${TeacherSharedServices.loginDetails()!.data!.data!.institutionId}";
      var response = await ApiBase.getRequest(
        extendedURL: queryParam,
      );

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          teacherGivenAssignment =
              teacherUploadedTextAssignmentResponseModelFromJson(response.body);
        } else {
          log("else 2");
          teacherGivenAssignment = TeacherUploadedTextAssignmentResponseModel();
        }
      } else {
        log("else 2");
        teacherGivenAssignment = TeacherUploadedTextAssignmentResponseModel();
      }
    } catch (e) {
      log("Catch");
      teacherGivenAssignment = TeacherUploadedTextAssignmentResponseModel();
    }

    return teacherGivenAssignment;
  }

// Gallery Teacher Upload ...................................................
  static Future<bool> teacherUploadGallery(
    List<XFile> files,
  ) async {
    var ret = false;

    try {
      String? schoolName =
          TeacherSharedServices.loginDetails()?.data?.data?.schoolName;
      String? schoolId =
          TeacherSharedServices.loginDetails()?.data?.data?.schoolId;
      String? institutionId =
          TeacherSharedServices.loginDetails()?.data?.data?.institutionId;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "http://${ApiUrl.baseUrl}/teacher/${TeacherSharedServices.loginDetails()?.data!.id}${ApiUrl.uploadGallery}",
        ),
      );
      log(
        "http://${ApiUrl.baseUrl}/teacher/${TeacherSharedServices.loginDetails()?.data!.id}${ApiUrl.uploadGallery}",
      );

      // Add headers here
      Map<String, String> headers = {
        'Authorization': "${TeacherSharedServices.loginDetails()?.data!.token}",
      };
      request.headers.addAll(headers);

      // Add your string to the request body
      request.fields['schoolName'] = schoolName!;
      request.fields['institutionId'] = institutionId!;
      request.fields['schoolId'] = schoolId!;

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

      log(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
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

  // Get Students List for result...................................................

  static Future<GetStudentListForResultResponseModel> StudentListForResult(
      String selectedClass, String selectSection) async {
    GetStudentListForResultResponseModel studentList =
        GetStudentListForResultResponseModel();
    try {
      var queryParam =
          "/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.getDefaultDataForResult}?institutionId=${TeacherSharedServices.loginDetails()?.data!.data?.institutionId}&schoolId=${TeacherSharedServices.loginDetails()?.data?.data?.schoolId}&class=$selectedClass&section=$selectSection";
      var response = await ApiBase.getRequest(
        extendedURL: queryParam,
      );
      log(response.statusCode.toString());

      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          studentList =
              getStudentListForResultResponseModelFromJson(response.body);
        } else {
          log("else 2");
          studentList = GetStudentListForResultResponseModel();
        }
      } else {
        log("else 2");
        studentList = GetStudentListForResultResponseModel();
      }
    } catch (e) {
      log("Catch");
      studentList = GetStudentListForResultResponseModel();
    }

    return studentList;
  }

  // Teacher see List of Exam Type...................................................

  static Future<TeacherSeeExamTypesResponseModel>
      teacherSeeListOfExamTypes() async {
    TeacherSeeExamTypesResponseModel examTypes =
        TeacherSeeExamTypesResponseModel();
    try {
      var queryParam =
          "/teacher/${TeacherSharedServices.loginDetails()?.data?.id}/getExamTypeList?institutionId=${TeacherSharedServices.loginDetails()?.data?.data?.institutionId}&schoolId=${TeacherSharedServices.loginDetails()?.data?.data?.schoolId}";
      var response = await ApiBase.getRequest(
        extendedURL: queryParam,
      );
      log(response.statusCode.toString());

      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          log("success");
          examTypes = teacherSeeExamTypesResponseModelFromJson(response.body);
        } else {
          log("else 2");
          examTypes = TeacherSeeExamTypesResponseModel();
        }
      } else {
        log("else 2");
        examTypes = TeacherSeeExamTypesResponseModel();
      }
    } catch (e) {
      log("Catch");
      examTypes = TeacherSeeExamTypesResponseModel();
    }

    return examTypes;
  }

  // Teacher create List of Exam Type

  static Future<bool> teacherCreateExamType(
    context, {
    required String classofStudent,
    required List examTypeList,
  }) async {
    var ret = false;
    String schoolName =
        TeacherSharedServices.loginDetails()!.data!.data!.schoolName.toString();
    String institutionId = TeacherSharedServices.loginDetails()!
        .data!
        .data!
        .institutionId
        .toString();
    String schoolId =
        TeacherSharedServices.loginDetails()!.data!.data!.schoolId.toString();
    String id = TeacherSharedServices.loginDetails()!.data!.id.toString();
    try {
      var response = await ApiBase.postRequest(
        extendedURL: "/teacher/$id/createExamTypeList",
        body: {
          "institutionId": institutionId,
          "schoolId": schoolId,
          "schoolName": schoolName,
          "class": classofStudent,
          "examTypeList": examTypeList,
        },
      );
      log("${response.statusCode.toString()}");
      log("${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          showSnackbar(context, message: jsonDecode(response.body)['message']);
          ret = true;
        } else {
          ret = false;
          showSnackbar(context, message: jsonDecode(response.body)['message']);
          log("Not Successful");
        }
      } else {
        showSnackbar(context, message: jsonDecode(response.body)['message']);
        ret = false;
        log("Not Successful");
      }
    } catch (e) {
      log("error: $e");
    }
    return ret;
  }

  // Teacher post grading data

  static Future<bool> teacherPostGradingData(
    context, {
    required examType,
    required selectedClass,
    required selectedSection,
    required passingMarks,
    required totalMarks,
    required gradingCriteria,
  }) async {
    var ret = false;
    String schoolName =
        TeacherSharedServices.loginDetails()!.data!.data!.schoolName.toString();
    String institutionId = TeacherSharedServices.loginDetails()!
        .data!
        .data!
        .institutionId
        .toString();
    String schoolId =
        TeacherSharedServices.loginDetails()!.data!.data!.schoolId.toString();
    String id = TeacherSharedServices.loginDetails()!.data!.data!.id.toString();
    try {
      var response = await ApiBase.postRequest(
        extendedURL: "/teacher/$id/result${ApiUrl.createDefaultData}",
        body: {
          "institutionId": institutionId,
          "schoolId": schoolId,
          "schoolName": schoolName,
          "examType": examType,
          "class": selectedClass,
          "section": selectedSection,
          "gradingSystem": {
            "marksList": {
              "passingMarks": passingMarks,
              "outOffMarks": totalMarks
            },
            "gradingCriteria": gradingCriteria
          }
        },
      );
      log("${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          showSnackbar(context, message: jsonDecode(response.body)['message']);
          ret = true;
        } else {
          ret = false;
          showSnackbar(context, message: jsonDecode(response.body)['message']);
        }
      } else {
        showSnackbar(context, message: jsonDecode(response.body)['message']);
        ret = false;
      }
    } catch (e) {
      log("error: $e");
    }
    return ret;
  }

  // Teacher Post result.....................................................

  static Future<bool> uploadResultAllStudents(
      List resultData,
      String selectedClass,
      String section,
      String examType,
      String subect) async {
    var ret = false;
    try {
      var response = await ApiBase.postRequest(
        extendedURL:
            "/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.uploadResult}",
        body: {
          "class": selectedClass,
          "section": section,
          "subject": subect,
          "examType": examType,
          "studentList": resultData
        },
      );

      log(response.statusCode.toString());

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

  //........ Teacher Upload Events.....................................................

  static Future<bool> teacherUploadEvents(
    String eventName,
    String description,
    String date,
    String eventTime,
    String status,
    String eligibleClass,
    String remark,
    List<XFile> files,
  ) async {
    var ret = false;

    try {
      String? schoolName =
          TeacherSharedServices.loginDetails()?.data!.data!.schoolName;
      String? instituteId =
          TeacherSharedServices.loginDetails()?.data!.data!.institutionId;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "http://${ApiUrl.baseUrl}/teacher/${TeacherSharedServices.loginDetails()?.data!.id}${ApiUrl.teacherUploadEvents}",
        ),
      );

      // Add headers
      Map<String, String> headers = {
        'Authorization':
            "Bearer ${TeacherSharedServices.loginDetails()?.data!.token}", // Assuming 'Bearer' is required for the token
      };
      request.headers.addAll(headers);

      // Add form fields
      request.fields['schoolName'] = schoolName!;
      request.fields['eventName'] = eventName;
      request.fields['description'] = description;
      request.fields['date'] = date;
      request.fields['eventTime'] = eventTime;
      request.fields['status'] = status;
      request.fields['remark'] = remark;
      request.fields['eligibleClass'] = eligibleClass;
      request.fields['institutionId'] = instituteId!;
      // Add files
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

      var response = await request.send();
      log("http://${ApiUrl.baseUrl}${ApiUrl.teacherUploadEvents}");
      log(response.statusCode.toString());
      log("");
      log(schoolName);
      log(eventName);
      log(description);
      log(date);
      log(eventTime);
      log(status);
      log(remark);
      log(eligibleClass);
      log(files.length.toString());

      if (response.statusCode == 200) {
        var jsonResponse = await response.stream.bytesToString();
        var teacherUploadGal = teacherUploadEventsModelFromJson(jsonResponse);

        if (teacherUploadGal.status == true) {
          ret = true;
        } else {
          log("API returned a failure status.");
        }
      } else {
        var jsonResponse = await response.stream.bytesToString();
        var teacherUploadGal = teacherUploadEventsModelFromJson(jsonResponse);
        log("Error mesaage = ${teacherUploadGal.message.toString()}");
        log("API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      log("API request failed with an exception: $e");
    }

    return ret;
  }

  // View Events Teacher...........................................................

  static Future<StudentsViewEventsResponseModel> teacherViewSchoolEvents(
    String status,
  ) async {
    StudentsViewEventsResponseModel viewEvents =
        StudentsViewEventsResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "/teacher/${TeacherSharedServices.loginDetails()?.data!.id}${ApiUrl.viewSchoolEvents}?schoolName=${TeacherSharedServices.loginDetails()?.data!.data!.schoolName}&status=$status&institutionId=${TeacherSharedServices.loginDetails()?.data!.data!.institutionId}",
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

  //................... Teacher Update About school..........................................

  static Future<bool> teacherUpdateAboutUs(
    String schoolAddress,
    String websiteLink,
    String schoolEmailId,
    String aboutSchool,
    String coreValues,
    String principalOffice,
    String admissionDepartment,
    String enquiryDepartment,
    File rulesAndRegulation,
    File profilePic,
    File coverPic,
    BuildContext context,
  ) async {
    var ret = false;

    try {
      var schoolName =
          TeacherSharedServices.loginDetails()?.data!.data!.schoolName;
      var teacherId = TeacherSharedServices.loginDetails()?.data!.id;
      var schoolId = TeacherSharedServices.loginDetails()?.data!.data!.schoolId;
      var institutionId =
          TeacherSharedServices.loginDetails()?.data!.data!.institutionId;
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
          "http://13.232.53.26:3000/teacher/$teacherId/update-us/$schoolId",
        ),
      );

      // Add headers here
      Map<String, String> headers = {
        'Authorization': "${TeacherSharedServices.loginDetails()?.data!.token}",
      };
      request.headers.addAll(headers);

      request.fields['schoolName'] = schoolName!;
      request.fields['schoolAddress'] = schoolAddress;
      request.fields['websiteLink'] = websiteLink;
      request.fields['schoolEmailId'] = schoolEmailId;
      request.fields['aboutSchool'] = aboutSchool;
      request.fields['coreValues'] = coreValues;
      request.fields['principalOffice'] = principalOffice;
      request.fields['admissionDepartment'] = admissionDepartment;
      request.fields['enquiryDepartment'] = enquiryDepartment;
      request.fields['institutionId'] = institutionId!;

      log("SchoolName=$schoolName");
      log("http://13.232.53.26:3000/teacher/$teacherId/update-us/$schoolId");

      // Add rulesAndRegulation file
      var rulesAndRegulationStream =
          http.ByteStream(rulesAndRegulation.openRead());
      var rulesAndRegulationLength = await rulesAndRegulation.length();
      var rulesAndRegulationMultipartFile = http.MultipartFile(
        'rulesAndRegulation',
        rulesAndRegulationStream.cast(),
        rulesAndRegulationLength,
        filename: p.basename(rulesAndRegulation.path),
      );
      request.files.add(rulesAndRegulationMultipartFile);

      // Add profilePic file
      var profilePicStream = http.ByteStream(profilePic.openRead());
      var profilePicLength = await profilePic.length();
      var profilePicMultipartFile = http.MultipartFile(
        'profilePic',
        profilePicStream.cast(),
        profilePicLength,
        filename: p.basename(profilePic.path),
      );
      request.files.add(profilePicMultipartFile);

      // Add coverPic file
      var coverPicStream = http.ByteStream(coverPic.openRead());
      var coverPicLength = await coverPic.length();
      var coverPicMultipartFile = http.MultipartFile(
        'coverPic',
        coverPicStream.cast(),
        coverPicLength,
        filename: p.basename(coverPic.path),
      );
      request.files.add(coverPicMultipartFile);

      var response = await http.Response.fromStream(await request.send());

      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200) {
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

  // Teacher View result class wise.............................................

  static Future<ClassWiseResultResponseModel> teacherViewResultClassWise(
      String selectedClass, String selectedSection, String examType) async {
    ClassWiseResultResponseModel studentList = ClassWiseResultResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "/${TeacherSharedServices.loginDetails()?.data?.data?.role}/${TeacherSharedServices.loginDetails()?.data!.id}${ApiUrl.teacherViewReqsultClassWise}?examType=$examType&class=$selectedClass&section=$selectedSection",
      );
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        studentList = classWiseResultResponseModelFromJson(response.body);
      } else {
        studentList = ClassWiseResultResponseModel();
      }
    } catch (e) {
      studentList = ClassWiseResultResponseModel();
    }

    return studentList;
  }

//..... Teacher Update Marks Subject wise and Test Type wise by Student Id.........

  static Future<bool> teacherUpdateResult({
    required String marks,
    required String subject,
    required String resultId,
    required String studentId,
  }) async {
    var ret = false;
    try {
      var response = await ApiBase.putRequest(
        extendedURL:
            "/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.teacherUpadteResult}/$resultId/$studentId",
        body: {
          "subject": subject,
          "marks": marks,
        },
      );
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
          TeacherSharedServices.loginDetails()?.data!.data!.schoolName;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "http://${ApiUrl.baseUrl}/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.teacherUploadAwards}",
        ),
      );

      // Add headers here
      Map<String, String> headers = {
        'Authorization':
            "${TeacherSharedServices.loginDetails()?.data!.token}", // Replace with your token
      };
      request.headers.addAll(headers);

      request.fields['certificationDate'] = date;
      request.fields['class'] = wclass;
      request.fields['section'] = section;
      request.fields['studentName'] = studentName;
      request.fields['rollNumber'] = rollNumber;
      request.fields['certificationHeading'] = certificationHeading;
      request.fields['schoolName'] = schoolName!;

      log(
        "http://${ApiUrl.baseUrl}/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.teacherUploadAwards}",
      );
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

      if (response.statusCode == 201) {
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

  //.... View awards class wise Students List ( Teacher view)...................

  static Future<HeadingWiseAwardsListOfStudentsResponseModel>
      awardsListOfStudents() async {
    HeadingWiseAwardsListOfStudentsResponseModel awardList =
        HeadingWiseAwardsListOfStudentsResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.getAllAwards}",
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          awardList = headingWiseAwardsListOfStudentsResponseModelFromJson(
              response.body);
        } else {
          awardList = HeadingWiseAwardsListOfStudentsResponseModel();
        }
      } else {
        awardList = HeadingWiseAwardsListOfStudentsResponseModel();
      }
    } catch (e) {
      awardList = HeadingWiseAwardsListOfStudentsResponseModel();
    }

    return awardList;
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
      var schoolName =
          TeacherSharedServices.loginDetails()?.data!.data!.schoolName;
      var institutionId =
          TeacherSharedServices.loginDetails()?.data!.data!.institutionId;
      var schoolId = TeacherSharedServices.loginDetails()?.data!.data!.schoolId;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "http://${ApiUrl.baseUrl}/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.teacherUploadNotice}",
        ),
      );

      // Add headers here
      Map<String, String> headers = {
        'Authorization': "${TeacherSharedServices.loginDetails()?.data!.token}",
      };
      request.headers.addAll(headers);

      request.fields['heading'] = noticeNeading;
      request.fields['description'] = noticeDescription;
      request.fields['date'] = noticeDate;
      request.fields['schoolName'] = schoolName!;
      request.fields['institutionId'] = institutionId!;
      request.fields['schoolId'] = schoolId!;

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

  // Verify read Unread notices Teacher...............................................

  static Future<bool> verifyReadUnreadNoticeTeacher(String noticeID) async {
    var ret = false;
    try {
      var response = await ApiBase.putRequest(
        extendedURL:
            "/teacher/${TeacherSharedServices.loginDetails()!.data?.id}${ApiUrl.verifyReadUnreadNoticeTeacher}",
        body: {
          "schoolName":
              TeacherSharedServices.loginDetails()!.data!.data!.schoolName,
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

  // Teacher Notice get.........................................................
  static Future<TeacherNoticeResponseModel> viewNoticeTeacher() async {
    TeacherNoticeResponseModel viewNotice = TeacherNoticeResponseModel();
    try {
      var response = await ApiBase.getRequest(
        extendedURL:
            "/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.viewNoticeTeacher}",
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

  //Delete Notice Teacher .......................................................
  static Future<bool> deleteNoticeTeacher(
    String noticeID,
  ) async {
    var ret = false;
    try {
      var response = await ApiBase.deleteRequest(
        extendedURL:
            "/teacher/${TeacherSharedServices.loginDetails()!.data!.id}${ApiUrl.deleteNoticeTeacher}",
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
            "/teacher/${TeacherSharedServices.loginDetails()?.data?.id}${ApiUrl.teacherSeeAttendanceOfWholeClassOfAday}?class=$selectedClass&section=$selectedSection&date=$selectedDate",
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
}

void showSnackbar(context, {message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text('$message'),
      duration: const Duration(seconds: 2),
    ),
  );
}
