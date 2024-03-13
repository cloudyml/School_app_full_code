import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
SharedPreferences ?preferences;

void showSnackBar(String message, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ),
  );
}

