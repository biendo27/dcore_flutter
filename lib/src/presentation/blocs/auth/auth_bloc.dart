// ignore_for_file: unnecessary_null_comparison, unused_local_variable

part of '../blocs.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> with BlocUseCaseHandlerMixin<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;
  final RegisterUsecase _registerUsecase;
  final LogoutUsecase _logoutUsecase;
  final ForgotPasswordUsecase _forgotPasswordUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;
  final ResendOtpUsecase _resendOtpUsecase;
  final VerifyOtpUsecase _verifyOtpUsecase;
  final UpdatePasswordUsecase _updatePasswordUsecase;
  final DeletePermanentUserUsecase _deletePermanentUserUsecase;

  String? zaloRefreshToken;
  String zaloAccessToken = '';

  AuthBloc(
    this._loginUsecase,
    this._registerUsecase,
    this._logoutUsecase,
    this._forgotPasswordUsecase,
    this._resetPasswordUsecase,
    this._resendOtpUsecase,
    this._verifyOtpUsecase,
    this._updatePasswordUsecase,
    this._deletePermanentUserUsecase,
  ) : super(const AuthState()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ResetPasswordEvent>(_onResetPassword);
    on<ResendOTPEvent>(_onResendOTP);
    on<VerifyOTPEvent>(_onVerifyOTP);
    on<ChangePasswordEvent>(_onChangePassword);
    on<DeleteAccountPermanentlyEvent>(_onDeleteAccountPermanently);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(phone: event.phone));
    await executeUseCase(
      usecase: () async => _loginUsecase({
        'phone': event.phone,
        'password': event.password,
        'device_token': await DeviceInfoService.deviceToken,
        'firebase_token': AppGlobalValue.firebaseToken,
      }),
      onSuccess: (response) {
        _handleSuccessfulAuth(response, emit);
        event.onSuccess?.call();
        Future.microtask(() => DNavigator.newRoutesNamed(RouteNamed.home));
      },
    );
  }

  Future<void> initZaloFlutter() async {
    if (Platform.isAndroid) {
      // final String? hashKey = await ZaloFlutter.getHashKeyAndroid();
      // debugPrint('HashKey: $hashKey');
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    await executeUseCase(
      usecase: () async => _registerUsecase({
        'phone': event.phone,
        'password': event.password,
        'password_confirmation': event.passwordConfirm,
        'device_token': await DeviceInfoService.deviceToken,
        'firebase_token': AppGlobalValue.firebaseToken,
      }),
      onSuccess: (response) {
        _handleSuccessfulAuth(response, emit);
        emit(state.copyWith(
          type: VerifyType.verifyAccount,
          phone: event.phone,
        ));
        Future.microtask(() => DNavigator.pushReplacementNamed(RouteNamed.otp));
      },
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await executeEmptyUseCase(
      usecase: _logoutUsecase.call,
      setLoadingState: (state, {required bool isLoading}) => state.copyWith(isLoading: isLoading),
      onSuccess: (response) {
        AppGlobalValue.accessToken = '';
        AppConfig.context
          ?..read<PageCubit>().setCurrentIndex(0)
          ..read<UserCubit>().clearData();
        AppService.resetDI();
        emit(const AuthState());
        Future.microtask(() => DNavigator.newRoutesNamed(RouteNamed.login));
      },
    );
  }

  Future<void> _onForgotPassword(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    await executeUseCase(
      usecase: () async => _forgotPasswordUsecase({'phone': event.phone}),
      onSuccess: (response) {
        _handleSuccessfulAuth(response, emit);
        emit(state.copyWith(
          type: VerifyType.resetPassword,
          phone: event.phone,
        ));
        Future.microtask(() => DNavigator.pushReplacementNamed(RouteNamed.otp));
      },
    );
  }

  Future<void> _onResetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    await executeEmptyUseCase(
      usecase: () async => _resetPasswordUsecase({
        'phone': state.phone,
        'password': event.password,
        'password_confirmation': event.passwordConfirm,
      }),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message);
        Future.microtask(() => DNavigator.newRoutesNamed(RouteNamed.login));
      },
    );
  }

  Future<void> _onResendOTP(ResendOTPEvent event, Emitter<AuthState> emit) async {
    executeEmptyUseCase(
      usecase: () async => _resendOtpUsecase(state.phone),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message);
        _setUserPhone(emit);
      },
      onFailure: (message) => emit(state.copyWith(phone: state.phone)),
    );
  }

  void _onVerifyOTP(VerifyOTPEvent event, Emitter<AuthState> emit) async {
    executeEmptyUseCase(
      usecase: () async => _verifyOtpUsecase({
        'type': state.type.value,
        'phone': state.phone,
        'otp': event.otp,
      }),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message);

        if (state.type == VerifyType.verifyAccount) {
          Future.microtask(() => DNavigator.newRoutesNamed(RouteNamed.login));
        } else {
          Future.microtask(() => DNavigator.pushReplacementNamed(RouteNamed.setupPassword));
        }
      },
    );
  }

  void _handleSuccessfulAuth(BaseResponse<Auth> response, Emitter<AuthState> emit) {
    final Auth auth = response.data!;
    AppGlobalValue.accessToken = auth.accessToken;
    AppConfig.context!.read<UserCubit>()
      ..setUser(auth.user)
      ..setAuthData(auth.accessToken);
    _setUserPhone(emit);

    DMessage.showMessage(message: response.message);
  }

  void _setUserPhone(Emitter<AuthState> emit) {
    if (state.phone.isEmpty) {
      String phone = AppConfig.context!.read<UserCubit>().state.user.phone;
      emit(state.copyWith(phone: phone));
    }
  }

  FutureOr<void> _onDeleteAccountPermanently(DeleteAccountPermanentlyEvent event, Emitter<AuthState> emit) async {
    await executeEmptyUseCase(
      usecase: () async => _deletePermanentUserUsecase(event.password),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message);
        AppGlobalValue.accessToken = '';
        AppConfig.context
          ?..read<PageCubit>().setCurrentIndex(0)
          ..read<UserCubit>().clearData();
        AppService.resetDI();
        emit(const AuthState());
        Future.microtask(() => DNavigator.newRoutesNamed(RouteNamed.login));
      },
    );
  }

  FutureOr<void> _onChangePassword(ChangePasswordEvent event, Emitter<AuthState> emit) async {
    await executeEmptyUseCase(
      usecase: () async => _updatePasswordUsecase({
        'current_password': event.oldPassword,
        'password': event.newPassword,
        'password_confirmation': event.confirmPassword,
      }),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message);
        DNavigator.back();
        DNavigator.back();
      },
      setLoadingState: (state, {required bool isLoading}) => state.copyWith(isLoading: isLoading),
    );
  }
}
