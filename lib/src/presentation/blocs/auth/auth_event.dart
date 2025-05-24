part of '../blocs.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String phone;
  final String password;
  final void Function()? onSuccess;

  LoginEvent({this.phone = '', this.password = '', this.onSuccess});
}

class RegisterEvent extends AuthEvent {
  final String phone;
  final String password;
  final String passwordConfirm;

  RegisterEvent({this.phone = '', this.password = '', this.passwordConfirm = ''});
}

class LogoutEvent extends AuthEvent {}

class LoginZaloEvent extends AuthEvent {
  final void Function()? onSuccess;
  LoginZaloEvent({ this.onSuccess});
}

class ForgotPasswordEvent extends AuthEvent {
  final String phone;

  ForgotPasswordEvent({this.phone = ''});
}

class ResetPasswordEvent extends AuthEvent {
  final String password;
  final String passwordConfirm;

  ResetPasswordEvent({this.password = '', this.passwordConfirm = ''});
}

class ResendOTPEvent extends AuthEvent {}

class VerifyOTPEvent extends AuthEvent {
  final String otp;

  VerifyOTPEvent({this.otp = ''});
}

class ChangePasswordEvent extends AuthEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordEvent({this.oldPassword = '', this.newPassword = '', this.confirmPassword = ''});
}

class DeleteAccountPermanentlyEvent extends AuthEvent {
  final String password;

  DeleteAccountPermanentlyEvent({this.password = ''});
}
