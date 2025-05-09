part of 'repositories.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, BaseResponse<Auth>>> login(Map<String, dynamic> body);
  Future<Either<Failure, BaseResponse<Auth>>> loginZalo(Map<String, dynamic> body);
  Future<Either<Failure, BaseResponse<Auth>>> register(Map<String, dynamic> body);
  Future<Either<Failure, BaseResponse>> logout();
  Future<Either<Failure, BaseResponse<Auth>>> forgotPassword(Map<String, dynamic> body);
  Future<Either<Failure, BaseResponse>> resetPassword(Map<String, dynamic> body);
  Future<Either<Failure, BaseResponse>> resendOTP(String phone);
  Future<Either<Failure, BaseResponse<AppUser>>> verifyOTP(Map<String, dynamic> body);
  Future<Either<Failure, BaseResponse>> updatePassword(Map<String, dynamic> body);
  Future<Either<Failure, BaseResponse>> deletePermanentUser(String password);
}
