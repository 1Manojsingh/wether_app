import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import 'design_utility.dart';

class AppUtils {


  static String? fieldEmpty(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return AppStrings.fieldCanNotBeEmpty;
    }
  }

  static String? passwordValidate(String? value) {
    if (value!.isNotEmpty) {
      if (value.length < 6) {
        return AppStrings.passwordValidation;
      } else {
        return null;
      }
    } else {
      return AppStrings.enterYourPassword;
    }
  }

  static String? confirmPasswordValidate(String? value, String newPassword) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterYourPassword;
    }
    if (value.length < 6) {
      return AppStrings.passwordValidation;
    }
    if (value != newPassword) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }

  static String? passwordValidateWithEquality(String? value, String? value2) {
    if (value!.isNotEmpty) {
      if (value.length < 6) {
        return AppStrings.passwordValidation;
      } else if (value != value2) {
        return AppStrings.passwordsNotMatch;
      } else {
        return null;
      }
    } else {
      return AppStrings.enterYourPassword;
    }
  }

  static String? phoneValidate(String? value) {
    if (value!.isNotEmpty) {
      if (value.length < 10 || value.length > 10) {
        return AppStrings.invalidPhoneNumber;
      } else {
        return null;
      }
    } else {
      return AppStrings.fieldCanNotBeEmpty;
    }
  }

  static void unfocusAll(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void showSnackBar(
    BuildContext? context, {
    String? message,
    Color color = Colors.black87,
    Icon? icon,
  }) {
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          icon ?? const SizedBox.shrink(),
          if (icon != null) horizontalSpaceTiny,
          Expanded(
            child: Text(message ?? AppStrings.somethingWentWrong,
                style: TextStyle(
                    color: color.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white)),
          )
        ],
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
    ));
  }


  static String convertTimestampToDateTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }
}
