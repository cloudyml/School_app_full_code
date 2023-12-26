import 'dart:convert';
import 'package:school_management_system/Models/fetched_children_model.dart';
import '../Models/login_response_model.dart';
import '../constants/constants.dart';

class SharedService {
  static bool isLoggedIn() {
    return preferences!.getString("login_details") != null ? true : false;
  }

  static Future<void> setLoginDetails(LoginResponseModel? responseModel) async {
    if (responseModel != null) {
      preferences!
          .setString("login_details", jsonEncode(responseModel.toJson()));
    }
  }

  static LoginResponseModel? loginDetails() {
    if (preferences!.getString("login_details") != null) {
      return LoginResponseModel.fromJson(
          jsonDecode(preferences!.getString("login_details")!));
    } else {
      return null;
    }
  }

  static FetchedChildrenModel? childDetails() {
    if (preferences!.getString("child_detail") != null) {
      return FetchedChildrenModel.fromJson(
          jsonDecode(preferences!.getString("child_detail")!));
    } else {
      return null;
    }
  }

  static Future<void> setDetailsOfFetchedChild(
      FetchedChildrenModel? responseModel) async {
    if (responseModel != null) {
      preferences!
          .setString("child_detail", jsonEncode(responseModel.toJson()));
    }
  }

  static Future<bool> logout() async {
    await preferences!.clear();
    // preferences?.remove('login_details');
    return true;
  }

  static String userAuth() {
    var model = LoginResponseModel.fromJson(
        jsonDecode(preferences!.getString("login_details")!));
    return "Bearer ${model.data!.token!}";
  }
}
