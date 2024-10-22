import 'package:flutter/material.dart';

class UserAuthenticationProvider extends ChangeNotifier {
  // =========== Password Visibility for LoginScreen ============== //
  bool isObscured = true;

  void passwordVisibility() {
    isObscured = !isObscured;
    notifyListeners();
  }

  // =========== User role selection for Signup screen ============== //
  String selectedRole = "";

  void roleSelection(value) {
    selectedRole = value;
    notifyListeners();
  }

  // =========== Signup/Login Loading Indicator ============== //
  bool isLoading = false;
  void showIndicator() {
    isLoading = true;
    notifyListeners();
  }

  void hideIndicator() {
    isLoading = false;
    notifyListeners();
  }
}
