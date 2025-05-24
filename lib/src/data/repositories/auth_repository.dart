part of 'repositories.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository with DataStateConvertible implements IAuthRepository {
  final AuthApi _authApi;
  AuthRepository(this._authApi);

  @override
  Future<Either<Failure, BaseResponse<Auth>>> login(Map<String, dynamic> body) {
    return callApi(apiCall: () => _authApi.login(body));
  }

  @override
  Future<Either<Failure, BaseResponse<Auth>>> loginZalo(Map<String, dynamic> body) {
    return callApi(apiCall: () => _authApi.loginZalo(body));
  }

  @override
  Future<Either<Failure, BaseResponse<Auth>>> register(Map<String, dynamic> body) {
    return callApi(apiCall: () => _authApi.register(body));
  }

  @override
  Future<Either<Failure, BaseResponse<Auth>>> forgotPassword(Map<String, dynamic> body) {
    return callApi(apiCall: () => _authApi.forgotPassword(body));
  }

  @override
  Future<Either<Failure, BaseResponse>> logout() {
    return callApi(apiCall: () => _authApi.logout());
  }

  @override
  Future<Either<Failure, BaseResponse>> resendOTP(String phone) {
    return callApi(apiCall: () => _authApi.resendOTP(phone));
  }

  @override
  Future<Either<Failure, BaseResponse>> resetPassword(Map<String, dynamic> body) {
    return callApi(apiCall: () => _authApi.resetPassword(body));
  }

  @override
  Future<Either<Failure, BaseResponse>> updatePassword(Map<String, dynamic> body) {
    return callApi(apiCall: () => _authApi.updatePassword(body));
  }

  @override
  Future<Either<Failure, BaseResponse<AppUser>>> verifyOTP(Map<String, dynamic> body) {
    return callApi(apiCall: () => _authApi.verifyOTP(body));
  }

  @override
  Future<Either<Failure, BaseResponse>> deletePermanentUser(String password) {
    return callApi(apiCall: () => _authApi.deletePermanentUser(password));
  }
}
