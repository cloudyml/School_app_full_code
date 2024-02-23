class ApiUrl {
  static const String baseUrl = "13.232.53.26:3000";
  static const String login = "/login";
  static const String teacherlogin = "/login";
  static const String studentlogin = "/login";

// Attendance...................................................................
  static const String teacherSeeAttendanceOfWholeClassOfAday =
      "/totalAttendanceOfDay";
  static const String studentListForTakeAttendance =
      "/getStudentListforAttendance";
  static const String teacherSubmitAttendance = "/createAttendance";
  static const String weekStudentAttendance = "/getWeeklyAttendanceByName";
  static const String monthStudentAttendance = "/getMonthlyAttendanceByName";
  static const String dailyRoutine = "/getWeeklyTimeTable";
  static const String teacherUploadAssignment = "/createAssignment";
  static const String createAssignment = "/createAssignment";
  static const String studentPendingAssignment = "/student";
  static const String parentViewPendingAssignment = "/parent";
  static const String studentUploadAssignment = "/student";
  static const String teacherSeeOwnUploadedAssignments = "/getFileAssignments";
  static const String teacherSeeOwnUploadedTextAssignments =
      "/getTextAssignmentList";
  static const String teacherSeeSubmittedStudentsAssignments = "/teacher";
  static const String studentSubmittedAssignment = "/student";
  static const String parentViewSubmittedAssignment = "/student";
  static const String studentFeeDetails = "/getFees";
  static const String teacherUploadFees = "/addFees";
  static const String teacherUpdateFees = "/updateFees";
  static const String teacherDeleteFees = "/deleteFees";
  static const String teacherAttendanceSubmit = "/createAttendance";
  static const String uploadGallery = "/uploadGallery";
  static const String viewSchoolGallery = "/getGallery";
  static const String viewSchoolEvents = "/getEventsByStatus";

  static const String studentViewAwards = "/getAllAwards";
  static const String teacherUploadAwards = "/createAwards-teacher";

  // Update my account details..................................................
  static const String updateMytAccountStudent = "/updateStudentById";
  static const String updateMytAccountTeacher = "/updateTeacherById";
  static const String updateMytAccountParent = "/updateParent";

  //............................................................................
  static const String studentEligibilityCheckForEnrollEvents =
      "/verifyEventWithStudent";
  static const String studentRegisterEventPost = "/createEventRegister";

  // Awards....................................................................
  static const String getAllAwards = "/getAllAwards";
  static const String classWiseAwardsListOfStudents =
      "/getAllAwardListforSection";

  // Notice Students..................................................................

  static const String viewNoticeStudents = "/getAllNotice-student";
  static const String verifyReadUnreadNoticeStudent = "/notice-read-student";

// Notice Teacher.....................................................................
  static const String deleteNoticeTeacher = "/deleteNotice-teacher";
  static const String viewNoticeTeacher = "/getAllNotice-teacher";
  static const String verifyReadUnreadNoticeTeacher = "/notice-read-teacher";
  static const String viewNotice = "/getAllNotice-parent";
  static const String verifyReadUnreadNoticeForParent = "/notice-read-parent";

  // Notice parent...........................................................................
  static const String viewNoticeParent = "/getAllNotice-parent";

  // Eventts..........................................................................

  static const String getRegisteredStudentListEvents = "/getEventRegister";
  static const String studentSeeMyEnrolledEvents = "/getAllEventsOfStudents";
  static const String teacherUploadEvents = "/addEvent";

  // Notice.........................................................................

  static const String teacherUploadNotice = "/createNotice";

  // Result..........................................................................

  static const String studentSeeResult = "/studentSeeResult";
  static const String uploadResult = "/createResult-section";
  static const String teacherViewReqsultClassWise = "/getResult-section";
  static const String teacherUpadteResult = "/updateResultBySubjectId";
  static const String getDefaultDataForResult = "/get-default-data-for-result";
  static const String createDefaultData = "/createDefaultData";
  static const String getDefaultData = "/getDefaultData";

  // Exam........................................................................
  static const String deleteExamType = "/deleteExamType";

  //static const String viewExamRoutine = "/getExamDetails";
  static const String uploadExamRoutine = "/createExamSchedule";
  static const String getExamTypeList = "/getExamTypeList";
  static const String createExamTypeList = "/createExamTypeList";
  static const String deleteExam = "/deleteExam";

  //About School.................................................................

  static const String viewAboutSchool = "/getAbout-us";

  //children Data..................................................................
  static const String childrenDataById = "/getStudentfromParent";

  // dipen ji exam...............................................................
  static const String viewExamRoutine = "/getExamDetails";
  static const String createExamSchedule = "/createExamSchedule";
}
