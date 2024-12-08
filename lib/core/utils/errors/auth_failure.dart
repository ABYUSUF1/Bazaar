import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'failure.dart';

class AuthFailure extends Failure {
  AuthFailure(super.errMessage);

  factory AuthFailure.fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return AuthFailure(LocaleKeys.auth_AuthFailure_invalid_credential.tr());
      case 'email-already-in-use':
        return AuthFailure(
            LocaleKeys.auth_AuthFailure_email_already_in_use.tr());
      case 'invalid-email':
        return AuthFailure(LocaleKeys.auth_AuthFailure_invalid_email.tr());
      case 'user-disabled':
        return AuthFailure(LocaleKeys.auth_AuthFailure_user_disabled.tr());
      case 'user-not-found':
        return AuthFailure(LocaleKeys.auth_AuthFailure_user_not_found.tr());
      case 'wrong-password':
        return AuthFailure(LocaleKeys.auth_AuthFailure_wrong_password.tr());
      case 'account-exists-with-different-credential':
        return AuthFailure(LocaleKeys
            .auth_AuthFailure_account_exists_with_different_credential
            .tr());
      case 'user-cancelled':
        return AuthFailure(LocaleKeys.auth_AuthFailure_user_cancelled.tr());
      case 'network-request-failed':
        return AuthFailure(
            LocaleKeys.auth_AuthFailure_network_request_failed.tr());
      case 'too-many-requests':
        return AuthFailure(LocaleKeys.auth_AuthFailure_too_many_requests.tr());
      default:
        return AuthFailure(LocaleKeys.auth_AuthFailure_unexpected_error.tr());
    }
  }
}
