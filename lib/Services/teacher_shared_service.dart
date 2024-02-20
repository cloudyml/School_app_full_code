import 'dart:convert';
import 'package:school_management_system/Models/teacher_login_response_model.dart';
import 'package:school_management_system/constants/constants.dart';

class TeacherSharedServices {
  static Future<void> setLoginDetailsTeacher(
      TeacherLoginResponseModel? responseModel) async {
    if (responseModel != null) {
      preferences!
          .setString("login_details", jsonEncode(responseModel.toJson()));
    }
  }

  static bool isLoggedIn() {
    return preferences!.getString("login_details") != null ? true : false;
  }

  static TeacherLoginResponseModel? loginDetails() {
    if (preferences!.getString("login_details") != null) {
      return TeacherLoginResponseModel.fromJson(
          jsonDecode(preferences!.getString("login_details")!));
    } else {
      return null;
    }
  }

  static Future<void> updateMyAccountDetails({
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    String? address,
  }) async {
    var loginDetails = TeacherSharedServices.loginDetails();

    if (loginDetails != null) {
      if (name != null) loginDetails.data?.data?.name = name;
      if (email != null) loginDetails.data?.data?.email = email;
      if (phoneNumber != null) {
        loginDetails.data?.data?.phoneNumber = phoneNumber;
      }
      if (password != null) loginDetails.data?.data?.password = password;
      if (address != null) loginDetails.data?.data?.address = address;

      // Save the updated login details to shared preferences
      await setLoginDetailsTeacher(loginDetails);
    }
  }

  static Future<bool> logout() async {
    await preferences!.clear();
    preferences?.remove('login_details');
    return true;
  }

  static String userAuth() {
    var model = TeacherLoginResponseModel.fromJson(
        jsonDecode(preferences!.getString("login_details")!));
    return "Bearer ${model.data!.token!}";
  }
}
