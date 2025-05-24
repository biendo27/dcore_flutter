part of '../blocs.dart';

class AuthState {
  final bool isLoading;
  final VerifyType type;
  final String phone;

  const AuthState({
    this.isLoading = false,
    this.type = VerifyType.verifyAccount,
    this.phone = '',
  });

  AuthState copyWith({
    bool? isLoading,
    VerifyType? type,
    String? phone,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      type: type ?? this.type,
      phone: phone ?? this.phone,
    );
  }
}

enum VerifyType {
  verifyAccount,
  resetPassword;

  String get value {
    return switch (this) {
      VerifyType.verifyAccount => 'verify_account',
      VerifyType.resetPassword => 'reset_password',
    };
  }
}
