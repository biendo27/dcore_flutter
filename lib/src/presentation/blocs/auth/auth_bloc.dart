// ignore_for_file: unnecessary_null_comparison, unused_local_variable

part of '../blocs.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> with BlocActionMixin<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;

  String? zaloRefreshToken;
  String zaloAccessToken = '';

  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<LoginEvent>(_onLogin);
    on<LoginZaloEvent>(loginWithZalo);
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
    await _performAction(
      emit,
      () async => _authRepository.login({
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

  void loginWithZalo(LoginZaloEvent event, Emitter<AuthState> emit) async {
    try {
      // Lấy refresh token từ Local Storage
      String? zaloRefreshToken = await LocalStoreService.getString(key: LocalStoreKey.zaloRefreshToken);

      // Gọi API đăng nhập của Zalo
      // final Map<dynamic, dynamic>? loginData = await ZaloFlutter.login(refreshToken: zaloRefreshToken);
      Map<dynamic, dynamic> loginData = {};

      if (loginData == null || loginData['isSuccess'] != true) {
        debugPrint("Zalo login failed: $loginData");
        return;
      }

      debugPrint("Zalo login data: $loginData");

      // Đọc dữ liệu từ phản hồi
      final data = loginData['data'] as Map<dynamic, dynamic>?;

      if (data == null) {
        debugPrint("Missing 'data' field in login response");
        return;
      }

      // Lấy accessToken và refreshToken từ phản hồi
      String? accessToken = data['accessToken'] as String?;
      String? refreshToken = data['refreshToken'] as String?;

      if (accessToken == null || refreshToken == null) {
        debugPrint("Missing tokens in Zalo login data");
        return;
      }

      // Lưu refresh token vào Local Storage
      await LocalStoreService.setString(key: LocalStoreKey.zaloRefreshToken, value: refreshToken);

      // Gán access token để sử dụng
      zaloAccessToken = accessToken;

      // Lấy thông tin người dùng từ Zalo
      // final Map<dynamic, dynamic>? getUser = await ZaloFlutter.getUserProfile(
      //   accessToken: zaloAccessToken,
      // );
      Map<dynamic, dynamic> getUser = {};

      if (getUser == null || getUser['data'] == null) {
        debugPrint("Failed to get user profile: $getUser");
        return;
      }

      debugPrint("Zalo user profile: $getUser");

      // Trích xuất thông tin người dùng với fallback nếu null
      final String zaloId = getUser["data"]?["id"]?.toString() ?? "222";
      final String name = getUser["data"]?["name"] ?? "ZaloAccount";
      final String phone = getUser["data"]["phone"] ?? "Unknown";
      final String image = getUser["data"]?["picture"]?["data"]?["url"] ?? "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/124.jpg";

      // Chuẩn bị payload gửi đến backend
      final payload = {
        'zalo_id': zaloId,
        'name': name,
        'image': image,
        'phone': phone,
        'device_token': await DeviceInfoService.deviceToken,
        'firebase_token': AppGlobalValue.firebaseToken,
      };

      debugPrint("Payload sent to backend: $payload");

      // Gọi hành động đăng nhập backend
      await _performAction(
        emit,
        () async => _authRepository.loginZalo(payload),
        onSuccess: (response) {
          // Xử lý khi đăng nhập thành công
          _handleSuccessfulAuth(response, emit);
          event.onSuccess?.call();
          debugPrint("Login successful");

          // Điều hướng tới màn hình chính
          Future.microtask(() => DNavigator.newRoutesNamed(RouteNamed.home));
        },
      );
    } catch (e, stacktrace) {
      // Bắt và log lỗi chi tiết
      debugPrint("Error during Zalo login: $e");
      debugPrint("Stacktrace: $stacktrace");
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    await _performAction(
      emit,
      () async => _authRepository.register({
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
    await executeEmptyAction(
      action: _authRepository.logout,
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
    await _performAction(
      emit,
      () => _authRepository.forgotPassword({'phone': event.phone}),
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
    await executeEmptyAction(
      setLoadingState: (state, {required bool isLoading}) => state.copyWith(isLoading: isLoading),
      action: () => _authRepository.resetPassword({
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
    executeEmptyAction(
      action: () => _authRepository.resendOTP(state.phone),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message);
        _setUserPhone(emit);
      },
      onFailure: (message) => emit(state.copyWith(phone: state.phone)),
    );
  }

  void _onVerifyOTP(VerifyOTPEvent event, Emitter<AuthState> emit) async {
    executeEmptyAction(
      action: () => _authRepository.verifyOTP({
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

  Future<void> _performAction<T>(
    Emitter<AuthState> emit,
    Future<BaseResponse<T>> Function() action, {
    Function(BaseResponse<T>)? onSuccess,
    Function()? onFailure,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await action();
      if (response.status && response.data != null) {
        onSuccess?.call(response);
      } else {
        onFailure?.call();
      }
    } catch (e) {
      LogDev.warning('Error: $e');
      onFailure?.call();
    } finally {
      emit(state.copyWith(isLoading: false));
    }
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
    await executeEmptyAction(
      action: () => _authRepository.deletePermanentUser(event.password),
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
    await executeEmptyAction(
      action: () => _authRepository.updatePassword({
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
