import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class AuthValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return LocaleKeys.auth_validator_email_required.tr();
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return LocaleKeys.auth_validator_invalid_email.tr();
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return LocaleKeys.auth_validator_password_required.tr();
    }
    if (password.length < 8) {
      return LocaleKeys.auth_validator_password_too_short.tr();
    }
    if (password.length > 15) {
      return LocaleKeys.auth_validator_password_too_long.tr();
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return LocaleKeys.auth_validator_confirm_password_required.tr();
    }
    if (password != confirmPassword) {
      return LocaleKeys.auth_validator_passwords_do_not_match.tr();
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return LocaleKeys.auth_validator_username_required.tr();
    }
    if (username.length < 3) {
      return LocaleKeys.auth_validator_username_too_short.tr();
    }
    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return LocaleKeys.auth_validator_phone_number_required.tr();
    }

    // Example regex for validating phone numbers (adjust as needed)
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$'); // E.164 format
    if (!phoneRegex.hasMatch(phoneNumber)) {
      return LocaleKeys.auth_validator_phone_number_invalid.tr();
    }

    return null;
  }

  static String? validateBirthday(String? birthday) {
    if (birthday == null || birthday.isEmpty) {
      return LocaleKeys.auth_validator_birthday_required.tr();
    }

    try {
      // Parse the date string
      DateTime date = DateFormat('yyyy-MM-dd').parse(birthday);
      DateTime today = DateTime.now();

      // Check if the date is in the future
      if (date.isAfter(today)) {
        return LocaleKeys.auth_validator_birthday_future.tr();
      }

      // Check if the user is at least 18 years old
      //   int age = today.year - date.year;
      //   if (today.month < date.month || (today.month == date.month && today.day < date.day)) {
      //     age--;
      //   }
      //   if (age < 18) {
      //     return LocaleKeys.auth_validator_birthday_age_limit.tr();
      //   }
    } catch (e) {
      return LocaleKeys.auth_validator_birthday_invalid.tr();
    }

    return null;
  }
}
