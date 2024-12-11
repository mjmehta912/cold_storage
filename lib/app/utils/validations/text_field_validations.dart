import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Validate {
  /// EMAIL ID VALIDATION
  static emailValidation(BuildContext context, String v) {
    if (v.trim().isEmpty) {
      return kEmptyEmail;
    } else if (!v.isEmail) {
      return kValidEmail;
    } else {
      return null;
    }
  }

  /// PHONE NUMBER VALIDATION
  static phoneValidation(BuildContext context, String v) {
    if (v.trim().isEmpty) {
      return kEmptyPhone;
    } else if (!v.isPhoneNumber) {
      return kValidPhone;
    } else {
      return null;
    }
  }

  /// NAME VALIDATION
  static nameValidation(BuildContext context, String v) {
    if (v.isEmpty) {
      return kEmptyName;
    } else {
      return null;
    }
  }

  /// PASSWORD VALIDATION
  static passwordValidation(BuildContext context, String v) {
    if (v.isEmpty) {
      return kEmptyPassword;
    } else {
      return null;
    }
  }

  /// OTP VALIDATION
  static otpValidation(BuildContext context, String v) {
    if (v.trim().isEmpty) {
      return kEmptyOtp;
    } else if (v.length != 6) {
      return kValidOtp;
    } else {
      return null;
    }
  }
}
